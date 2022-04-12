-------------------------------------------------------------------------
-- Josh Van Drie
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- adder_n.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of an N-bit wide 2:1
-- mux using structural VHDL, generics, and generate statements.
--
--
-- NOTES:
-- 1/6/20 by H3::Created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity register_186 is
  generic(N : integer := 186); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_CLKn        : in std_logic;     -- Clock input
       i_RSTn        : in std_logic;     -- Reset input
       i_WEn         : in std_logic;     -- Write enable input
       i_Dn          : in std_logic_vector(N-1 downto 0);     -- Data value input
       o_Qn          : out std_logic_vector(N-1 downto 0));   -- Data value output
end register_186;

architecture structural of register_186 is

  component dffg is
    port(i_CLK        : in std_logic;     -- Clock input
       i_RST        : in std_logic;     -- Reset input
       i_WE         : in std_logic;     -- Write enable input
       i_D          : in std_logic;     -- Data value input
       o_Q          : out std_logic);   -- Data value output
  end component;
signal s_Q: std_logic_vector(N-1 downto 0);
signal s_D: std_logic_vector(N-1 downto 0);

begin
o_Qn <= s_Q;
with i_WEn select
    s_D <= i_Dn when '1',
        s_Q when others;
 process (i_CLKn, i_RSTn)
  begin
    if (i_RSTn = '1') then
      s_Q <= (others => '0');
    elsif (rising_edge(i_CLKn)) then
      s_Q <= s_D;
    end if;
end process;
  
end structural;