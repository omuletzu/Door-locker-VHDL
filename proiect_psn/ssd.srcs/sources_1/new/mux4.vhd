library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity mux4 is
    Port(s : in std_logic_vector(1 downto 0);
         d0, d1, d2, d3 : in std_logic_vector(3 downto 0);
         anod : out std_logic_vector(3 downto 0));
end mux4;

architecture Behavioral of mux4 is

begin

    anod <= d3 when s = "11" else
            d2 when s = "10" else
            d1 when s = "01" else
            d0;

end Behavioral;
