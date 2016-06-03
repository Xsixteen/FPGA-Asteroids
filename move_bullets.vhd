

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_unsigned.all;

entity move_bullets is
	 port(
	 clr : in STD_LOGIC;
	 	 clk190 : in STD_LOGIC;
		 startC1 : in STD_LOGIC_VECTOR(9 downto 0);
		 startR1 : in STD_LOGIC_VECTOR(9 downto 0);
		 nextb : out STD_LOGIC;	
		 S : in STD_LOGIC_VECTOR(7 downto 0);
		 rightside : in STD_LOGIC;
		 xkey: in STD_LOGIC_VECTOR(15 downto 0); 
		 inb : in STD_LOGIC;	
		 outC1 : out STD_LOGIC_VECTOR(9 downto 0);
		 outR1 : out STD_LOGIC_VECTOR(9 downto 0)
	     );
end move_bullets;



architecture move_bullets of move_bullets is  

type state_type is (s0, s1);
signal state: state_type := s0;  
signal curR1, curC1,intR2,intC2, C1in,R1in : STD_LOGIC_VECTOR(9 downto 0);	   
signal nextbbit : STD_LOGIC;
signal waitbits, intS : STD_LOGIC_VECTOR(7 downto 0);	
signal alivebits: STD_LOGIC_VECTOR(9 downto 0);
signal intrightside : std_logic;
signal mag : std_logic_vector(8 downto 0);	
signal startCa : STD_LOGIC_VECTOR(9 downto 0);
signal startRa : STD_LOGIC_VECTOR(9 downto 0);
constant KEY_SPACE: std_logic_vector(15 downto 0) := X"2929";
constant KEY_SPACE1: std_logic_vector(15 downto 0) := X"F029";
begin	
		  
	process(clk190, clr)
	begin
		
	--begin
	if clr = '1' then

  	elsif clk190'event and clk190 = '1' then
		  
		  case state is
			  when s0 =>	
			  alivebits <=X"00" & "00";
			  nextbbit <='0';
			  intC2 <= "1111111111"; 
			  intR2 <= "1111111111";
			  waitbits <=X"00";	
			 
			  
			  if (xkey = KEY_SPACE) and (inb ='1') then  	
		  intrightside <= rightside;
			  intS <= S;
			  intR2 <= startR1;
			  intC2 <=startC1+20;
			  state<=s1;	
			  end if;
		-- State 1 Actual bullet movement is processed here	  
			  when s1=>
			  -- Wait bits is the trigger until you cna fire the next bullet
			 if waitbits > "001101"  then
				 
				--safe to fire 
			  nextbbit <='1';
			 else		
				 waitbits <= waitbits +1;
			 end if;
			 
