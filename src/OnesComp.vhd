-------------------------------------------------------------------------
-- Henry Duwe
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- mux2t1_N.vhd
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

entity OnesComp is
  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_A         : in std_logic_vector(N-1 downto 0);
       o_F          : out std_logic_vector(N-1 downto 0));

end OnesComp;

architecture structural of OnesComp is

  component invg is
    port(i_A          : in std_logic;
       	 o_F          : out std_logic);
  end component;

begin

  -- Instantiate N OnesComp instances.
  G_NBit_OnesComp: for i in 0 to N-1 generate
    COMP: invg port map(
              i_A      => i_A(i),      -- All instances share the same select input.
              o_F      => o_F(i));  -- ith instance's data output hooked up to ith data output.
  end generate G_NBit_OnesComp;
  
end structural;