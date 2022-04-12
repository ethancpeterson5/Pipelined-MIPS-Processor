-------------------------------------------------------------------------
-- Eduardo Contreras
-- CPR E 381
-- Lab2 N-bit D-Flip Flop
-------------------------------------------------------------------------


-- dffg_N.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of an N-bit wide
-- D-Flip Flop using structural VHDL, generics, and generate statements.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity register_N is
  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_CLK        : in std_logic;     		     -- Clock input
       i_RST        : in std_logic;     		     -- Reset input
       i_WE         : in std_logic;     		     -- Write enable input
       i_D          : in std_logic_vector(N-1 downto 0);     -- Data value input
       o_Q          : out std_logic_vector(N-1 downto 0));   -- Data value output

end register_N;

architecture structural of register_N is

  component dffg is
    port(
	i_CLK        : in std_logic;     -- Clock input
        i_RST        : in std_logic;     -- Reset input
        i_WE         : in std_logic;     -- Write enable input
        i_D          : in std_logic;     -- Data value input
        o_Q          : out std_logic);   -- Data value output
  end component;

begin

  -- Instantiate N mux instances.
  G_NBit_REG1: for i in 0 to N-1 generate
    DFF1: dffg port map(
              i_CLK    => i_CLK,      -- All instances share the same select input.
              i_RST    => i_RST,  -- ith instance's data 0 input hooked up to ith data 0 input.
              i_WE     => i_WE,  -- ith instance's data 1 input hooked up to ith data 1 input.
              i_D      => i_D(i),
	      o_Q      => o_Q(i));  -- ith instance's data output hooked up to ith data output.
  end generate G_NBit_REG1;
  
end structural;