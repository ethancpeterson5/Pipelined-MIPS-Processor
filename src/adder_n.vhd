-------------------------------------------------------------------------
-- Henry Duwe
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

entity adder_n is
  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_Aa          : in std_logic_vector(N-1 downto 0);
       i_Ba          : in std_logic_vector(N-1 downto 0);
       i_Ca          : in std_logic;
       o_carry	    : out std_logic;
       o_result      : out std_logic_vector(N-1 downto 0);
       o_overflow     : out std_logic);
end adder_n;

architecture structural of adder_n is

  component adder is
    port(i_Aa          : in std_logic;
         i_Ba          : in std_logic;
         i_Ca          : in std_logic;
         o_carry       : out std_logic;
         o_sum	       : out std_logic);
  end component;

signal s_carry : std_logic_vector(N-1 downto 0);
signal s_sum : std_logic_vector(N-1 downto 0);

begin


    ADD1: adder port map(
              i_Aa     => i_Aa(0),     
              i_Ba     => i_Ba(0), 
              i_Ca     => i_Ca,  
              o_carry  => s_carry(0),
	      o_sum    => s_sum(0));  

    ADD32: adder port map(
		i_Aa => i_Aa(N-1),
		i_Ba => i_Ba(N-1),
		i_Ca => s_carry(N-2),
		o_carry => s_carry(N-1),
		o_sum => s_sum(N-1));
		


  -- Instantiate N adder instances.
  G_NBit_ADDER: for i in 1 to N-2 generate
    ADD: adder port map(
              i_Aa     => i_Aa(i),     
              i_Ba     => i_Ba(i), 
              i_Ca     => s_carry(i-1),  
              o_carry  => s_carry(i),
	      o_sum	=> s_sum(i));
	       
  end generate G_NBit_ADDER;
  
o_carry <= s_carry(N-1);
o_result <= s_sum;
o_overflow <= (s_carry(N-1) xor s_carry(N-2));
  
end structural;