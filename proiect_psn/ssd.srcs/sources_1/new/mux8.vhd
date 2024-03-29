library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_1164.ALL;

entity mux8 is
  Port (s : in std_logic_vector(1 downto 0);
        d0, d1, d2, d3 : in std_logic_vector(6 downto 0);
        catod : out std_logic_vector(6 downto 0));
end mux8;

architecture Behavioral of mux8 is

signal a0 : std_logic_vector(6 downto 0) := d0;
signal a1 : std_logic_vector(6 downto 0) := d1;
signal a2 : std_logic_vector(6 downto 0) := d2;
signal a3 : std_logic_vector(6 downto 0) := d3;

begin

    catod <= a3 when s = "11" else
              a2 when s = "10" else
              a1 when s = "01" else
              a0;

end Behavioral;
