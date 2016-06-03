library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity prom_explode is
    port ( 
		 clr : in std_logic;
		 destroy : in STD_LOGIC;	
		 destroyA1 : in STD_LOGIC;
		 destroyA2 : in STD_LOGIC;
		 destroyA3 : in STD_LOGIC;
		 destroyA4 : in STD_LOGIC;
		clkslow : in std_logic;
		rom_addra  : in std_logic_vector(7 downto 0);
        D: out STD_LOGIC_VECTOR (0 to 60);
		reset : out std_logic
    );
end prom_explode;

architecture prom_explode of prom_explode is 
type state_type is (s0, s1,s2);
signal state: state_type := s0;
signal dead, reset1 : std_logic;
signal count : std_logic_vector(1 downto 0);
type rom_array is array (NATURAL range <>) of STD_LOGIC_VECTOR (0 to 60);
type rom1_array is array (NATURAL range <>) of STD_LOGIC_VECTOR (0 to 60);
type rom2_array is array (NATURAL range <>) of STD_LOGIC_VECTOR (0 to 60);
constant rom: rom_array := ( 
	"0000000000000000000000000000000000000000000000000000000000000",		--0
	"0000000000000000000000000000000000000000000000000000000000000",		--1
	"0000000000000000000000000000000000000000000000000000000000000", 		--2
	"0000000000000000000000000000000000000000000000000000000000000", 		--3
	"0000000000000000000000000000000000000000000000000000000000000", 		--4
	"0000000000000000000000000000000000000000000000000000000000000", 		--5
	"0000000000000000000000000000000000000000000000000000000000000", 		--6
	"0000000000000000000000000000000000000000000000000000000000000", 		--7
	"0000000000000000000000000000111110000000000000000000000000000", 		--8
	"0000000000000000000000000111111111110000000000000000000000000", 		--9
	"0000000000000000000000011111111111111100000000000000000000000", 		--10
	"0000000000000000000000000111111111110000000000000000000000000", 		--11
	"0000000000000000000000000000111110000000000000000000000000000", 		--12
	"0000000000000000000000000000000000000000000000000000000000000", 		--13
	"0000000000000000000000000000000000000000000000000000000000000", 		--14
	"0000000000000000000000000000000000000000000000000000000000000", 		--15
	"0000000000000000000000000000000000000000000000000000000000000", 		--16
	"0000000000000000000000000000000000000000000000000000000000000",	 	--17 
	"0000000000000000000000000000000000000000000000000000000000000",		--18
	"0000000000000000000000000000000000000000000000000000000000000",		--19
	"0000000000000000000000000000000000000000000000000000000000000",		--20
	"0000000000000000000000000000000000000000000000000000000000000",		--21
	"0000000000000000000000000000000000000000000000000000000000000",		--22
	"0000000000000000000000000000000000000000000000000000000000000",		--23
	"0000000000000000000000000000000000000000000000000000000000000"		--24
	);
constant rom1: rom1_array := (
	"0000000000000000000000000000000000000000000000000000000000000",		--0
	"0000000000000000000000000000000000000000000000000000000000000",		--1
	"0000000000000000000000000000000000000000000000000000000000000", 		--2
	"0000000000000000000000000000000000000000000000000000000000000", 		--3
	"0000000000000000000000000000000000000000000000000000000000000", 		--4
	"0000000000000000000010000100000000010001000000000000000000000", 		--5
	"0000000000000000000000100010000000100100000000000000000000000", 		--6
	"0000000000000000000000000011000000110000000000000000000000000", 		--7
	"0000000000000000000000001000111110110000000000000000000000000", 		--8
	"0000000000000000011000100000000000000010001100000000000000000", 		--9
	"0000000000000000000000011000000000001100000000000000000000000", 		--10
	"0000000000000000011000100000000000000010001100000000000000000", 		--11
	"0000000000000000000000001000111110110000000000000000000000000", 		--12
	"0000000000000000000000010001001001001000000000000000000000000", 		--13
	"0000000000000000000000100010000000100100000000000000000000000", 		--14
	"0000000000000000000010000100000000010001000000000000000000000", 		--15
	"0000000000000000000000000000000000000000000000000000000000000", 		--16
	"0000000000000000000000000000000000000000000000000000000000000",	 	--17 
	"0000000000000000000000000000000000000000000000000000000000000",		--18
	"0000000000000000000000000000000000000000000000000000000000000",		--19
	"0000000000000000000000000000000000000000000000000000000000000",		--20
	"0000000000000000000000000000000000000000000000000000000000000",		--21
	"0000000000000000000000000000000000000000000000000000000000000",		--22
	"0000000000000000000000000000000000000000000000000000000000000",		--23
	"0000000000000000000000000000000000000000000000000000000000000"		--24  
	);
