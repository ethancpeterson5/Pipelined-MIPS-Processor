library IEEE;
use IEEE.std_logic_1164.all;
entity tb_Reg_IDEX is
  generic(gCLK_HPER   : time := 10 ns);
end tb_Reg_IDEX;

architecture behavior of tb_Reg_IDEX is
 constant cCLK_PER  : time := gCLK_HPER * 2;

component Reg_IDEX
port(	i_CLKn        	: in std_logic;     -- Clock input
       	i_RSTn        	: in std_logic;     -- Reset input
       	i_WEn         	: in std_logic;     -- Write enable input

	i_RS_RegOut	: in std_logic_vector(31 downto 0);
	i_RT_RegOut	: in std_logic_vector(31 downto 0);
	i_SignExtendOut	: in std_logic_vector(31 downto 0);
	--i_JumpAdd	: in std_logic_vector(31 downto 0);
	i_UpdatedPC	: in std_logic_vector(31 downto 0);
	i_Instruction	: in std_logic_vector(31 downto 0);
	i_rsAdd		: in std_logic_vector(4 downto 0);
	i_rtAdd		: in std_logic_vector(4 downto 0);
	--i_Write_Reg_Add	: in std_logic_vector(4 downto 0);
	--i_ALUOP		: in std_logic_vector(3 downto 0);
	i_ALUControlOut	: in std_logic_vector(3 downto 0);
       	i_ALUSrc	: in std_logic;
	i_RegDst	: in std_logic;
	i_MemWrite	: in std_logic;
	--i_Branch	: in std_logic;
	i_MemToReg	: in std_logic;
	i_RegWrite	: in std_logic;
	--i_ExtendControl	: in std_logic;
	--i_ImmType	: in std_logic;
	--i_JumpControl	: in std_logic;
	--i_JRControl	: in std_logic;
	--i_BranchSelect 	: in std_logic;
	i_JalControl	: in std_logic;
	i_shamt		: in std_logic_vector(4 downto 0);
	i_LuiInst       : in std_logic;


	o_RS_RegOut    	: out std_logic_vector(31 downto 0);
    	o_RT_RegOut    	: out std_logic_vector(31 downto 0);
    	o_SignExtendOut : out std_logic_vector(31 downto 0);
   	o_UpdatedPC    	: out std_logic_vector(31 downto 0);
   	o_Instruction   : out std_logic_vector(31 downto 0);
  	o_rsAdd        	: out std_logic_vector(4 downto 0);
   	o_rtAdd        	: out std_logic_vector(4 downto 0);
	--o_Write_Reg_Add	: out std_logic_vector(4 downto 0);
   	--o_ALUOP        	: out std_logic_vector(3 downto 0);
   	o_ALUControlOut : out std_logic_vector(3 downto 0);
   	o_ALUSrc    	: out std_logic;
    	o_RegDst    	: out std_logic;
   	o_MemWrite    	: out std_logic;
    	--o_Branch    	: out std_logic;
    	o_MemToReg    	: out std_logic;
    	o_RegWrite    	: out std_logic;
    	--o_ExtendControl : out std_logic;
    	--o_ImmType    	: out std_logic;
    	--o_JumpControl   : out std_logic;
    	--o_JRControl    	: out std_logic;
    	--o_BranchSelect  : out std_logic;
    	o_JalControl    : out std_logic;
	o_shamt		: out std_logic_vector(4 downto 0);
	o_LuiInst	: out std_logic);
