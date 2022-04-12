library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_ALUcontrol is
  generic(gCLK_HPER   : time := 50 ns; N : integer := 32);
end tb_ALUcontrol;

architecture behavior of tb_ALUcontrol is

constant cCLK_PER  : time := gCLK_HPER * 2;


  component ALUcontrol
	port(ALUOP : in std_logic_vector(3 downto 0);
	functionF : in std_logic_vector(10 downto 0);
	shAmt : out std_logic_vector(4 downto 0);
	branchSelect : out std_logic;
	ALUcontrolOut : out std_logic_vector(3 downto 0);
	i_CLK : in std_logic
	     );
  end component;
	signal s_ALUOP, s_ALUcontrolOut : std_logic_vector(3 downto 0);
	signal s_branchSelect, s_CLK : std_logic;
	signal s_functionF : std_logic_vector(10 downto 0);
	signal s_shAmt : std_logic_vector(4 downto 0) ;
begin
	DUT : ALUcontrol
	port map(ALUcontrolOut => s_ALUcontrolOut,
		 ALUOP => s_ALUOP,
		 functionF => s_functionF,
		 shAmt => s_shAmt,
		 branchSelect => s_branchSelect,
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
	s_ALUOP <= "0010"; -- sub : 
	s_functionF(5 downto 0) <= "100010";
	wait for cCLK_PER;
	s_functionF(5 downto 0) <= "100000"; --add
	wait for cCLK_PER;
	s_functionF(5 downto 0) <= "100100"; --and
	wait for cCLK_PER;
	s_functionF(5 downto 0) <= "100111"; --nor
	wait for cCLK_PER;
	s_functionF(5 downto 0) <= "000000"; --or
	wait for cCLK_PER;
	s_functionF(5 downto 0) <= "101010"; --slt
	wait for cCLK_PER;
	s_functionF(5 downto 0) <= "001000"; --addi, should work for addiu and sw check ALUcontrol
	wait for cCLK_PER;
	s_ALUOP <= "0100";--lw
	wait for cCLK_PER;
	s_ALUOP <= "1000"; --andi
	wait for cCLK_PER;
	s_ALUOP <= "1001"; --xori
	wait for cCLK_PER;
	s_ALUOP <= "1010"; --ori
	wait for cCLK_PER;
	s_ALUOP <= "1011"; --slti
	wait for cCLK_PER;
	s_ALUOP <= "0000";
	s_functionF(10 downto 0) <= "00011000000"; --sll
	wait for cCLK_PER;
	s_functionF(10 downto 0) <= "10000000010"; --srl
	wait for cCLK_PER;
	s_functionF(10 downto 0) <= "01111000011"; --sra
	wait for cCLK_PER;
	s_ALUOP <= "1100"; --beq
	wait for cCLK_PER;
	s_ALUOP <= "1101"; --bne
	wait for cCLK_PER;
	wait;
	end process;
end behavior;