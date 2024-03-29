library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity main is
  Port (start : in std_logic;
        clk : in std_logic;
        up, down, reset, master_reset, ad_cif : in std_logic;
        catod : out std_logic_vector(6 downto 0);
        anod : out std_logic_vector(3 downto 0);
        intr_cif_led : out std_logic;
        liber_ocupat_led : out std_logic);
end main;

architecture Behavioral of main is

signal output_aux : std_logic_vector(14 downto 0);
signal anod_aux : std_logic_vector(3 downto 0);
signal catod_aux : std_logic_vector(6 downto 0);
signal q_aux : std_logic_vector(3 downto 0);
signal q_reg1, q_reg2, q_reg3, q_reg4, q_reg5 : std_logic_vector(3 downto 0);
signal m_cif1, m_cif2, m_cif3, m_cif4, m_cif5, m_cif6 : std_logic;
signal RC_aux, r_tot_aux, r_part_aux : std_logic;
signal lib_ocup, intr_cif_aux : std_logic;
signal init1, init2, init3, init4, init5: std_logic;
signal egal1_aux, egal2_aux, egal3_aux : std_logic;

component mux8 is
  Port (s : in std_logic_vector(1 downto 0);
        d0, d1, d2, d3 : in std_logic_vector(6 downto 0);
        catod : out std_logic_vector(6 downto 0));
end component;

component mux4 is
    Port(s : in std_logic_vector(1 downto 0);
         d0, d1, d2, d3 : in std_logic_vector(3 downto 0);
         anod : out std_logic_vector(3 downto 0));
end component;

component num_15b is
  Port (clk : in std_logic;
        output : out std_logic_vector(14 downto 0));
end component;

component Numarator_rev_1_15 IS
	PORT(en_up : in std_logic;
  		en_down : in std_logic;
  		load : in std_logic;
  		clk : in std_logic;
  		q : out std_logic_vector(3 downto 0));
end component;

component SSD_DEC is
  Port(nr1, nr2, nr3, nr4, nr5, q : in std_logic_vector(3 downto 0);
       init1, init2, init3, init4, init5 : in std_logic;
       clk : in std_logic;
       anod : in std_logic_vector(3 downto 0);
       liber_ocupat : in std_logic;
       on_off : in std_logic;
       catod : out std_logic_vector(6 downto 0));
end component;

component Registru_4b is
   port(d : in std_logic_vector(3 downto 0);
	    mem_cif : in std_logic;
		clk : in std_logic;
		q : out std_logic_vector(3 downto 0);
		reset : in std_logic;
		init : out std_logic);
end component;

component UC IS
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
end component;

component Comparator_4b IS
   PORT(clk : in std_logic;
	    a : in std_logic_vector(3 downto 0);
		b : in std_logic_vector(3 downto 0);
		egal : out std_logic);
end component;

begin

    p1 : num_15b port map(clk => clk,
                          output => output_aux);
                          
    p2 : mux4 port map(s => output_aux(14 downto 13),
                       d0 => "1110",
                       d1 => "1101",
                       d2 => "1011",
                       d3 => "0111",
                       anod => anod_aux);

    p3 : mux8 port map(s => output_aux(14 downto 13),
                       d0 => catod_aux,
                       d1 => catod_aux,
                       d2 => catod_aux,
                       d3 => catod_aux);
                       
    p4 : Numarator_rev_1_15 port map(en_up => up,
                                     en_down => down,
                                     load => RC_aux,
                                     clk => clk,
                                     q => q_aux);
                                     
    p5 : SSD_DEC port map(nr1 => q_reg1,
                          nr2 => q_reg2,
                          nr3 => q_reg3, 
                          nr4 => q_reg4,
                          nr5 => q_reg5,
                          init1 => init1,
                          init2 => init2, 
                          init3 => init3,
                          init4 => init4,
                          init5 => init5,
                          q => q_aux,
                          clk => clk,
                          anod => anod_aux,
                          liber_ocupat => lib_ocup,
                          on_off => intr_cif_aux,
                          catod => catod_aux);
                          
    p6 : Registru_4b port map(d => q_aux,                                                   -- 6 registrii
                              mem_cif => m_cif1,
                              clk => clk,
                              reset => r_tot_aux,
                              q => q_reg1,
                              init => init1);
    p7 : Registru_4b port map(d => q_aux,
                              mem_cif => m_cif2,
                              clk => clk,
                              reset => r_tot_aux,
                              q => q_reg2,
                              init => init2);
    p8 : Registru_4b port map(d => q_aux,
                              mem_cif => m_cif3,
                              clk => clk,
                              reset => r_tot_aux,
                              q => q_reg3,
                              init => init3);
    p9 : Registru_4b port map(d => q_aux,
                              mem_cif => m_cif4,
                              clk => clk,
                              reset => r_part_aux,
                              q => q_reg4,
                              init => init4);
    p10 : Registru_4b port map(d => q_aux,
                              mem_cif => m_cif5,
                              clk => clk,
                              reset => r_part_aux,
                              q => q_reg5,
                              init => init5);
     
     p12 : UC port map(start => start,
                       ad_cif => ad_cif,
                       clk => clk,
                       intr_cif => intr_cif_aux,
                       liber_ocupat => lib_ocup,
                       egal1 => egal1_aux,
                       egal2 => egal2_aux,
                       egal3 => egal3_aux,
                       reset => reset,
                       master_reset => master_reset,
                       mem_cif1 => m_cif1,
                       mem_cif2 => m_cif2,
                       mem_cif3 => m_cif3,
                       mem_cif4 => m_cif4,
                       mem_cif5 => m_cif5,
                       RC => RC_aux,
                       r_tot_reg => r_tot_aux,
                       r_part_reg => r_part_aux); 
                       
    p13 : Comparator_4b port map(a => q_reg1,
                                 b => q_reg4, 
                                 clk => clk,
                                 egal => egal1_aux);
    p14 : Comparator_4b port map(a => q_reg2,
                                 b => q_reg5, 
                                 clk => clk,
                                 egal => egal2_aux);
    p15 : Comparator_4b port map(a => q_reg3,
                                 b => q_aux, 
                                 clk => clk,
                                 egal => egal3_aux);                               
    intr_cif_led <= intr_cif_aux;
    liber_ocupat_led <= lib_ocup;                                                                                                                                                    
    catod <= catod_aux;
    anod <= anod_aux;
end Behavioral;
