-------------------------------------------------------------------------
-- Joseph Zambreno
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- dffg.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of an edge-triggered
-- flip-flop with parallel access and reset.
--
--
-- NOTES:
-- 8/19/16 by JAZ::Design created.
-- 11/25/19 by H3:Changed name to avoid name conflict with Quartus
--          primitives.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity shiftleft2 is

  port(in32        : in std_logic_vector(31 downto 0);  
       out32shifted         : out std_logic_vector(31 downto 0));  

end shiftleft2;

architecture dataflow of shiftleft2 is

begin
	out32shifted <= in32(29 downto 0) & "00";

end dataflow;