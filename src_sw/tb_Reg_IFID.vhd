library IEEE;
use IEEE.std_logic_1164.all;
entity tb_Reg_IFID is
  generic(gCLK_HPER   : time := 10 ns);
end tb_Reg_IFID;

architecture behavior of tb_Reg_IFID is
 constant cCLK_PER  : time := gCLK_HPER * 2;

component Reg_IFID
port(	i_CLKn        	: in std_logic;     -- Clock input
       	i_RSTn        	: in std_logic;     -- Reset input
       	i_WEn         	: in std_logic;     -- Write enable input
       	i_Instruction 	: in std_logic_vector(31 downto 0);    
	i_PC		: in std_logic_vector(31 downto 0);
	i_Flush		: in std_logic;
	o_Instruction 	: out std_logic_vector(31 downto 0);    
	o_PC		: out std_logic_vector(31 downto 0);
	o_Flush		: out std_logic);
end component;

signal 	si_CLKn        	:std_logic;
signal  si_RSTn        	:std_logic;
signal  si_WEn      	:std_logic;
  	
signal  si_Instruction  :std_logic_vector(31 downto 0);
signal	si_PC		:std_logic_vector(31 downto 0);
signal	si_Flush	:std_logic;	
signal	so_Instruction 	:std_logic_vector(31 downto 0);   
signal	so_PC		:std_logic_vector(31 downto 0);
signal	so_Flush	:std_logic;

begin
DUT: Reg_IFID
port map(
	i_CLKn		=> si_CLKn,
	i_RSTn		=> si_RSTn,
	i_WEn         	=> si_WEn,
       	i_Instruction 	=> si_Instruction,
	i_PC		=> si_PC,
	i_Flush		=> si_Flush,
	o_Instruction 	=> so_Instruction,
	o_PC		=> so_PC,
	o_Flush		=> so_Flush);

P_CLK: process
  begin
    si_Clkn <= '0';
    wait for gCLK_HPER;
    si_Clkn <= '1';
    wait for gCLK_HPER;
  end process;

P_TB: process
  begin

si_RSTn <= '1';
wait for gCLK_HPER;
wait for gCLK_HPER;
si_RSTn <= '0';

si_WEn <= '1';
si_Instruction <= 	x"FFFFFFFF";
si_PC <=		x"AAAAAAAA";
si_Flush <=		'1';
wait for cCLK_PER;

end process;
end behavior;
