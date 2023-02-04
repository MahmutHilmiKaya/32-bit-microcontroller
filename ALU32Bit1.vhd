library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU32Bit1 is
port( 
        A,B : in std_logic_vector(31 downto 0); --input operands
        ALUControl : in std_logic_vector(3 downto 0); --Operation to be performed
        ALUResult : out std_logic_vector(31 downto 0);  --output of ALU
          ZERO : out std_logic
        );
end ALU32Bit1;

architecture Behavioral of ALU32Bit1 is

begin


process(ALUControl, A, B)
    variable temp: std_logic_vector(31 downto 0);
    variable count: integer range 0 to 31;
begin
      case ALUControl is
            when "0000" => 
                 temp := A + B;    --addition
            when "0001" => 
                 temp := A - B;    --subtraction
            when "0010" =>
                 temp := std_logic_vector(to_signed((to_integer(unsigned(A)) * to_integer(unsigned(B))),32));
            when "0011" => 
                 temp := A and B;  --AND gate  
            when "0100" => 
                 temp := A or B;   --OR gate                 
            when "0101" => 
                 if A < B then     --SLT (set on less than) gate
                     temp   := (others => '1');
                     else
                     temp   := (others => '0');
                 end if;
             when "0110" => 
                 if A = B then     --set equal
                     temp   := (others => '1');
                     else
                     temp   := (others => '0');
                 end if;
             when "0111" => 
                 if A /= B then     --set not equal gate
                     temp   := (others => '1');
                     else
                     temp   := (others => '0');
                 end if;
              when "1000" => -- Logical shift left
                      temp := std_logic_vector(signed(A) sll to_integer(signed(B)));
              when "1001" => -- Logical shift right
                      temp := std_logic_vector(signed(A) srl to_integer(signed(B)));
              when "1010" => -- Rotate right
                      temp := std_logic_vector(signed(A) ror to_integer(signed(B)));
                      when "1011" => -- Clo
                      for i in 0 to 31 loop
                               if (A(i) = '1') then
                               count := count + 1;
                               end if;
                      end loop;
                      temp := std_logic_vector(to_unsigned(count, temp'length));
              when "1100" => -- Clz
                      for i in A'Range loop
                          case A(i) is
                               when '0' => count := count + 1;
                               when others => exit;
                          end case;
                      end loop;
                      temp := std_logic_vector(to_unsigned(count, temp'length));     
             when others =>
                 NULL;
      end case; 
             if temp  = (31 downto 0=>'0') then
                ZERO <= '1';
                else
                ZERO <= '0';
            end if;
            ALUResult <= temp;

end process;    

end Behavioral;