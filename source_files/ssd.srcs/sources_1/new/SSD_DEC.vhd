library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SSD_DEC is
  Port(nr1, nr2, nr3, nr4, nr5, q : in std_logic_vector(3 downto 0);
       init1, init2, init3, init4, init5 : in std_logic;
       clk : in std_logic;
       anod : in std_logic_vector(3 downto 0);
       liber_ocupat : in std_logic;
       on_off : in std_logic;
       catod : out std_logic_vector(6 downto 0));
end SSD_DEC;

architecture Behavioral of SSD_DEC is

signal aux : std_logic_vector(6 downto 0);
signal nr : std_logic_vector(3 downto 0);
signal s1, s2, s3, s4 : std_logic := '0';

begin

    process(clk)
    begin
    if clk'event and clk = '1' then
            case anod is
                when "1110" => 
                    if liber_ocupat = '0' then 
                        if init1 = '0' then nr <= q;
                        else nr <= nr1;  end if;
                    else    
                        if init4 = '0' then nr <= q;  
                        else nr <= nr4;  end if; 
                    end if;
                when "1101" =>
                    if liber_ocupat = '0' then 
                        if init2 = '0' then nr <= q;
                        else nr <= nr2;   end if;
                    else    
                        if init5 = '0' then nr <= q;  
                        else nr <= nr5;   end if; 
                    end if;
                when "1011" =>
                    if liber_ocupat = '0' then 
                        if init3 = '0' then nr <= q;
                        else nr <= nr3;   end if;
                    else    
                        nr <= q;  
                    end if;
                when others =>
            end case;
            
            case nr is
                when x"0" =>  aux <= "1111110";
   	 		    when x"1" =>  aux <= "0110000";
    			when x"2" =>  aux <= "1101101";
    			when x"3" =>  aux <= "1111001";
    			when x"4" =>  aux <= "0110011";
    			when x"5" =>  aux <= "1011011";
    			when x"6" =>  aux <= "1011111";
    			when x"7" =>  aux <= "1110000";
    			when x"8" =>  aux <= "1111111";
    			when x"9" =>  aux <= "1111011";
    			when x"A" =>  aux <= "1110111";
    			when x"B" =>  aux <= "0011111";
    			when x"C" =>  aux <= "1001110";
    			when x"D" =>  aux <= "0111101";
    			when x"E" =>  aux <= "1001111";
    			when others => aux <= "1000111";
            end case;
            
            catod <= not aux;
            
            case anod is
                when "1110" =>
                when "1101" =>
                    if (init1 = '0' and liber_ocupat = '0') or (init4 = '0' and liber_ocupat = '1') then catod <= "1111111"; 
                    end if;
                when "1011" =>
                    if (init2 = '0' and liber_ocupat = '0') or (init5 = '0' and liber_ocupat = '1') then catod <= "1111111"; 
                    end if;
                when others =>
                    catod <= "1111111"; 
            end case;
            
            if on_off = '0' then catod <= "1111111";
            end if;
    end if;
    end process;

end Behavioral;
