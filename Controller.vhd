library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Controller is
Port ( 
opcode: in std_logic_vector (5 downto 0);
func : in std_logic_vector (5 downto 0);
ALUSrc,RegDst,RegWrite,RegWrite2,MemRead,MemWrite,MemtoReg,PCSrc : out std_logic; 
ALUOp : out std_logic_vector (3 downto 0)
);
end Controller;

architecture Behavioral of Controller is

begin

process (opcode,func)
begin

if opcode = "000000" and func = "100000" then  -- add
         ALUSrc <= '0'; RegDst <= '1';RegWrite <= '1';RegWrite2 <= '0';MemRead <= '0';MemWrite <= '0';MemtoReg <= '0';PCSrc <= '0'; ALUOp <= "0000";
      end if; 

 if opcode = "000000" and func = "100010" then  -- sub
         ALUSrc <= '0'; RegDst <= '1'; RegWrite <= '1'; RegWrite2 <= '0'; MemRead <= '0'; MemWrite <= '0'; MemtoReg <= '0'; PCSrc <= '0'; ALUOp <= "0001";
      end if; 

if opcode = "011100" and func = "000010" then -- mul
         ALUSrc <= '0'; RegDst <= '1'; RegWrite <= '1'; RegWrite2 <= '0'; MemRead <= '0'; MemWrite <= '0'; MemtoReg <= '0'; PCSrc <= '0'; ALUOp <= "0010";
      end if;
      
      if opcode = "000000" and func = "100100" then  -- and
         ALUSrc <= '0'; RegDst <= '1'; RegWrite <= '1'; RegWrite2 <= '0'; MemRead <= '0'; MemWrite <= '0'; MemtoReg <= '0'; PCSrc <= '0'; ALUOp <= "0011";
      end if; 
      
      if opcode = "000000" and func = "100101" then  -- or 
         ALUSrc <= '0'; RegDst <= '1'; RegWrite <= '1'; RegWrite2 <= '0'; MemRead <= '0'; MemWrite <= '0'; MemtoReg <= '0'; PCSrc <= '0'; ALUOp <= "0100";
      end if;
      
      if opcode = "000000" and func = "101010" then -- slt
         ALUSrc <= '0'; RegDst <= '1'; RegWrite <= '1'; RegWrite2 <= '0'; MemRead <= '0'; MemWrite <= '0'; MemtoReg <= '0'; PCSrc <= '0'; ALUOp <= "0101";
      end if;
      
      if opcode = "000000" and func = "111001" then -- set equal
         ALUSrc <= '0'; RegDst <= '1'; RegWrite <= '1'; RegWrite2 <= '0'; MemRead <= '0'; MemWrite <= '0'; MemtoReg <= '0'; PCSrc <= '0'; ALUOp <= "0110";
      end if;
      
      if opcode = "000000" and func = "111010" then -- set not equal
         ALUSrc <= '0'; RegDst <= '1'; RegWrite <= '1'; RegWrite2 <= '0'; MemRead <= '0'; MemWrite <= '0'; MemtoReg <= '0'; PCSrc <= '0'; ALUOp <= "0111";
      end if;
      
      if opcode = "000000" and func = "000000" then -- sll
         ALUSrc <= '1'; RegDst <= '1'; RegWrite <= '1'; RegWrite2 <= '1'; MemRead <= '0'; MemWrite <= '0'; MemtoReg <= '0'; PCSrc <= '0'; ALUOp <= "1000";
      end if;
      
      if opcode = "000000" and func = "000010" then -- srl
         ALUSrc <= '1'; RegDst <= '1'; RegWrite <= '1'; RegWrite2 <= '1'; MemRead <= '0'; MemWrite <= '0'; MemtoReg <= '0'; PCSrc <= '0'; ALUOp <= "1001";
      end if;
      
      if opcode = "000000" and func = "000110" then -- rotrv
         ALUSrc <= '0'; RegDst <= '1'; RegWrite <= '1'; RegWrite2 <= '0'; MemRead <= '0'; MemWrite <= '0'; MemtoReg <= '0'; PCSrc <= '0'; ALUOp <= "1010";
      end if;
      
      if opcode = "011100" and func = "100001" then -- clo
         ALUSrc <= '0'; RegDst <= '1'; RegWrite <= '1'; RegWrite2 <= '0'; MemRead <= '0'; MemWrite <= '0'; MemtoReg <= '0'; PCSrc <= '0'; ALUOp <= "1011";
      end if;
      
      if opcode = "011100" and func = "100000" then -- clz
         ALUSrc <= '0'; RegDst <= '1'; RegWrite <= '1'; RegWrite2 <= '0'; MemRead <= '0'; MemWrite <= '0'; MemtoReg <= '0'; PCSrc <= '0'; ALUOp <= "1100";
      end if;
      
      if opcode = "001000" then -- addi
         ALUSrc <= '1'; RegDst <= '0'; RegWrite <= '1'; RegWrite2 <= '0'; MemRead <= '0'; MemWrite <= '0'; MemtoReg <= '0'; PCSrc <= '0'; ALUOp <= "0000";
      end if;
      
      if opcode = "001101" then -- ori
         ALUSrc <= '1'; RegDst <= '0'; RegWrite <= '1'; RegWrite2 <= '0'; MemRead <= '0'; MemWrite <= '0'; MemtoReg <= '0'; PCSrc <= '0'; ALUOp <= "0100";
      end if;
      end process;
      end Behavioral;