end component;

	signal si_CLKn        	: std_logic;     -- Clock input
       	signal si_RSTn        	: std_logic;     -- Reset input
       	signal si_WEn         	: std_logic;     -- Write enable put

	signal si_RS_RegOut	:  std_logic_vector(31 downto 0);
	signal si_RT_RegOut	:  std_logic_vector(31 downto 0);
	signal si_SignExtendOut	:  std_logic_vector(31 downto 0);
	signal si_UpdatedPC	:  std_logic_vector(31 downto 0);
	signal si_Instruction	:  std_logic_vector(31 downto 0);
	signal si_rsAdd		:  std_logic_vector(4 downto 0);
	signal si_rtAdd		:  std_logic_vector(4 downto 0);
	signal si_ALUControlOut	:  std_logic_vector(3 downto 0);
       	signal si_ALUSrc	:  std_logic;
	signal si_RegDst	:  std_logic;
	signal si_MemWrite	:  std_logic;
	signal si_MemToReg	:  std_logic;
	signal si_RegWrite	:  std_logic;
	signal si_JalControl	:  std_logic;
	signal si_shamt		:  std_logic_vector(4 downto 0);
	signal si_LuiInst       :  std_logic;



	signal so_RS_RegOut    	:  std_logic_vector(31 downto 0);
    	signal so_RT_RegOut    	:  std_logic_vector(31 downto 0);
    	signal so_SignExtendOut :  std_logic_vector(31 downto 0);
   	signal so_UpdatedPC    	:  std_logic_vector(31 downto 0);
   	signal so_Instruction   :  std_logic_vector(31 downto 0);
  	signal so_rsAdd        	:  std_logic_vector(4 downto 0);
   	signal so_rtAdd        	:  std_logic_vector(4 downto 0);
   	signal so_ALUControlOut :  std_logic_vector(3 downto 0);
   	signal so_ALUSrc    	:  std_logic;
    	signal so_RegDst    	:  std_logic;
   	signal so_MemWrite    	:  std_logic;
    	signal so_MemToReg    	:  std_logic;
    	signal so_RegWrite    	:  std_logic;
    	signal so_JalControl    :  std_logic;
	signal so_shamt		:  std_logic_vector(4 downto 0);
	signal so_LuiInst	:  std_logic;

begin
DUT: Reg_IDEX
port map(
	i_CLKn        	=> si_CLKn,
       	i_RSTn        	=> si_RSTn,
       	i_WEn         	=> si_WEn,

	i_RS_RegOut	=> si_RS_RegOut,
	o_RS_RegOut    	=> so_RS_RegOut,

	i_RT_RegOut	=> si_RT_RegOut,
	o_RT_RegOut    	=> so_RT_RegOut,

	i_SignExtendOut	=> si_SignExtendOut,
	o_SignExtendOut => so_SignExtendOut,

	i_UpdatedPC	=> si_UpdatedPC,
	o_UpdatedPC    	=> so_UpdatedPC,

	i_Instruction	=> si_Instruction,
	o_Instruction   => so_Instruction,

	i_rsAdd		=> si_rsAdd,
  	o_rsAdd        	=> so_rsAdd,

	i_rtAdd		=> si_rtAdd,	
	o_rtAdd        	=> so_rtAdd,

	i_ALUControlOut	=> si_ALUControlOut,
	o_ALUControlOut => so_ALUControlOut,

       	i_ALUSrc	=> si_ALUSrc,
	o_ALUSrc    	=> so_ALUSrc,

	i_RegDst	=> si_RegDst,
    	o_RegDst    	=> so_RegDst,

	i_MemWrite	=> si_MemWrite,
  	o_MemWrite    	=> so_MemWrite,

	i_MemToReg	=> si_MemToReg,
    	o_MemToReg    	=> so_MemToReg,

	i_RegWrite	=> si_RegWrite,	
    	o_RegWrite    	=> so_RegWrite,

	i_JalControl	=> si_JalControl,
	o_JalControl    => so_JalControl,

	i_shamt		=> si_shamt,	
	o_shamt		=> so_shamt,



	i_LuiInst	=> si_LuiInst,
	o_LuiInst	=> so_LuiInst);
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
	 si_RS_RegOut	  <=x"55555555";
	 si_RT_RegOut	  <=x"44444444";
	 si_SignExtendOut	  <=x"33333333";
	 si_UpdatedPC	  <=x"11111111";
	 si_Instruction	  <=x"AAAAAAAA";
	 si_rsAdd		  <="01000";
	 si_rtAdd		  <="11101";
	 si_ALUControlOut	  <="0010";
       	 si_ALUSrc	  <='1';
	 si_RegDst	  <='0';
	 si_MemWrite	  <='1';
	 si_MemToReg	  <='1';
	 si_RegWrite	  <='0';
	 si_LuiInst	<='1';
	 si_JalControl	  <='0';
	 si_shamt		  <="01011";
wait for cCLK_PER;
wait for cCLK_PER;
wait for cCLK_PER;
wait for cCLK_PER;
wait for cCLK_PER;


end process;
end behavior;
