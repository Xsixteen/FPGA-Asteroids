library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
 
entity BCD is
    port (
        B: in STD_LOGIC_VECTOR (5 downto 0);
        P: out STD_LOGIC_VECTOR (6 downto 0)
    );
end BCD;	 

architecture BCD of BCD is
begin
  bcd1: process(B)
  variable z: STD_LOGIC_VECTOR (12 downto 0);

	 begin
    	for i in 0 to 12 loop
	   z(i) := '0';
    	end loop;
 	z(8 downto 3) := B;
 
    	for i in 0 to 2 loop
	   if z(9 downto 6) > 4 then	
	      z(9 downto 6) := z(9 downto 6) + 3;
	   end if;
	   z(12 downto 1) := z(11 downto 0);
    	end loop;
		
	P <= z(12 downto 6);	
  end process bcd1;            
end BCD;