constant rom2: rom2_array := (
	"0000000000000000000000000000000000000000000000000000000000000",		--0
	"0000000000000000000000000011111111111100000000000000000000000",		--1
	"0000000000000000000001111111111111111111111000000000000000000", 		--2
	"0000000000000000000111111111111111111111111110000000000000000", 		--3
	"0000000000000000011111111111111111111111111111000000000000000", 		--4
	"0000000000000001111111111111111111111111111111100000000000000", 		--5
	"0000000000000001111000000011111111111000000111100000000000000", 		--6
	"0000000000000001110000000001110101110000000011100000000000000", 		--7
	"0000000000000000110000000001100100110000000011000000000000000", 		--8
	"0000000000000000111000000011100100111000000111000000000000000", 		--9
	"0000000000000000011111111111110101111111111110000000000000000", 		--10
	"0000000000000000110001111111111111111111100011000000000000000", 		--11
	"0000000000000000110000111111111111111111000011000000000000000", 		--12
	"0000000000000000111000011111111111111110000111000000000000000", 		--13
	"0000000000000000011100011001100011000110001110000000000000000", 		--14
	"0000000000000000001100000110011100011000001100000000000000000", 		--15
	"0000000000000000000111111111111111111111111000000000000000000", 		--16
	"0000000000000000000001111111111111111111100000000000000000000",	 	--17 
	"0000000000000000000000000011111111110000000000000000000000000",		--18
	"0000000000000000000000000000000000000000000000000000000000000",		--19
	"0000000000000000000000000000000000000000000000000000000000000",		--20
	"0000000000000000000000000000000000000000000000000000000000000",		--21
	"0000000000000000000000000000000000000000000000000000000000000",		--22
	"0000000000000000000000000000000000000000000000000000000000000",		--23
	"0000000000000000000000000000000000000000000000000000000000000"		--24  
	);	  
begin 

process(clkslow, clr) 
begin
if clr = '1' then 
	dead <= '0';
	reset <= '1';
	reset1 <= '1';
elsif clkslow'event and clkslow ='1' then

	case state is
		when s0 =>
			reset1 <= '0';
			count <= "00";	   
			reset <= '0'; 
			dead <= '0';
			state <= s1;
		when s1 =>
   		 count <= "00";	 
		 dead <= (destroy or destroyA1 or destroyA2 or destroyA3 or destroyA4);
		 if dead = '1' then
		 state <= s2;
		 end if;
		when s2	=>
			if count < "10" then
				count <= count + 1;
			elsif count = "10" then
				 count <= count;
			end if;
			if reset1 = '1' then
				state <= s0;
			end if;
	end case;
end if;
end process;
process(rom_addra)
variable j: integer;
begin
	if count = "00"	 then
	     j := conv_integer(rom_addra);
   		 D <= rom(j);
	elsif count = "01" then
	     j := conv_integer(rom_addra);
   		 D <= rom1(j);	
	elsif count = "10" then
	     j := conv_integer(rom_addra);
   		 D <= rom2(j);
	end if;
end process;
end prom_explode;