library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity data_memory is
Port ( 
Address, WriteData : in std_logic_vector (31 downto 0);
MemWrite: in std_logic;
MemRead: in std_logic;
clk : in std_logic;
ReadData: out std_logic_vector (31 downto 0)
);
end data_memory;

architecture Behavioral of data_memory is

type datamemory is array(0 to 1023) of std_logic_vector(31 downto 0);
signal data_mem : datamemory:= (others => (others => '0'));

begin
datamem : process (clk) is
  begin
    if rising_edge(clk) then
      if MemWrite = '1' then
         data_mem(to_integer(unsigned(Address(11 downto 2)))) <= WriteData;
      end if;
      end if;
      if falling_edge(clk) then
          if MemRead = '1' then
           ReadData <= data_mem(to_integer(unsigned(Address(11 downto 2))));
          else
           ReadData <= x"00000000";
          end if;
     end if;
  end process;

end Behavioral;