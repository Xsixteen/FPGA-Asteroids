 library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity prom_asteroids is
    port ( 
	
		rom_addra  : in std_logic_vector(7 downto 0);
        D: out STD_LOGIC_VECTOR (0 to 60)
    );
end prom_asteroids;

architecture prom_asteroids of prom_asteroids is
type rom_array is array (NATURAL range <>) of STD_LOGIC_VECTOR (0 to 60);

constant rom: rom_array := (
	"0000000000000000000000111111111111111000000000000000000000000",		--0
	"0000000000000000111111100000000000001000000000000000000000000",		--1
	"0000001111111111100000000000000000001000000000000000000000000", 		--2
	"0000001000000000000000000000000000000100000000000000000000000", 		--3
	"0000010000000000000000000000000000000010000000000000000000000", 		--4
	"0000011000000000000000000000000000000001000000000000000000000", 		--5
	"0000000100000000000000000000000000000000111111111111000000000", 		--6
	"0000001000000000000000000000000000000000000000000000100000000", 		--7
	"0000010000000000000000000000000000000000000000000000010000000", 		--8
	"0000100000000000000000000000000000000000000000000000010000000", 		--9
	"0001000000000000000000000000000000000000000000000000010000000", 		--10
	"0001000000000000000000000000000000000000000000000111100000000", 		--11
	"0001000000000000000000000000000000000000000000000110000000000", 		--12
	"0000100000000000000000000000000000000000000000000010000000000", 		--13
	"0000010000000000000000000000000000000000000000000001000000000", 		--14
	"0000001000000000000000000000000000000000000000000010000000000", 		--15
	"0000001000000000000000000000000000000000000000000100000000000", 		--16
	"0000001000000000000000000000000000000000000000000100000000000",	 	--17 
	"0000010000000000000000000000000000000000000000000011000000000",		--18
	"0000100000000000000000000000000000000000000000000001000000000",		--19
	"0001000000000000000000000000000000000000000000000001000000000",		--20
	"0001000000000000000000000000000000000000000000000001000000000",		--21
	"0001000000000000000000000000000000000000000011111110000000000",		--22
	"0001111000000000000000000000000000000111111110000000000000000",		--23
	"0000001111111111111111111111111111111100000000000000000000000"		--24
	);	
begin
process(rom_addra)
variable j: integer;
	begin

    	 j := conv_integer(rom_addra);
   		 D <= rom(j);


end process;
end prom_asteroids;