-- Quartus Prime VHDL Template
-- Single-port RAM with single read address

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity imem is

	generic 
	(
		DATA_WIDTH : natural := 32;
		ADDR_WIDTH : natural := 10
	);

	port 
	(
		clk		: in std_logic;
		addr	        : in std_logic_vector((ADDR_WIDTH-1) downto 0);
		q		: out std_logic_vector((DATA_WIDTH -1) downto 0)
	);

end imem;

architecture imem_p of imem is

	-- Build a 2-D array type for the RAM
	subtype word_t is std_logic_vector((DATA_WIDTH-1) downto 0);
	type memory_t is array(2**ADDR_WIDTH-1 downto 0) of word_t;

	-- Declare the RAM signal and specify a default value.	Quartus Prime
	-- will load the provided memory initialization file (.mif).
	signal ram : memory_t;

begin

	q <= ram(to_integer(unsigned(addr)));

end imem_p;
