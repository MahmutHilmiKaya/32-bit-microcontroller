

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.NUMERIC_STD.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity PCAdder is
port(PCResult : in std_logic_vector(31 downto 0);
PCAddResult : out std_logic_vector(31 downto 0)
);
end PCAdder;

architecture Behavioral of PCAdder is

begin
PCAddResult <= (std_logic_vector(unsigned(PCResult))) + 4;

end Behavioral;
