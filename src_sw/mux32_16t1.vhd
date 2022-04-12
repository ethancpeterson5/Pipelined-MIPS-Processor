library IEEE;
use IEEE.std_logic_1164.all;

entity mux32_16t1 is
port(	i0, i1, i2, i3, i4, i5, i6, i7, i8, i9, i10, i11, i12, i13, i14, i15	: in std_logic_vector(31 downto 0);
	i_S				: in std_logic_vector(3 downto 0);
	o_F				: out std_logic_vector(31 downto 0));

end mux32_16t1;

architecture dataflow of mux32_16t1 is

begin

with i_S select

o_F <=  i0 when "0000",
	i1 when "0001",
	i2 when "0010",
	i3 when "0011",
	i4 when "0100",
	i5 when "0101",
	i6 when "0110",
	i7 when "0111",
	i8 when "1000",
	i9 when "1001",
	i10 when "1010",
	i11 when "1011",
	i12 when "1100",
	i13 when "1101",
	i14 when "1110",
	i15 when "1111",
(others => '0') when others;

end dataflow;