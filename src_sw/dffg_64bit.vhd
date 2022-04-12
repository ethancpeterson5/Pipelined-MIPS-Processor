library IEEE;
use IEEE.std_logic_1164.all;

entity dffg_64Bit is
  generic(N: integer := 64);
  port(i_CLK        : in std_logic;     -- Clock input
       i_RST        : in std_logic;     -- Reset input
       i_WE         : in std_logic;     -- Write enable input
       i_D          : in std_logic_vector(N-1 downto 0);     -- Data value input
       o_Q          : out std_logic_vector(N-1 downto 0));   -- Data value output

end dffg_64Bit;

architecture structural of dffg_64Bit is
	component dffg
	port(
        i_CLK        : in std_logic;     -- Clock input
        i_RST        : in std_logic;     -- Reset input
        i_WE         : in std_logic;     -- Write enable input
        i_D          : in std_logic;     -- Data value input
        o_Q          : out std_logic);   -- Data value output
	end component;
	signal s_Q : std_logic_vector(N-1 downto 0);
	signal s_D : std_logic_vector(N-1 downto 0);

begin
	-- What I had before
	o_Q <= s_Q;
	with i_WE select
    		s_D <= i_D when '1',
        	s_Q when others;
	 process (i_CLK, i_RST)
 	 begin
    		if (i_RST = '1') then
      			s_Q <= (others => '0');
    		elsif (rising_edge(i_CLK)) then
      			s_Q <= s_D;
    		end if;
	end process;
	--G_dffg_NBit: for i in 0 to N-1 generate
		--dffgI : dffg port map(i_CLK	=> i_CLK,
				      --i_RST	=> i_RST,
				      --i_WE	=> i_WE,
				      --i_D	=> i_D(i),
				      --o_Q	=> o_Q(i));
	--end generate G_dffg_NBit;
end structural;