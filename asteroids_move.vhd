 library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity asteroids_move is
    port ( 
		clk40hz : in std_logic;
		clr : in std_logic;	
		destroyA1 : in STD_LOGIC;
		destroyA2 : in STD_LOGIC;
		destroyA3 : in STD_LOGIC;
		destroyA4 : in STD_LOGIC;
		RAND : in std_logic_vector(9 downto 0);
		Cd : out std_logic_vector(9 downto 0);
		Rd : out std_logic_vector(9 downto 0);
		Ca : out std_logic_vector(9 downto 0);
        Ra : out std_logic_vector(9 downto 0);
		Cb : out std_logic_vector(9 downto 0);
		Rb : out std_logic_vector(9 downto 0);
		Cc : out std_logic_vector(9 downto 0);
		Rc : out std_logic_vector(9 downto 0)
		);
end asteroids_move;

architecture asteroids_move of asteroids_move is
begin
process(clk40hz, clr)
variable intCd : std_logic_vector(9 downto 0);
variable intRd : std_logic_vector(9 downto 0);
variable intCa : std_logic_vector(9 downto 0);
variable intRa : std_logic_vector(9 downto 0);
variable intCb : std_logic_vector(9 downto 0);
variable intRb : std_logic_vector(9 downto 0);
variable intCc : std_logic_vector(9 downto 0);
variable intRc : std_logic_vector(9 downto 0);
begin
	if clr = '1' then

		intCd := "0110110000";
		intRd := "0001100000";
		intCa := "1100000000";
		intRa := "0001100000";
		intCb := "0001011000";
		intRb := "0011000000";
		intCc := "0000110000";
		intRc := "0011001100";
	elsif clk40hz'event and clk40hz = '1' then
		if destroyA1 = '1' then
			intCa := RAND;
			intRa :=  not RAND;
		end if;
		if destroyA2 = '1' then
			intCb := RAND;
			intRb :=  not RAND;
		end if;
		if destroyA3 = '1' then
			intCc := RAND;
			intRc :=  not RAND;
		end if;
		if destroyA4 = '1' then
			intCd := RAND;
			intRd :=  not RAND;
		end if;
		if intRd > "0111100000"	then	
		  	intRd := "0000000001"; 
		elsif intRd > "0000000000"	 then	
		  	intRd :=  intRd + 1; 	 
		elsif intRd < "0000000001"	then	
		  	intRd := "0111100000";
		end if;
		if intCd > "1010000000"	then	
		  	intCd :=  "0000000001";
		elsif intCd > "0000000000"	then	
		  	intCd := intCd + 1;		   
		elsif intCd < "0000000001"	then	
		  	intCd :=  "1010000000";
		end if;
		if intRa < "0000001111"	 then	
		  	intRa :=  "0111100000";
		elsif intRa < "0111100001"	then	
		  	intRa :=  intRa - 1;
	    elsif intRa > "0111100000"	 then	
		  	intRa :=  "0000001111";
		end if;
		if intCa > "1010000000"	then	
		  	intCa := "0000000001";
		elsif intCa > "0000000000"	then	
		  	intCa := intCa + 1;	
		elsif intCa < "0000000001"	then	
		  	intCa := "1010000000";
		end if;
		if intRb > "0111100000"	then	
		  	intRb := "0000000001";
		elsif intRb > "0000000000"	 then	
		  	intRb :=  intRb + 1;		   
		elsif intRb < "0000000001"	then	
		  	intRb := "0111100000"; 
		end if;
		if intCb < "0000000001"	then	
		  	intCb := "1010000000";
		elsif intCb < "1010000001"	then	
		  	intCb :=  intCb - 1;  			
		elsif intCb > "1010000001"	then	
		  	intCb := "0000000001";		
	    end if;
		if intRc < "0000000001"	 then	
		  	intRc :=  "0111100000";
		elsif intRc < "0111100001"	then	
		  	intRc := intRc - 1;		
		elsif intRc > "0111100001"	 then	
		  	intRc :=  "0000000001";
		end if;	
		if intCc < "000000001"	then	
		  	intCc := "1010000000";	
		elsif intCc < "1010000001"	then	
		  	intCc :=  intCc - 1;
		elsif intCc > "1010000001"	then	
		  	intCc := "0000000001";
		end if;
	end if;
		Cd <= intCd;
		Rd <= intRd;
		Ca <= intCa;
        Ra <= intRa;
		Cb <= intCb;
		Rb <= intRb;
		Cc <= intCc;
		Rc <= intRc;
end process;
end asteroids_move;