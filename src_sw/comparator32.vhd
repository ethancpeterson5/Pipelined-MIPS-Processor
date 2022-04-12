library IEEE; 
use IEEE.std_logic_1164.all;

entity comparator32 is

 port(
	iCompVal1		: in std_logic_vector(31 downto 0);
	iCompVal2		: in std_logic_vector(31 downto 0);
	oNotEqual		: out std_logic
      );
end comparator32;

architecture structural of comparator32 is

component xor32 is

  port(i_A          : in std_logic_vector(31 downto 0);
       i_B          : in std_logic_vector(31 downto 0);
       o_F          : out std_logic_vector(31 downto 0));

end component;

component OR32to1 is

   port(
	i_A	: in std_logic_vector(31 downto 0);
	o_F	: out std_logic);

end component;

signal s_CompR32 : std_logic_vector(31 downto 0);

begin

  XORComparison: xor32
	port map(
		i_A => iCompVal1,
		i_B => iCompVal2,
		o_F => s_CompR32);

  NotEqualResult: OR32to1
	port map(
		i_A => s_CompR32,
		o_F => oNotEqual);
	

end structural;