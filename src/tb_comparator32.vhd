library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O
library std;
--use std.env.all;                -- For hierarchical/external signals
use std.textio.all;             -- For basic I/O-------------------------------------------------------------------------


entity tb_comparator32 is

  generic(gCLK_HPER   : time := 10 ns);   -- Generic for half of the clock cycle period

end tb_comparator32;

architecture mixed of tb_comparator32 is

-- Define the total clock period time
constant cCLK_PER  : time := gCLK_HPER * 2;

-- We will be instantiating our design under test (DUT), so we need to specify its
-- component interface.
component comparator32 is 

 port(
	iCompVal1		: in std_logic_vector(31 downto 0);
	iCompVal2		: in std_logic_vector(31 downto 0);
	oNotEqual		: out std_logic
      );

end component;

signal CLK, reset : std_logic := '0';


signal s_iCompVal1	: std_logic_vector(31 downto 0);
signal s_iCompVal2	: std_logic_vector(31 downto 0);
signal s_oNotEqual	: std_logic;

begin

  DUT0: comparator32
  port map(
	iCompVal1	=> s_iCompVal1,
	iCompVal2	=> s_iCompVal2,
	oNotEqual	=> s_oNotEqual
      );


  --This first process is to setup the clock for the test bench
  P_CLK: process
  begin
    CLK <= '1';         -- clock starts at 1
    wait for gCLK_HPER; -- after half a cycle
    CLK <= '0';         -- clock becomes a 0 (negative edge)
    wait for gCLK_HPER; -- after half a cycle, process begins evaluation again
  end process;

  P_TEST_CASES: process
  begin
	
	s_iCompVal1	<= x"12345578";
	s_iCompVal2	<= x"12345678";

    wait for gCLK_HPER*2;

	s_iCompVal1	<= x"12345678";
	s_iCompVal2	<= x"12345678";

    wait for gCLK_HPER*2;

	s_iCompVal1	<= x"02030405";
	s_iCompVal2	<= x"02030405";

    wait for gCLK_HPER*2;



  end process;

end mixed;