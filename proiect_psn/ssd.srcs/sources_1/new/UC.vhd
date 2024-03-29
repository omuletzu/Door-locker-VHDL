LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY UC IS
	PORT(start : in std_logic;
		ad_cif : in std_logic;
		clk : in std_logic;
		intr_cif : out std_logic;
		liber_ocupat : out std_logic;
		egal1, egal2, egal3 : in std_logic;
		reset : in std_logic;
		master_reset : in std_logic;
		mem_cif1 : out std_logic;
		mem_cif2 : out std_logic;
		mem_cif3 : out std_logic;
		mem_cif4 : out std_logic;
		mem_cif5 : out std_logic;
		RC : out std_logic;
		r_tot_reg : out std_logic;
		r_part_reg : out std_logic);
END UC;

ARCHITECTURE TypeArchitecture OF UC IS

type mod_stare is (ST0, ST1, ST2, ST3, ST4, ST5, ST6, ST7, ST8, ST9);

signal stare, nxstare : mod_stare;

signal verod_cif : std_logic := '0';

BEGIN

--	act_stare: process(clk)
--	begin
--		if clk'event and clk = '1' then
--			stare <= nxstare;
--		end if;
--	end process act_stare;

	trans_stare: process(clk)
	begin

	if clk'event and clk = '1' then
		intr_cif <= '0';
		liber_ocupat <= '0';
		mem_cif1 <= '0';
		mem_cif2 <= '0';
		mem_cif3 <= '0';
		mem_cif4 <= '0';
		mem_cif5 <= '0';
		RC <= '0';
		r_tot_reg <= '0';
		r_part_reg <= '0';
		
		case stare is
			when ST0 =>
				if start = '1' then
					stare <= ST1;
				end if;
			when ST1 =>
			    if ad_cif = '0' then verod_cif <= '1';   
			    end if;
			
				if ad_cif = '1' and verod_cif = '1' then
					stare <= ST2;  verod_cif <= '0';   RC <= '1';
				end if;
			when ST2 =>							--cif1
				intr_cif <= '1';
				
				if ad_cif = '0' then verod_cif <= '1';
				end if;

				if ad_cif = '1' and verod_cif = '1' then
					mem_cif1 <= '1';	RC <= '1';	verod_cif <= '0';	stare <= ST3;
				end if;
				
				if reset = '1' then
				    RC <= '1';  verod_cif <= '0';   r_tot_reg <= '1';   stare <= ST1;
				end if;
				if master_reset = '1' then
				    RC <= '1';  verod_cif <= '0';   r_tot_reg <= '1';   r_part_reg <= '1';  stare <= ST1;
				end if;
					
			when ST3 =>						--cif2
				intr_cif <= '1';
				if ad_cif = '0' then verod_cif <= '1';
				end if;

				if ad_cif = '1' and verod_cif = '1' then
					mem_cif2 <= '1';	RC <= '1';	verod_cif <= '0';	stare <= ST4;
				end if;				
				
				if reset = '1' then
				    RC <= '1';  verod_cif <= '0';   r_tot_reg <= '1';   stare <= ST1;
				end if;
				if master_reset = '1' then
				    RC <= '1';  verod_cif <= '0';   r_tot_reg <= '1';   r_part_reg <= '1';  stare <= ST1;
				end if;

			when ST4 =>						--cif3
				intr_cif <= '1';
				if ad_cif = '0' then verod_cif <= '1';
				end if;

				if ad_cif = '1' and verod_cif = '1' then
					mem_cif3 <= '1';	RC <= '1';	verod_cif <= '0';	stare <= ST5;
				end if;
				
				if reset = '1' then
				    RC <= '1';  verod_cif <= '0';   r_tot_reg <= '1';   stare <= ST1;
				end if;
				if master_reset = '1' then
				    RC <= '1';  verod_cif <= '0';   r_tot_reg <= '1';   r_part_reg <= '1';  stare <= ST1;
				end if;

			when ST5 =>							--blocat
				liber_ocupat <= '1';
				if ad_cif = '0' then verod_cif <= '1';
				end if;
				
				if ad_cif = '1' and verod_cif = '1' then
					verod_cif <= '0';  stare <= ST6;   RC <= '1';
				end if;
				
				if master_reset = '1' then
				    RC <= '1';  verod_cif <= '0';   r_tot_reg <= '1';   r_part_reg <= '1';  stare <= ST1;
				end if;
				
			when ST6 =>							--cif1vf
				liber_ocupat <= '1';
				intr_cif <= '1';
				if ad_cif = '0' then verod_cif <= '1';
				end if;

				if ad_cif = '1' and verod_cif = '1' then
					mem_cif4 <= '1';	RC <= '1';	verod_cif <= '0';	stare <= ST7;
				end if;
				
				if reset = '1' then
				    RC <= '1';  verod_cif <= '0';   r_part_reg <= '1';   stare <= ST5;
				end if;
				if master_reset = '1' then
				    RC <= '1';  verod_cif <= '0';   r_tot_reg <= '1';   r_part_reg <= '1';  stare <= ST1;
				end if;
				
			when ST7 =>							--cif2vf
				liber_ocupat <= '1';
				intr_cif <= '1';
				if ad_cif = '0' then verod_cif <= '1';
				end if;

				if ad_cif = '1' and verod_cif = '1' then
					mem_cif5 <= '1';	RC <= '1';	verod_cif <= '0';	stare <= ST8;
				end if;
				
				if reset = '1' then
				    RC <= '1';  verod_cif <= '0';   r_part_reg <= '1';   stare <= ST5;
				end if;
				if master_reset = '1' then
				    RC <= '1';  verod_cif <= '0';   r_tot_reg <= '1';   r_part_reg <= '1';  stare <= ST1;
				end if;
				
			when ST8 =>							--cif3vf
				liber_ocupat <= '1';
				intr_cif <= '1';
				if ad_cif = '0' then verod_cif <= '1';
				end if;

				if ad_cif = '1' and verod_cif = '1' then
					verod_cif <= '0';	stare <= ST9;
				end if;
				
				if reset = '1' then
				    RC <= '1';  verod_cif <= '0';   r_part_reg <= '1';   stare <= ST5;
				end if;
				if master_reset = '1' then
				    RC <= '1';  verod_cif <= '0';   r_tot_reg <= '1';   r_part_reg <= '1';  stare <= ST1;
				end if;
				
			when ST9 =>								--vf deblocare/ revenire in starea initiala
				liber_ocupat <= '1';
				if egal1 = '1' and egal2 = '1' and egal3 = '1' then
					stare <= ST1;	r_tot_reg <= '1';	r_part_reg <= '1';
				else
					stare <= ST5;	r_part_reg <= '1';
				end if;
				
				RC <= '1';
		end case;
        
	end if;
	end process trans_stare;

END TypeArchitecture;
