library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_controlUnit is
  generic(gCLK_HPER   : time := 50 ns; N : integer := 32);
end tb_controlUnit;

architecture behavior of tb_controlUnit is

constant cCLK_PER  : time := gCLK_HPER * 2;


  component controlUnit
	port(opcode : in std_logic_vector(5 downto 0);
	functionF : in std_logic_vector(5 downto 0);
	reg_dst : out std_logic;
	jump : out std_logic;
	branch : out std_logic;
	memRead : out std_logic;
	memToReg : out std_logic;
	memWrite : out std_logic;
	ALUsrc : out std_logic; 
	regWrite : out std_logic;
	signExtend : out std_logic;
	jr : out std_logic;
	ALUOP	: out std_logic_vector(3 downto 0);
	i_CLK : in std_logic
	     );
  end component;
	signal s_regdst, s_jump, s_branch,s_memRead,s_memToReg, s_memWrite,s_ALUsrc,s_regWrite,s_signExtend, s_jr,s_CLK : std_logic;
	signal s_ALUOP : std_logic_vector(3 downto 0);
	signal s_opcode, s_functionF : std_logic_vector(5 downto 0); 
	
begin
	DUT : controlUnit
	port map(opcode => s_opcode,
		 functionF => s_functionF,
		 reg_dst => s_regdst,
		 jump => s_jump,
		 branch => s_branch,
		 memRead => s_memRead,
		 memToReg => s_memToReg,
		 memWrite => s_memWrite,
		 ALUsrc => s_ALUsrc,
		 regWrite => s_regWrite,
		 signExtend => s_signExtend,
		 jr => s_jr,
		 ALUOP => s_ALUOP,
		 i_CLK => s_CLK
	);
P_CLK: process
  begin
    s_CLK <= '0';
    wait for gCLK_HPER;
    s_CLK <= '1';
    wait for gCLK_HPER;
  end process;
P_TB : process
	begin
	s_opcode <= "000000"; --jr : Works
	s_functionF <= "001000";
	wait for cCLK_PER;
	s_opcode <= "000000"; -- All R-format : Works
	s_functionF <= "100000";
	wait for cCLK_PER;
	s_opcode <= "001000"; --addi : Works
	wait for cCLK_PER;
	s_opcode <= "001001"; --addiu : Works
	wait for cCLK_PER;
	s_opcode <= "001100"; --andi : Works
	wait for cCLK_PER;
	s_opcode <= "001111"; --lui : Works
	wait for cCLK_PER;
	s_opcode <= "100011"; --lw : Works
	wait for cCLK_PER;
	s_opcode <= "001110"; --xori 
	wait for cCLK_PER;
	s_opcode <= "001101"; --ori 
	wait for cCLK_PER;
	s_opcode <= "001010"; --slti 
	wait for cCLK_PER;
	s_opcode <= "101011"; --sw 
	wait for cCLK_PER;
	s_opcode <= "000100"; --beq 
	wait for cCLK_PER;
	s_opcode <= "000101"; --bne 
	wait for cCLK_PER;
	s_opcode <= "000010"; --j : Works
	wait for cCLK_PER;	
	s_opcode <= "000011"; --jal : Works
	wait for cCLK_PER;
	s_opcode <= "000100"; --beq
	wait for cCLK_PER;
	s_opcode <= "000101"; --bne
	wait for cCLK_PER;
	wait;
	end process;
end behavior;
	