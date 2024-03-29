----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/29/2024 02:36:21 PM
-- Design Name: 
-- Module Name: Comparator_4b - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Comparator_4b is
    PORT(clk : in std_logic;
	    a : in std_logic_vector(3 downto 0);
		b : in std_logic_vector(3 downto 0);
		egal : out std_logic);
end Comparator_4b;

architecture Behavioral of Comparator_4b is

begin

    process(clk)
    begin
    
        if(rising_edge(clk)) then
            if(a = b) then
                egal <= '1';
            else
                egal <= '0';
            end if;
        end if;
        
    end process;

end Behavioral;
