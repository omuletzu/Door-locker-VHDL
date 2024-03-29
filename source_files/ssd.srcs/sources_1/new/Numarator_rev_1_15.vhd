library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Numarator_rev_1_15 is
    PORT(en_up : in std_logic;
  		en_down : in std_logic;
  		load : in std_logic;
  		clk : in std_logic;
  		q : out std_logic_vector(3 downto 0));
end Numarator_rev_1_15;

architecture Behavioral of Numarator_rev_1_15 is

    signal counter : std_logic_vector(3 downto 0) := (others => '0');

begin

    process(clk)
    begin
    
        if(rising_edge(clk)) then
            if(load = '1') then
                counter <= (others => '0');
            else
                if(en_up = '1' and en_down = '0') then
                    counter <= counter + 1;
                else
                    counter <= counter - 1;
                end if;
            end if;
        end if;
    
    end process;

    q <= counter;

end Behavioral;
