library IEEE;
use IEEE.std_logic_1164.all;

entity ALU is
port(	i_A  :in std_logic_vector (31 downto 0);
	i_B  :in std_logic_vector (31 downto 0);
	i_shamt :in std_logic_vector(4 downto 0);
	i_ALUcode :in std_logic_vector(3 downto 0);
	i_repl	:in std_logic_vector(7 downto 0);
	o_result :out std_logic_vector (31 downto 0);
	o_carry, o_oF :out std_logic);
end ALU;

architecture structural of ALU is

component AddSub is
port(i_A_as             : in std_logic_vector(31 downto 0);
       i_B_as             : in std_logic_vector(31 downto 0);
       n_Add_Sub          : in std_logic;
       o_carry_as	  : out std_logic;
       o_result_as        : out std_logic_vector(31 downto 0);
       o_overflow	  : out std_logic);
end component;

component and32 is
port(	i_A          : in std_logic_vector(31 downto 0);
	i_B          : in std_logic_vector(31 downto 0);	
	o_F          : out std_logic_vector(31 downto 0));
end component;

component or32 is
port(	i_A          : in std_logic_vector(31 downto 0);
	i_B          : in std_logic_vector(31 downto 0);	
	o_F          : out std_logic_vector(31 downto 0));
end component;

component xor32 is
port(	i_A          : in std_logic_vector(31 downto 0);
	i_B          : in std_logic_vector(31 downto 0);	
	o_F          : out std_logic_vector(31 downto 0));
end component;

component nor32 is
port(	i_A          : in std_logic_vector(31 downto 0);
	i_B          : in std_logic_vector(31 downto 0);	
	o_F          : out std_logic_vector(31 downto 0));
end component;

component repl is
port(	i_rep : in std_logic_vector(7 downto 0);
	o_F :	out std_logic_vector(31 downto 0));
end component;

component shifter is
port(i_X : in std_logic_vector(31 downto 0);
       i_shamt : in std_logic_vector(4 downto 0);
       i_type : in std_logic; -- 0 for logical, 1 for arithmetic
       i_dir : in std_logic; -- 0 for right, 1 for left
       o_Y : out std_logic_vector(31 downto 0));
end component;



component mux32_16t1 is
port(	i0, i1, i2, i3, i4, i5, i6, i7, i8, i9, i10, i11, i12, i13, i14, i15	: in std_logic_vector(31 downto 0);
	i_S				: in std_logic_vector(3 downto 0);
	o_F				: out std_logic_vector(31 downto 0));
end component;

component nor32t1 is
port(i_A: in std_logic_vector(31 downto 0);
	o_F	:out std_logic);
end component;

component invg is
port(i_A          : in std_logic;
     o_F          : out std_logic);
end component;

component mux2t1 is
port(i_S          : in std_logic;
       i_D0         : in std_logic;
       i_D1         : in std_logic;
       o_O	    : out std_logic);
end component;

component xorg2 is
port(	i_A          : in std_logic;
	i_B          : in std_logic;	
	o_F          : out std_logic);
end component;

signal s_addsub, s_and, s_or, s_xor, s_nor, s_slt, s_repl, s_shifter: std_logic_vector(31 downto 0);
signal s_overflow : std_logic;

begin
o_of <= s_overflow;

AdderSubtractor: AddSub
port map(
i_A_as => i_A,
i_B_as => i_B,
n_Add_Sub => i_ALUcode(0),
o_carry_as => o_carry,
o_overflow => s_overflow,
o_result_as => s_addsub);

andOP: and32
port map(
i_A => i_A,
i_B => i_B,
o_F => s_and);

orOP: or32
port map(
i_A => i_A,
i_B => i_B,
o_F => s_or);

xorOp: xor32
port map(
i_A => i_A,
i_B => i_B,
o_F => s_xor);
	
norOp: nor32
port map(
i_A => i_A,
i_B => i_B,
o_F => s_nor);

replicator: repl
port map(
i_rep => i_repl,
o_F => s_repl);

shift: shifter 
port map(
i_X => i_B,
i_shamt => i_shamt,
i_type => i_ALUcode(0),
i_dir => i_ALUcode(1),
o_Y => s_shifter);

xor_slt: xorg2
port map(
i_A => s_addsub(31),
i_B => s_overflow,
o_F => s_slt(0));

G: for i in 1 to 31 generate
	s_slt(i) <= '0';
end generate;

mux_control: mux32_16t1
port map(
i0 => s_addsub, 
i1 => s_addsub, 
i2 => s_and, 
i3 => s_slt, 
i4 => s_or, 
i5 => s_xor, 
i6 => s_nor, 
i7 => s_repl, 
i8 => s_shifter, 
i9 => s_shifter, 
i10 =>s_shifter, 
i11 => x"00000000", 
i12 => x"00000000", 
i13 => x"00000000", 
i14 => x"00000000", 
i15 => x"00000000",
i_S => i_ALUcode,
o_F => o_result);

end structural;


