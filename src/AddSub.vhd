-------------------------------------------------------------------------
-- Henry Duwe
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- AddSub.vhd
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

entity AddSub is

  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.

  port(i_A_as             : in std_logic_vector(N-1 downto 0);
       i_B_as             : in std_logic_vector(N-1 downto 0);
       n_Add_Sub          : in std_logic;
       o_carry_as	  : out std_logic;
       o_result_as        : out std_logic_vector(N-1 downto 0);
       o_overflow	  : out std_logic);
end AddSub;

architecture structural of AddSub is
--  generic(N : integer := 32);

  component adder_n is
    port(i_Aa          : in std_logic_vector(N-1 downto 0);
       i_Ba          : in std_logic_vector(N-1 downto 0);
       i_Ca          : in std_logic;
       o_carry	    : out std_logic;
       o_result      : out std_logic_vector(N-1 downto 0);
	o_overflow	: out std_logic);
  end component;

  component onescomp is
	port(i_A         : in std_logic_vector(N-1 downto 0);
             o_F         : out std_logic_vector(N-1 downto 0));
  end component;


  component mux2t1_n is
  	port(i_S          : in std_logic;
      	     i_D0         : in std_logic_vector(N-1 downto 0);
      	     i_D1         : in std_logic_vector(N-1 downto 0);
      	     o_O          : out std_logic_vector(N-1 downto 0));
  end component;

--component AddSub is
--  port(i_A_as             : in std_logic_vector(N-1 downto 0);
--       i_B_as             : in std_logic_vector(N-1 downto 0);
--       n_Add_Sub          : in std_logic;
--       o_carry_as	  : out std_logic;
--       o_result_as        : out std_logic_vector(N-1 downto 0));
--end component;
	
signal s_carry : std_logic;
signal s_sum : std_logic_vector(N-1 downto 0);
signal s_comp : std_logic_vector(N-1 downto 0);
signal s_mux : std_logic_vector(N-1 downto 0);

begin

    ADD: adder_n port map(
              i_Aa     	  => i_A_as,     
              i_Ba        => s_mux, 
              i_Ca     => n_Add_Sub,  
              o_carry  => o_carry_as,
	      o_result	  => o_result_as,
	      o_overflow => o_overflow);

    OnesComper: onescomp port map(
		i_A	=> i_B_as,	--edited
		o_F	=> s_comp);
    
    mux: mux2t1_n port map(
		i_S     => n_Add_Sub,
		i_D0	=> i_B_as,
		i_D1	=> s_comp,
		o_O	=> s_mux);

	
  
end structural;