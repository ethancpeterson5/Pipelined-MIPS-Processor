library IEEE;
use IEEE.std_logic_1164.all;

entity repl is
port(   i_rep : in std_logic_vector(7 downto 0);
	o_F :	out std_logic_vector(31 downto 0));
end repl;

architecture dataflow of repl is

begin

o_F <= i_rep & i_rep & i_rep & i_rep;

end dataflow;