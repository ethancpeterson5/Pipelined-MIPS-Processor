-------------------------------------------------------------------------
-- Eduardo Contreras
-- CPR E 381
-- Fetch Logic Project 1
-------------------------------------------------------------------------


-- fetch.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a the fetch logic.  
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity fetch is

 port(
      iRST		: in std_logic;
      iCLK		: in std_logic;
      iPCSrc		: in std_logic;
      iBranchPC		: in std_logic_vector(31 downto 0);
      dataOut		: out std_logic_vector(31 downto 0);
      overflow		: out std_logic);

end fetch;

architecture structural of fetch is

 component mux2t1_N

  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_S          : in std_logic;
       i_D0         : in std_logic_vector(N-1 downto 0);
       i_D1         : in std_logic_vector(N-1 downto 0);
       o_O          : out std_logic_vector(N-1 downto 0));

 end component;


 component register_N

  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_CLK        : in std_logic;     		     -- Clock input
       i_RST        : in std_logic;     		     -- Reset input
       i_WE         : in std_logic;     		     -- Write enable input
       i_D          : in std_logic_vector(N-1 downto 0);     -- Data value input
       o_Q          : out std_logic_vector(N-1 downto 0));   -- Data value output

 end component;


 component ripplecarryadd_N 

  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(
      i_Ain          : in std_logic_vector(N-1 downto 0);
      i_Bin          : in std_logic_vector(N-1 downto 0);
      i_Cin          : in std_logic;
      o_Cout         : out std_logic;
      o_R            : out std_logic_vector(N-1 downto 0));

 end component;


 component imem

	generic 
	(
		DATA_WIDTH : natural := 32;
		ADDR_WIDTH : natural := 10
	);

	port 
	(
		clk		: in std_logic;
		addr	        : in std_logic_vector((ADDR_WIDTH-1) downto 0);
		q		: out std_logic_vector((DATA_WIDTH -1) downto 0)
	);

 end component;

signal s_PCout		: std_logic_vector(31 downto 0);
signal s_AdderOut	: std_logic_vector(31 downto 0);
signal s_PCMuxout	: std_logic_vector(31 downto 0);

begin

  g_MUX2T1: mux2t1_N
    port MAP(
	i_S		=> iPCSrc,
	i_D0      	=> s_AdderOut,
	i_D1		=> iBranchPC,
        o_O            	=> s_PCMuxout);

  g_PC: register_N
    port MAP(
	i_CLK		=> iCLK,
	i_RST      	=> iRST,
	i_WE		=> '1',
	i_D		=> s_PCMuxout,
        o_Q            	=> s_PCout);

  g_ADDER: ripplecarryadd_N
    port MAP(
	i_Ain		=> s_PCout,
	i_Bin      	=> x"00000004",
	i_Cin		=> '0',
	o_Cout		=> overflow,
        o_R            	=> s_AdderOut);



  g_IMEM: imem
    port MAP(
	clk		=> iCLK,
	addr      	=> s_PCout(11 downto 2),
        q            	=> dataOut);


end structural;
