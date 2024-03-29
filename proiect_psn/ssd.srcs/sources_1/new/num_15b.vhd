library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity num_15b is
  Port (clk : in std_logic;
        output : out std_logic_vector(14 downto 0));
end num_15b;

architecture Behavioral of num_15b is

signal aux : std_logic_vector(14 downto 0) := (others => '0');

begin

    process(clk)
    begin
        if clk'event and clk = '1' then aux <= aux + 1;
        end if;
        
        output <= aux;
    end process;
end Behavioral;
