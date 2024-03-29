library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Registru_4b is
   port(d : in std_logic_vector(3 downto 0);
	    mem_cif : in std_logic;
		clk : in std_logic;
		q : out std_logic_vector(3 downto 0);
		reset : in std_logic;
		init : out std_logic);
end Registru_4b;

architecture Behavioral of Registru_4b is

signal aux : std_logic_vector(3 downto 0);

begin

    process(clk)
    begin
        if clk'event and clk = '1' then
            if mem_cif = '1' then 
                aux <= d;
                init <= '1';
            end if;
        
            if aux = "UUUU" or reset = '1' then 
                aux <= x"0";
                init <= '0';
   	        end if;
		
		    q <= aux;
		end if;
    end process;

end Behavioral;
