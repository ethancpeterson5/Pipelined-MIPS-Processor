library IEEE;
use IEEE.std_logic_1164.all;

entity SignExtender is
	port(i_S : in std_logic;
	     i_Extend : in std_logic_vector(15 downto 0);
	     o_Extended : out std_logic_vector(31 downto 0)
	);
end SignExtender;
architecture dataflow of SignExtender is
begin
	with i_S and i_Extend(15) select
		o_Extended <= x"0000" & i_Extend when '0',
			      x"FFFF" & i_Extend when others;
end dataflow;