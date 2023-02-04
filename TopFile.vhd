library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TopFile is
Port (Anode_Activate1 : out STD_LOGIC_VECTOR (3 downto 0);
LED_out1 : out STD_LOGIC_VECTOR (6 downto 0);
clk,reset : in std_logic
--outdata : out std_logic_vector(15 downto 0); -- used for the post synthesis sim
--ALUOut : out std_logic_vector(15 downto 0) -- used for the post synthesis sim
);
end TopFile;

architecture Behavioral of TopFile is

     component RegisterFile is
               port ( 
                  ReadRegister1,ReadRegister2,WriteRegister  : in std_logic_vector (4 downto 0);
                  WriteData : in std_logic_vector (31 downto 0);
                  RegWrite,RegWrite2 : in std_logic;
                  clk : in std_logic;
                  ReadData1,ReadData2 : out std_logic_vector (31 downto 0)
                  );
               end component; 
            
     component ALU32Bit1 is
               port(  
                  A,B : in std_logic_vector(31 downto 0); 
                  ALUControl : in std_logic_vector(3 downto 0); 
                  ALUResult : out std_logic_vector(31 downto 0); 
                  ZERO : out std_logic
                    );
               end component;     
               
     component InstructionMemory is
                port ( 
                  Address : in std_logic_vector (31 downto 0);
                  Instruction : out std_logic_vector (31 downto 0)
                     );
               end component;   
               
     component Mux32Bit2to1 is
                port (
                 I0, I1 : in std_logic_vector(31 downto 0);
                 F : out std_logic_vector(31 downto 0);
                 S : in std_logic
                     ); 
               end component;   
            
     component Mux5to1 is
                port (
                 I0, I1 : in std_logic_vector(4 downto 0);
                 F : out std_logic_vector(4 downto 0);
                 S : in std_logic
                     ); 
               end component;           
        
     component PCAdder is
                port ( 
                 PCResult: in std_logic_vector (31 downto 0);
                 PCAddResult: out std_logic_vector (31 downto 0)
                      );
               end component;  
               
     component ProgramCounter is
                port ( 
                  address: in std_logic_vector(31 downto 0);
                  Reset, clk: in std_logic;
                  PCResult: out std_logic_vector(31 downto 0)
                      );
               end component;                        
            
      component SignExtension is
                port ( 
                  Input : in std_logic_vector(15 downto 0);
                  RegWrite2 : in std_logic;
                  Output : out std_logic_vector(31 downto 0)
                      );
               end component;     
               
      component data_memory is
                port ( 
                  Address, WriteData : in std_logic_vector (31 downto 0);
                  MemWrite: in std_logic;
                  MemRead: in std_logic;
                  clk : in std_logic;
                  ReadData: out std_logic_vector (31 downto 0)
                     );
               end component;    
               
      component Controller is
                port ( 
                  opcode: in std_logic_vector (5 downto 0);
                  func : in std_logic_vector (5 downto 0);
                  ALUSrc,RegDst,RegWrite,RegWrite2,MemRead,MemWrite,MemtoReg,PCSrc : out std_logic; 
                  ALUOp : out std_logic_vector (3 downto 0)
                      );
                end component;          
                     
      component ShiftLeft2 is 
                port ( 
                  input : in std_logic_vector(31 downto 0);
                  output : out std_logic_vector(31 downto 0));
                end component;           
                
      component Adder is 
                port(
                   A,B : in std_logic_vector(31 downto 0);
                   AddResult : out std_logic_vector(31 downto 0));
                end component;
component fourdigit is port(clock_100Mhz : in STD_LOGIC;-- 100Mhz clock on Basys 3 FPGA board
         reset : in STD_LOGIC; -- reset
          input : in std_logic_vector(15 downto 0);
          Anode_Activate : out STD_LOGIC_VECTOR (3 downto 0);-- 4 Anode signals
          LED_out : out STD_LOGIC_VECTOR (6 downto 0));
end component;
component Clockdiv is port (clk,reset: in std_logic;
clock_out: out std_logic
);
end component;

