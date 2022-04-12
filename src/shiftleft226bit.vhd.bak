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
use work.busArray.array32;

entity shiftleft226bit is

  port(in26        : in std_logic_vector(25 downto 0);  
       out28shifted         : out std_logic_vector(27 downto 0));  

end shiftleft226bit;

architecture dataflow of shiftleft226bit is

begin
	out28shifted <= in26 & "00";

end dataflow;
