 library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity prom3_asteroid is
    port ( 

		rom_addra  : in std_logic_vector(7 downto 0);
        D: out STD_LOGIC_VECTOR (0 to 60)
    );
end prom3_asteroid;

architecture prom3_asteroid of prom3_asteroid is   
type rom_array is array (NATURAL range <>) of STD_LOGIC_VECTOR (0 to 60);
constant rom: rom_array := ( 
	"0000111111110000000000000000000000000000000000000000000000000",		--0
	"0000100000011111111100000000000000000000000000000000000000000",		--1
	"0000100000000000000111110000011111111111111111000000000000000", 		--2
	"0000100000000000000000001111100000000000000001100000000000000", 		--3
	"0000100000000000000000000000000000000000000001100000000000000", 		--4
	"0000100000000000000000000000000000000000000000111111100000000", 		--5
	"0000100000000000000000000000000000000000000000000000110000000", 		--6
	"0000111100000000000000000000000000000000000000000000110000000", 		--7
	"0000000010000000000000000000000000000000000000000000110000000", 		--8
	"0000000001000000000000000000000000000000000000000000001000000", 		--9
	"0000000001000000000000000000000000000000000000000000000100000", 		--10
	"0000000001000000000000000000000000000000000000000000000010000", 		--11
	"1111111111000000000000000000000000000000000000000000000001000", 		--12
	"1000000000000000000000000000000000000000000000000000000000100", 		--13
	"1000000000000000000000000000000000000000000000000000000000010", 		--14
	"0100000000000000000000000000000000000000000000000001111111100", 		--15
	"0010000000000000000000000000000000000000000000000010000000000", 		--16
	"0001000000000000000000000000000000000000000000000010000000000",	 	--17 
	"0000100000000000000000000000000000000000000000000010000000000",		--18
	"0000010000000000000000000000000000000000000000000010000000000",		--19
	"0000010000000000000000000000000000000000000000000001000000000",		--20
	"0000011111111111111111111100000000000000000000000000100000000",		--21
	"0000000000000000000000000100000000000000000000000000011000000",		--22
	"0000000000000000000000000100000000000000000000000000001100000",		--23
	"0000000000000000000000000111111111111111111111111111111100000"		--24
	);
begin
process(rom_addra)
variable j: integer;
	begin
	     j := conv_integer(rom_addra);
   		 D <= rom(j);
end process;
end prom3_asteroid;