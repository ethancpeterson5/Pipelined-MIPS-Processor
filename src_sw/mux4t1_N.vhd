library IEEE;
use IEEE.std_logic_1164.all;
entity mux4t1_N is
	generic(N : integer := 32);
	port(i_S	: in std_logic_vector(1 downto 0);
	     i_D0	: in std_logic_vector(N-1 downto 0);
	     i_D1	: in std_logic_vector(N-1 downto 0);
	     i_D2	: in std_logic_vector(N-1 downto 0);
	     i_D3 	: in std_logic_vector(N-1 downto 0);
	     o_O	: out std_logic_vector(N-1 downto 0)
	);
end mux4t1_N;

architecture behavior of mux4t1_N is
begin 
	process(i_S,i_D0,i_D1,i_D2,i_D3)
	begin
	if i_S = "00" then
		o_O <= i_D0;
	elsif i_S = "01" then
		o_O <= i_D1;
	elsif i_S = "10" then
		o_O <= i_D2;
	elsif i_S = "11" then
		o_O <= i_D3;
	end if;
	end process;
end behavior;