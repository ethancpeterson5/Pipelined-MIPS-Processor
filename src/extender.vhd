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

entity extender is

 port(
      in16		: in std_logic_vector(15 downto 0);
      sel		: in std_logic;
      out32		: out std_logic_vector(31 downto 0));	


end extender;

architecture my_extender of extender is


begin
  p_extender : process (in16, sel)
  begin
	
    if sel = '1' then

      if in16(15) = '1' then 
  	out32 <= x"FFFF" & in16;
      else
	out32 <= x"0000" & in16;
      end if;

    else 
     out32 <= x"0000" & in16;
  
    end if;

  end process;

end my_extender;