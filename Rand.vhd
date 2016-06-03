-------------------------------------------------------------------------------
--
-- Title       : Rand
-- Design      : Aster5
-- Author      : Gregory
-- Company     : OaklandU

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.std_logic_unsigned.all;

entity Rand is
	 port(
		 clk25 : in STD_LOGIC;
		 xkey : in STD_LOGIC;
		 RAND : out STD_LOGIC_VECTOR(9 downto 0)
	     );
end Rand;

--}} End of automatically maintained section

architecture Rand of Rand is
begin
	Process(clk25,xkey)
	variable k : std_logic_vector(9 downto 0);
	begin
	if xkey = '1' then
		k := "0000000000";
	elsif clk25'event and clk25 = '1' then
		if k < "1111111111" then
			k := k + 1;
		else
			k := "0000000000";
		end if;
	end if;
	RAND <= k;
	end process;
	 -- enter your statements here --

end Rand;
