library IEEE;
use IEEE.std_logic_1164.all;


entity Reg_IDEX is
generic(N : integer := 186);
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
end Reg_IDEX;

architecture structural of Reg_IDEX is
component register_186 is
port(i_CLKn        : in std_logic;     -- Clock input
       i_RSTn        : in std_logic;     -- Reset input
       i_WEn         : in std_logic;     -- Write enable input
       i_Dn          : in std_logic_vector(185 downto 0);     -- Data value input
       o_Qn          : out std_logic_vector(185 downto 0));   -- Data value output
end component;

signal S_Reg_Inputs: std_logic_vector(185 downto 0);
signal S_Reg_Outputs: std_logic_vector(185 downto 0);

begin
S_Reg_Inputs <= 
i_LuiInst &
i_shamt &
i_JalControl &
i_RegWrite &
i_MemToReg &
i_MemWrite &
i_RegDst &
i_ALUSrc &
i_ALUControlOut &
i_rtAdd     &
i_rsAdd &
i_Instruction &
i_UpdatedPC &
i_SignExtendOut &
i_RT_RegOut &
i_RS_RegOut;


REG: register_186 port map(
	i_CLKn => i_CLKn, 
       	i_RSTn => i_RSTn,
       	i_WEn  => i_WEn,
       	i_Dn   => S_Reg_Inputs,
       	o_Qn   => S_Reg_Outputs);

o_RS_RegOut <= S_Reg_Outputs(31 downto 0);
o_RT_RegOut <= S_Reg_Outputs(63 downto 32);
o_SignExtendOut <= S_Reg_Outputs(95 downto 64);
o_UpdatedPC <= S_Reg_Outputs(127 downto 96);
o_Instruction <= S_Reg_Outputs(159 downto 128);
o_rsAdd <= S_Reg_Outputs(164 downto 160);
o_rtAdd     <= S_Reg_Outputs(169 downto 165);
--o_Write_Reg_Add <= S_Reg_Outputs(174 downto 170);
--o_ALUOP <= S_Reg_Outputs(162 downto 159);
o_ALUControlOut <= S_Reg_Outputs(173 downto 170);
o_ALUSrc <= S_Reg_Outputs(174);
o_RegDst <= S_Reg_Outputs(175);
o_MemWrite <= S_Reg_Outputs(176);
--o_Branch <= S_Reg_Outputs(165);
o_MemToReg <= S_Reg_Outputs(177);
o_RegWrite <= S_Reg_Outputs(178);
--o_ExtendControl <= S_Reg_Outputs(167);
--o_ImmType <= S_Reg_Outputs(168);
--o_JumpControl <= S_Reg_Outputs(170);
--o_JRControl <= S_Reg_Outputs(171);
--o_BranchSelect <= S_Reg_Outputs(172);
o_JalControl  <= S_Reg_Outputs(179);
o_shamt	<= S_Reg_Outputs(184 downto 180);
o_LuiInst <= S_Reg_Outputs(185);


end structural;