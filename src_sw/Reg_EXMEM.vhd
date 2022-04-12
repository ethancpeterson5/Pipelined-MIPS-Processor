library IEEE;
use IEEE.std_logic_1164.all;


entity Reg_EXMEM is
generic(N : integer := 138);
  port(	i_CLKn        	: in std_logic;     -- Clock input
       	i_RSTn        	: in std_logic;     -- Reset input
       	i_WEn         	: in std_logic;     -- Write enable input


	i_ALUOut	: in std_logic_vector(31 downto 0);
	i_Inst          : in std_logic_vector(31 downto 0);
	i_RtRegOut	: in std_logic_vector(31 downto 0);
	i_MemToReg	: in std_logic;
	i_RegWr		: in std_logic;
	i_JalControl	: in std_logic;
        i_LuiControl	: in std_logic;
	i_MemWr		: in std_logic;
	i_WriteRegAdd	: in std_logic_vector(4 downto 0);
	i_UpdatedPC	: in std_logic_vector(31 downto 0);

	
	o_ALUOut	: out std_logic_vector(31 downto 0);
	o_Inst          : out std_logic_vector(31 downto 0);
	o_RtRegOut	: out std_logic_vector(31 downto 0);
	o_MemToReg	: out std_logic;
	o_RegWr		: out std_logic;
	o_JalControl	: out std_logic;
        o_LuiControl	: out std_logic;
	o_MemWr		: out std_logic;
	o_WriteRegAdd	: out std_logic_vector(4 downto 0);
	o_UpdatedPC	: out std_logic_vector(31 downto 0));
	

end Reg_EXMEM;

architecture structural of Reg_EXMEM is
component register_138 is
port(i_CLKn        : in std_logic;     -- Clock input
       i_RSTn        : in std_logic;     -- Reset input
       i_WEn         : in std_logic;     -- Write enable input
       i_Dn          : in std_logic_vector(137 downto 0);     -- Data value input
       o_Qn          : out std_logic_vector(137 downto 0));   -- Data value output
end component;

signal S_Reg_Inputs: std_logic_vector(137 downto 0);
signal S_Reg_Outputs: std_logic_vector(137 downto 0);

begin
S_Reg_Inputs <= i_UpdatedPC &
		i_WriteRegAdd &
		i_MemWr &
		i_LuiControl & 
		i_JalControl & 
		i_RegWr &
		i_MemToReg &
		i_RtRegOut &
		i_Inst &
		i_ALUOut;
		
REG: register_138 port map(
	i_CLKn => i_CLKn, 
       	i_RSTn => i_RSTn,
       	i_WEn  => i_WEn,
       	i_Dn   => S_Reg_Inputs,
       	o_Qn   => S_Reg_Outputs);


o_ALUOut <= S_Reg_Outputs(31 downto 0);
o_Inst <= S_Reg_Outputs(63 downto 32);
o_RtRegOut <= S_Reg_Outputs(95 downto 64);
o_MemToReg <= S_Reg_Outputs(96);
o_RegWr <= S_Reg_Outputs(97);
o_JalControl <= S_Reg_Outputs(98);
o_LuiControl <= S_Reg_Outputs(99);
o_MemWr <= S_Reg_Outputs(100);
o_WriteRegAdd <= S_Reg_Outputs(105 downto 101);
o_UpdatedPC <= S_Reg_Outputs(137 downto 106);

end structural;