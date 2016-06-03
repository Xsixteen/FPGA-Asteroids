

library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use IEEE.STD_LOGIC_UNSIGNED.All;

entity vgatest is	   
	port ( vidon: in std_logic;
			rightside : in std_logic;	
			destroy : in STD_LOGIC;
			hc : in std_logic_vector(9 downto 0);
            vc : in std_logic_vector(9 downto 0); 
			R1 : in STD_LOGIC_VECTOR(9 downto 0);
			C1 : in STD_LOGIC_VECTOR(9 downto 0);
			Rd : in STD_LOGIC_VECTOR(9 downto 0);
			Cd : in STD_LOGIC_VECTOR(9 downto 0); 
			Ra : in STD_LOGIC_VECTOR(9 downto 0);
			Ca : in STD_LOGIC_VECTOR(9 downto 0);
			Rb : in STD_LOGIC_VECTOR(9 downto 0);
			Cb : in STD_LOGIC_VECTOR(9 downto 0);
			Rc : in STD_LOGIC_VECTOR(9 downto 0);
			Cc : in STD_LOGIC_VECTOR(9 downto 0);
			bulletR1 : in STD_LOGIC_VECTOR(9 downto 0);
			bulletC1 : in STD_LOGIC_VECTOR(9 downto 0);
			bulletID : in STD_LOGIC;	  
            red : out std_logic_vector(2 downto 0);
			rom_addr4  : out std_logic_vector(7 downto 0); 
			rom1_addr4  : out std_logic_vector(7 downto 0);			
			rom2_addr4  : out std_logic_vector(7 downto 0);			
			rom3_addr4  : out std_logic_vector(7 downto 0);		
			rom4_addr4  : out std_logic_vector(7 downto 0);	 
			rom5_addr4  : out std_logic_vector(7 downto 0);
            green : out std_logic_vector(2 downto 0); 
			sw : in std_logic_vector(7 downto 0);											 
			xkey: in STD_LOGIC_VECTOR(15 downto 0); 
			M : in std_logic_vector(38 downto 0);
			D : in std_logic_vector(60 downto 0);
			D1 : in std_logic_vector(60 downto 0);
			D2 : in std_logic_vector(60 downto 0);
			D3 : in std_logic_vector(60 downto 0); 
			D4 : in std_logic_vector(60 downto 0);
		inC1 : in STD_LOGIC_VECTOR(9 downto 0);
		 inR1 : in STD_LOGIC_VECTOR(9 downto 0);  
		  inC12 : in STD_LOGIC_VECTOR(9 downto 0);
		 inR12 : in STD_LOGIC_VECTOR(9 downto 0);
		  inC13 : in STD_LOGIC_VECTOR(9 downto 0);
		 inR13 : in STD_LOGIC_VECTOR(9 downto 0);
		  inC14 : in STD_LOGIC_VECTOR(9 downto 0);
		 inR14 : in STD_LOGIC_VECTOR(9 downto 0);
		  inC15 : in STD_LOGIC_VECTOR(9 downto 0);
		 inR15 : in STD_LOGIC_VECTOR(9 downto 0); 
		 destroyA1 : in STD_LOGIC;
		 destroyA2 : in STD_LOGIC;
		 destroyA3 : in STD_LOGIC;
		 destroyA4 : in STD_LOGIC;
		 blue : out std_logic_vector(1 downto 0));

end vgatest;

--}} End of automatically maintained section

architecture vgatest of vgatest is

constant hbp: std_logic_vector(9 downto 0) := "0010010000";	 
constant vbp: std_logic_vector(9 downto 0) := "0000011111";	 
signal w: std_logic_vector(5 downto 0);
signal h: std_logic_vector(5 downto 0); 
constant w2: integer := 61;
constant h2: integer := 25;
constant wb: integer := 2;
constant hb: integer :=2;
--signal C1, R1: std_logic_vector(10 downto 0);				
signal rom_addr, rom1_addr,rom2_addr,rom3_addr,rom4_addr,rom5_addr, rom_pix,rom_pix1,rom_pix2,rom_pix3,rom_pix4,rom_pix5,rom_pixa: std_logic_vector(10 downto 0);		
signal spriteon, spriteon1, bullet, bullet2,bullet3,bullet4,bullet5, R, G, B, asson,asson1,asson2,asson3: std_logic;
signal Ma : std_logic_vector(60 downto 0);
begin							
	rom_addr4 <= rom_addr(7 downto 0);		
	rom1_addr4 <= rom1_addr(7 downto 0);	
	rom2_addr4 <= rom2_addr(7 downto 0);	
	rom3_addr4 <= rom3_addr(7 downto 0);	
	rom4_addr4 <= rom4_addr(7 downto 0);
	rom5_addr4 <= rom5_addr(7 downto 0);
		rom1_addr <= vc - vbp - Rd;	
		rom_pix1 <= hc - hbp - Cd;

		rom2_addr <= vc - vbp - Ra;
		rom_pix2 <= hc - hbp - Ca;

		rom3_addr <= vc - vbp - Rb; 
		rom_pix3 <= hc - hbp - Cb;

		rom4_addr <= vc - vbp - Rc;
		rom_pix4 <= hc - hbp - Cc; 
		rom_pix5 <= hc - hbp - C1;