signal Instruction : std_logic_vector (31 downto 0);                
signal sgnO : std_logic_vector (31 downto 0);
signal ReadData1, ReadData2 : std_logic_vector (31 downto 0);
signal BALU : std_logic_vector (31 downto 0);

signal WriteData1 : std_logic_vector (31 downto 0);
signal ReadDatamem : std_logic_vector (31 downto 0);
-- controller output
signal ALUSrc,RegDst,RegWrite,RegWrite2,MemRead,MemWrite,MemtoReg,PCSrc : std_logic;
signal ALUOp : std_logic_vector (3 downto 0); 
--
signal ALUResult : std_logic_vector (31 downto 0);
signal ZERO : std_logic;

signal SL2out : std_logic_vector(31 downto 0); 
signal PCout : std_logic_vector (31 downto 0);
signal PCAddResult : std_logic_vector (31 downto 0);    
signal AddResult : std_logic_vector (31 downto 0);
signal PCin : std_logic_vector (31 downto 0);
signal WriteRegister : std_logic_vector (4 downto 0);    
signal clk_t : std_logic;      
begin

C1 : InstructionMemory port map(
Address => PCout,
Instruction => Instruction
);

C2 : RegisterFile port map (
ReadRegister1 => Instruction (25 downto 21),
ReadRegister2 => Instruction (20 downto 16),
WriteRegister => WriteRegister, 
WriteData => WriteData1,
RegWrite => RegWrite,
RegWrite2 => RegWrite2,
clk => clk_t,
ReadData1 => ReadData1,
ReadData2 => ReadData2);

C3 : Mux32Bit2to1 port map (
I0 => ReadData2, 
I1 => sgnO,
S => ALUSrc,
F => BALU);

C4 : ALU32Bit1 port map (
A => ReadData1,
B => BALU,
ALUControl => ALUOp,
ALUResult => ALUResult,
ZERO => ZERO);

C5 : SignExtension port map (
Input => Instruction (15 downto 0),
RegWrite2 => RegWrite2,
Output => sgnO );

C6 : data_memory port map (
Address => ALUResult, 
WriteData => ReadData2,
MemWrite => MemWrite,
MemRead => MemRead,
clk => clk_t,
ReadData => ReadDatamem);

C7 : Mux32Bit2to1 port map (
I0 => ALUResult, 
I1 => ReadDatamem,
S => MemtoReg,
F => WriteData1);

C8 : ShiftLeft2 port map (
input => sgnO,
output => SL2out );

C9 : Adder port map (
A => PCAddResult,
B => SL2out,
AddResult => AddResult);

C10 : ProgramCounter port map (
address => PCin,
Reset => reset,
clk => clk_t,
PCResult => PCout);

C11 : PCAdder port map (
PCResult => PCout,
PCAddResult => PCAddResult);

C12 : Mux32Bit2to1 port map (
I0 => PCAddResult, 
I1 => AddResult,
S => PCSrc,
F => PCin);

C13 : Mux5to1 port map (
I0 => Instruction (20 downto 16),
I1 => Instruction (15 downto 11),
F  => WriteRegister,
S => RegDst);

C14 : Controller port map (
opcode => Instruction(31 downto 26),
func => Instruction (5 downto 0),
ALUSrc => ALUSrc,
RegDst => RegDst,
RegWrite => RegWrite,
RegWrite2 => RegWrite2,
MemRead => MemRead,
MemWrite => MemWrite,
MemtoReg => MemtoReg,
PCSrc => PCSrc,
ALUOp => ALUOp
);
c15 : fourdigit port map(
clock_100Mhz => clk,
reset => reset ,
input =>  Writedata1(15 downto 0), 
Anode_Activate => Anode_Activate1, -- 4 Anode signals
LED_out => LED_out1);
c16 : Clockdiv port map (
clk => clk,
reset => reset,
clock_out => clk_t);
--outdata <= WriteData1(15 downto 0); -- used for the post synthesis sim
--ALUOut <= ALUResult (15 downto 0); -- used for the post synthesis sim

end Behavioral;