-----------------------------------------
--									   --
--			 --bullet movement		   --
----------------------------------------- 
		  
   		    
		  if (intS = X"00") and (intrightside = '0') then					   --0	
				  	intR2 <= intR2 -12;					  
					intC2 <= intC2;	
		  elsif (intS = X"00") and (intrightside = '1') then 					--0	   
				  	intR2 <= intR2 -12;					  
					intC2 <= intC2;	
		  elsif (intS = X"01") and (intrightside = '0') then	 --1  		 
			  		intR2 <= intR2 -11;
					intC2 <= intC2 - 1;  
		  elsif (intS = X"01") and (intrightside = '1') then	  --1	   
			  		intR2 <= intR2 - 11; 
					intC2 <= intC2 + 1;		
		  elsif (intS = X"02") and (intrightside = '0') then	 --2   
			  		intR2 <= intR2 - 10;
					intC2 <= intC2 - 2;  	  
		  elsif (intS = X"02") and (intrightside = '1') then	 --2  
			  		intR2 <= intR2 - 10;
					intC2 <= intC2 +2;  	
		  elsif (intS = X"03") and (intrightside = '0') then	 --3
			  		intR2 <= intR2 - 9; 
					intC2 <= intC2 -3; 							   -------------------------------
		  elsif (intS = X"03") and (intrightside = '1')then	 --3	
			  		intR2 <= intR2 - 9;
					intC2 <= intC2 + 3;	
		  elsif (intS = X"04") and (intrightside = '0') then	 --4   
			  		intR2 <= intR2 - 8; 
					intC2 <= intC2 -4; 	  				   -------------------------------
		  elsif (intS = X"04") and (intrightside = '1') then	 --4	
			  		intR2 <= intR2 -8;
					intC2 <= intC2 + 4;		
		  elsif (intS = X"05") and (intrightside = '0') then	 --5
			  		intR2 <= intR2 - 7; 
					intC2 <= intC2 - 5; 			   -------------------------------
		  elsif (intS = X"05") and (intrightside = '1') then	 --5
			  		intR2 <= intR2 - 7;
					intC2 <= intC2 + 5;		 
		  elsif (intS = X"06") and (intrightside = '0') then	 --6 
			  		intR2 <= intR2 - 6; 
					intC2 <= intC2 - 6;  				   -------------------------------
		  elsif (intS = X"06") and (intrightside = '1') then	 --6
					intR2 <= intR2 - 6;
					intC2 <= intC2 +6;	 
		  elsif (intS = X"07") and (intrightside = '0') then	 --7   	   
					intR2 <= intR2 -5; 
					intC2 <= intC2 - 7; 			   -------------------------------
		  elsif (intS = X"07") and (intrightside = '1') then	 --7	
			  		intR2 <= intR2 - 5;
					intC2 <= intC2 + 7;	  
		  elsif (intS = X"08") and (intrightside = '0') then	 --8	
					intR2 <= intR2 - 4; 
					intC2 <= intC2 -8;
		  elsif (intS = X"08") and (intrightside = '1') then	 --8
					intR2 <= intR2 - 4;
					intC2 <= intC2 + 8;	
		   elsif (intS = X"09") and (intrightside = '0') then	 --9	
			   		intR2 <= intR2 -3; 
					intC2 <= intC2 - 9;				   -------------------------------
		  elsif (intS = X"09") and (intrightside = '1') then	 --9	
			  		intR2 <= intR2 - 3;
					intC2 <= intC2 + 9;	 
		  elsif (intS = X"0A") and (intrightside = '0') then	 --10	
			  		intR2 <= intR2 - 2; 
					intC2 <= intC2 -10;				   -------------------------------
		  elsif (intS = X"0A") and (intrightside = '1') then	 --10	
			  		intR2 <= intR2 - 2;
					intC2 <= intC2 + 11;	
		  elsif (intS = X"0B") and (intrightside = '0') then	 --11	
			  		intR2 <= intR2 - 2;
					intC2 <= intC2 - 10;    					   -------------------------------
		  elsif (intS = X"0B") and (intrightside = '1') then	 --11	
			  		intR2 <= intR2 -1;
					intC2 <= intC2 + 11;		  
		  elsif (intS = X"0C") and (intrightside = '0') then	 --12  
			  		intC2 <= intC2 - 12; 
			  		intR2 <= intR2;
		  elsif (intS = X"0C") and (intrightside = '1') then	  --12	 
			  		intR2 <= intR2;
				  	intC2 <= intC2 + 12;	
		  elsif (intS = X"0D") and (intrightside = '0') then	 --13	
			  		intR2 <= intR2 + 1; 
					intC2 <= intC2 - 11; 	  -------------------------------
		  elsif (intS = X"0D") and (intrightside = '1') then	 --13
			  		intR2 <= intR2 + 1;
					intC2 <= intC2 + 11;	 
		  elsif (intS = X"0E") and (intrightside = '0') then	 --14		
			  		intR2 <= intR2 + 2; 
					intC2 <= intC2 - 10;		   -------------------------------
		  elsif (intS = X"0E") and (intrightside = '1') then	 --14
			  		intR2 <= intR2 + 2;
					intC2 <= intC2 + 10;	  	
		  elsif (intS = X"0F") and (intrightside = '0') then	 --15  	
			  		intR2 <= intR2 + 3; 
					intC2 <= intC2 - 9;			   -------------------------------
		  elsif (intS = X"0F") and (intrightside = '1') then	 --15	
			  		intR2 <= intR2 +3;
					intC2 <= intC2 + 9;		  
		  elsif (intS = X"10") and (intrightside = '0') then	 --16	
			  		intR2 <= intR2 + 4; 
					intC2 <= intC2 - 8;  					   -------------------------------
		  elsif (intS = X"10") and (intrightside = '1') then	 --16  	
			  		intR2 <= intR2 +4;
					intC2 <= intC2 + 8;			
		  elsif (intS = X"11") and (intrightside = '0') then	 --17  
			  		intR2 <= intR2 + 5; 
					intC2 <= intC2 - 7; 		   -------------------------------
		  elsif (intS = X"11") and (intrightside = '1') then	 --17	
			  		intR2 <= intR2 + 5;
					intC2 <= intC2 +7;	   
		  elsif (intS = X"12") and (intrightside = '0') then	 --18	 
			  		intR2 <= intR2 + 6; 
					intC2 <= intC2 -6; 					   -------------------------------
		  elsif (intS = X"12") and (intrightside = '1') then	 --18	
			  		intR2 <= intR2 + 6;
					intC2 <= intC2 + 6;	 
		  elsif (intS = X"13") and (intrightside = '0') then	 --19
			  		intR2 <= intR2 + 7; 
					intC2 <= intC2 - 5;   					   -------------------------------
		  elsif (intS = X"13") and (intrightside = '1') then	 --19	 
			  		intR2 <= intR2 + 7;
					intC2 <= intC2 +5;	
		  elsif (intS = X"14") and (intrightside = '0') then	 --20	 
			  		intR2 <= intR2 + 8; 
					intC2 <= intC2 -4; 			  					   -------------------------------
		  elsif (intS = X"14") and (intrightside = '1') then	 --20	
			  		intR2 <= intR2 + 8;
					intC2 <= intC2 + 4;			   
		  elsif (intS = X"15") and (intrightside = '0') then	 --21	
			  		intR2 <= intR2 + 9; 
					intC2 <= intC2 - 3; 		   					   -------------------------------
		  elsif (intS = X"15") and (intrightside = '1') then	 --21	
			  		intR2 <= intR2 + 9;
					intC2 <= intC2 +3;		 
		  elsif (intS = X"16") and (intrightside = '0') then	 --22	  	
			  		intR2 <= intR2 + 10;	  
					intC2 <= intC2 - 2;  								  ---------------------------------------
		  elsif (intS = X"16") and (intrightside = '1')then	  --22
			  		intR2 <= intR2 + 10;	   
					intC2 <= intC2 + 2;		   	  
		  elsif (intS = X"17") and (intrightside = '0') then	 --23
			  		intR2 <= intR2 + 11;		  
					intC2 <= intC2 - 1;  			   
		  elsif (intS = X"17") and (intrightside = '1') then	  --23	 
			  		intR2 <= intR2 + 11;	
					intC2 <= intC2 +1;			   
		  elsif (intS = X"18") and (intrightside = '0') then				--24 
			  		intR2 <= intR2 + 12;	
			  		intC2 <= intC2;		  
		  elsif intS = X"18" and (intrightside = '1') then 				--24	
			  		intR2 <= intR2 + 12;
					intC2 <= intC2;			  
		  end if;
		   
		  if alivebits > "10100000" then
			  state <= s0; 
		  else 
			  alivebits <= alivebits + 1;
			  end if;

			
			  
			  when others =>  state <= s0;
		  end case;	 	

		  
	  end if; 
	  -- Assign outputs

	  outC1 <= intC2;
	  outR1 <= intR2; 
	  nextb <=nextbbit;
	  end process;
	  
	  


end move_bullets;
