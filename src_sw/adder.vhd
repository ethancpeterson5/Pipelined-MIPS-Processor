-------------------------------------------------------------------------
-- Joshua Van Drie
-- Department of Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- mux2t1.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a 1-input NOT 
-- gate.
--
--
-- NOTES:
-- 8/19/16 by JAZ::Design created.
-- 1/16/19 by H3::Changed name to avoid name conflict with Quartus 
--         primitives.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity adder is

  port(i_Aa          : in std_logic;
       i_Ba          : in std_logic;
       i_Ca          : in std_logic;
       o_carry	    : out std_logic;
       o_sum	    : out std_logic);

end adder;

architecture structure of adder is

component xorg2
	port(i_A          : in std_logic;
       	     i_B          : in std_logic;
             o_F          : out std_logic);

end component;

component andg2
	port(i_A          : in std_logic;
             i_B          : in std_logic;
	     o_F          : out std_logic);

end component;

component org2
	port(i_A          : in std_logic;
     	     i_B          : in std_logic;
     	     o_F          : out std_logic);

end component;

-- Signal to carry xor0
  signal s_x0        : std_logic;
  -- Signal to carry and0
  signal s_a0	     : std_logic;
  -- Signal to carry and1
  signal s_a1         : std_logic;
 
begin

Xor0: xorg2
	port MAP(i_A => i_Aa,
		i_B => i_Ba,
		o_F => s_x0);

Xor1: xorg2
	port MAP(i_A => s_x0,
		i_B => i_Ca,
		o_F => o_sum);

And0: andg2
    port MAP(i_A          => i_Ca,
             i_B          => s_x0,
	     o_F          => s_A0);

And1: andg2
	port MAP(i_A	=> i_Aa,
		 i_B	=> i_Ba,
		 o_F	=> s_A1);

or0: org2
	port MAP(i_A	=>S_A0,
		 i_B	=>S_A1,
		 o_F	=> o_carry);

end structure;