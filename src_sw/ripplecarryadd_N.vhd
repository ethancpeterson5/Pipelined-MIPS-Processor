-------------------------------------------------------------------------
-- Eduardo Contreras
-- CPR E 381 Lab 1
-- N-bit ripple carry adder
-------------------------------------------------------------------------


-- ripplecarryadd_N.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of an N-bit wide 
-- full adder (ripple carry adder) using structural VHDL, generics,
-- and generate statements.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity ripplecarryadd_N is
  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(
      i_Ain          : in std_logic_vector(N-1 downto 0);
      i_Bin          : in std_logic_vector(N-1 downto 0);
      i_Cin          : in std_logic;
      o_Cout         : out std_logic;
      o_R            : out std_logic_vector(N-1 downto 0));

end ripplecarryadd_N;

architecture structural of ripplecarryadd_N is

  component fulladder is

    port(
      i_Ain          : in std_logic;
      i_Bin          : in std_logic;
      i_Cin          : in std_logic;
      o_S            : out std_logic;
      o_Cout         : out std_logic);

  end component;

  signal s_Cin      : std_logic_vector(N-1 downto 0);
  signal s_S	     : std_logic_vector(N-1 downto 0);

begin

    ADDER1: fulladder port map(
      
      i_Ain       => i_Ain(0),
      i_Bin       => i_Bin(0),
      i_Cin       => i_Cin,
      o_S         => s_S(0),
      o_Cout      => s_Cin(0));   
 
    ADDER2: fulladder port map(
      
      i_Ain       => i_Ain(N-1),
      i_Bin       => i_Bin(N-1),
      i_Cin       => s_Cin(N-2),
      o_S         => s_S(N-1),
      o_Cout      => s_Cin(N-1)); 

  G_NBit_ADDER: for i in 1 to N-2 generate
    ADDER: fulladder port map(
      
      i_Ain       => i_Ain(i),
      i_Bin       => i_Bin(i),
      i_Cin       => s_Cin(i-1),
      o_S         => s_S(i),
      o_Cout      => s_Cin(i));          

  end generate G_NBit_ADDER;

  o_Cout <= s_Cin(N-1); 
  o_R <= s_S;
  
  
end structural;