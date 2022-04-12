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

entity register_64 is --WILL BE CHANGED TO 65 FOR HARDWARE SCHEDULED PIPELINE
  generic(N : integer := 64); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_CLK         : in std_logic;     -- Clock input
       i_RST         : in std_logic;     -- Reset input
       i_WE          : in std_logic;     -- Write enable input
       i_D           : in std_logic_vector(N-1 downto 0);     -- Data value input
       o_Q           : out std_logic_vector(N-1 downto 0));   -- Data value output
end register_64;

architecture structural of register_64 is

  component dffg_64bit is
    generic(N: integer := 64);
    port(i_CLK        : in std_logic;     -- Clock input
       i_RST        : in std_logic;     -- Reset input
       i_WE         : in std_logic;     -- Write enable input
       i_D          : in std_logic;     -- Data value input
       o_Q          : out std_logic);   -- Data value output
  end component;
signal s_Q: std_logic_vector(N-1 downto 0);
signal s_D: std_logic_vector(N-1 downto 0);

begin
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
  
end structural;