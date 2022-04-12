-------------------------------------------------------------------------
-- Eduardo Contreras
-- CPR E 381
-- Full Adder Lab 1
-------------------------------------------------------------------------


-- fulladder.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a 1-bit full adder 
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity fulladder is

 port(
      i_Ain          : in std_logic;
      i_Bin          : in std_logic;
      i_Cin          : in std_logic;
      o_S            : out std_logic;
      o_Cout         : out std_logic);

end fulladder;

architecture structure of fulladder is

 component org2 
  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);
 end component;

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

  -- Signal to carry A xor B
  signal s_AxorB                : std_logic;
  -- Signal to carry A and B
  signal s_AxB          	: std_logic;
  -- Signal to carry (A xor B) and Cin
  signal s_AxorBandCin          : std_logic;

begin


  ---------------------------------------------------------------------------
  -- Level 1: calculate Ain * Bin by anding them together and placing
  -- result in signal s_AxB
  -- Also
  -- Use xor to calculate the first input (Ain) xor the second input (Bin)
  -- A xor B
  ---------------------------------------------------------------------------
  g_AND1: andg2
    port MAP(i_A              => i_Ain,
	     i_B      	      => i_Bin,
             o_F              => s_AxB);

  g_XOR1: xorg2
    port MAP(i_A               => i_Ain,
	     i_B      	       => i_Bin,
             o_F               => s_AxorB);

  ---------------------------------------------------------------------------
  -- Level 2: calculate (A xor B) and Cin
  -- Calculate (A xor B) xor Cin  
  ---------------------------------------------------------------------------

   g_AND2: andg2
    port MAP(i_A              => s_AxorB,
	     i_B      	      => i_Cin,
             o_F              => s_AxorBandCin);

  g_XOR2: xorg2
    port MAP(i_A               => s_AxorB,
	     i_B      	       => i_Cin,
             o_F               => o_S);

  ---------------------------------------------------------------------------
  -- Level 3: calculate (A and B) or ((A xor B) and Cin) 
  ---------------------------------------------------------------------------

  g_OR1: org2
    port MAP(i_A               => s_AxB,
	     i_B      	       => s_AxorBandCin,
             o_F               => o_Cout);

end structure;