process(rightside)
begin
if rightside = '0' then
	   rom_pix <= not(hc - hbp - C1-39);
	   rom_addr <= vc - vbp - R1;
elsif rightside = '1' then
	   rom_pix <= hc - hbp - C1;
	   rom_addr <= vc - vbp - R1;
	end if;
end process;	

	--Enable sprite video out when within the sprite region
 	spriteon1 <= '1' when (((hc >= C1 + hbp) and (hc < C1 + hbp + w))
and ((vc >= R1 + vbp) and (vc < R1 + vbp + h))) else '0'; 

--Enable sprite video out when within the sprite region
	bullet <= '1' when (((hc >=  inC1 + hbp) and (hc <  inC1 + hbp + wb))
and ((vc >= inR1 + vbp) and (vc < inR1 + vbp + hb))) else '0';					
	
			--Enable sprite video out when within the sprite region
	bullet2 <= '1' when (((hc >=  inC12 + hbp) and (hc <  inC12 + hbp + wb))
and ((vc >= inR12 + vbp) and (vc <  inR12 + vbp + hb))) else '0';			 
	
			--Enable sprite video out when within the sprite region
	bullet3 <= '1' when (((hc >=  inC13 + hbp) and (hc <  inC13 + hbp + wb))
and ((vc >= inR13 + vbp) and (vc <  inR13 + vbp + hb))) else '0';	 
			--Enable sprite video out when within the sprite region
	bullet4 <= '1' when (((hc >=  inC14 + hbp) and (hc <  inC14 + hbp + wb))
and ((vc >= inR14 + vbp) and (vc <  inR14 + vbp + hb))) else '0';	  
			--Enable sprite video out when within the sprite region
	bullet5 <= '1' when (((hc >=  inC15 + hbp) and (hc <  inC15 + hbp + wb))
and ((vc >= inR15 + vbp) and (vc <  inR15 + vbp + hb))) else '0';
	
 	asson <= '1' when (destroyA1 = '0') and (((hc >= Cd + hbp) and (hc < Cd + hbp + w2))
and ((vc >= Rd + vbp) and (vc < Rd + vbp + h2))) else '0';	  
	
 	asson1 <= '1' when (destroyA2 = '0') and (((hc >= Ca + hbp) and (hc < Ca + hbp + w2))
and ((vc >= Ra + vbp) and (vc < Ra + vbp + h2))) else '0';	 
	
 	asson2 <= '1' when (destroyA3 = '0') and (((hc >= Cb + hbp) and (hc < Cb + hbp + w2))
and ((vc >= Rb + vbp) and (vc < Rb + vbp + h2))) else '0';	
	
 	asson3 <= '1' when (destroyA4 = '0') and (((hc >= Cc + hbp) and (hc < Cc + hbp + w2))
and ((vc >= Rc + vbp) and (vc < Rc + vbp + h2))) else '0';	

	

	
process(spriteon1, asson, asson1, asson2, asson3)
begin	

		if spriteon1 = '1'  then 
			if destroy = '0' then
			Ma <= "0000000000000000000000" & M;
			rom_pixa <= rom_pix;
			w <= "100111";
			h <= "010101";
			else 
			rom_pixa <= rom_pix5;
		    Ma <= D4;
			rom5_addr <= rom_addr;
			w <= "111101";
			h <= "011001";
			end if;				 
		elsif (asson = '1')  then	
			Ma <= D;  	
			rom_pixa <= rom_pix1;
		elsif (asson1 = '1') then	
			Ma <= D1;  
			rom_pixa <= rom_pix2;
		elsif (asson2 = '1') then	
			Ma <= D2;  
			rom_pixa <= rom_pix3;
		elsif (asson3 = '1') then	
			Ma <= D3; 
			rom_pixa <= rom_pix4;				   
		end if;
	end process;
spriteon <= (spriteon1 or asson or asson1 or asson2 or asson3 or bullet or bullet2 or bullet3  or bullet4 or bullet );
process(vidon, vc, bullet, bullet2,bullet3,bullet4,bullet5)	   
variable j: integer;

  	begin
		red <= "000";
		green <= "000";
		blue <= "00";	 
		if spriteon = '1' and vidon = '1' then
    			j := conv_integer(rom_pixa);
    			R <= Ma(j);
    			G <= Ma(j);
    			B <= Ma(j);

				if (bullet = '1' or bullet2 = '1' or bullet3 = '1' or bullet4 = '1' or bullet5 = '1') and vidon ='1' then	
			red <= "111";
			green <= "111";
			blue <= "11";
				else		
   			    red <= R & R & R;
    			green <= G & G & G;
    			blue <= B & B;
				end if;

		end if;
			
  	end process;  

end vgatest;
