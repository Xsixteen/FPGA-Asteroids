
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_unsigned.all;

entity controls is	 
	port(
	clr : in STD_LOGIC;	 
	fire : out STD_LOGIC;
	clk40hz : in STD_LOGIC;
	xkey: in STD_LOGIC_VECTOR(15 downto 0); 
	R1 : out STD_LOGIC_VECTOR(9 downto 0);
	C1 : out STD_LOGIC_VECTOR(9 downto 0);		 
	S : out std_logic_vector(7 downto 0);  
	rightside, smotion : out std_logic 
	);
end controls;



architecture controls of controls is	

constant KEY_UP: std_logic_vector(15 downto 0) := X"E075";
constant KEY_UP1: std_logic_vector(15 downto 0) := X"F075";
constant KEY_RIGHT: std_logic_vector(15 downto 0) := X"E074";
constant KEY_RIGHT1: std_logic_vector(15 downto 0) := X"F074";
constant KEY_LEFT: std_logic_vector(15 downto 0) := X"E06B";
constant KEY_LEFT1: std_logic_vector(15 downto 0) := X"F06B";
constant KEY_SPACE: std_logic_vector(15 downto 0) := X"2929";
constant KEY_SPACE1: std_logic_vector(15 downto 0) := X"F029";
type state_type is (s0, s1);
signal state: state_type;

    
signal intR2, intC2 :STD_LOGIC_VECTOR(9 downto 0);	   
signal speed : STD_LOGIC_VECTOR(3 downto 0); 
signal delay : STD_LOGIC_VECTOR(7 downto 0);
signal inmotion, lmotion, rmotion : STD_LOGIC;
signal fireNow : STD_LOGIC;
signal intrightside : std_logic;
signal intrightside1 : std_logic;
signal intS : std_logic_vector(7 downto 0);	
signal intP : std_logic_vector(7 downto 0);	
signal mag : std_logic_vector(8 downto 0);			  
begin	  
 
process(clk40hz, clr, intR2, intC2, xkey, speed, delay, rmotion, lmotion)  
	
	begin
	if clr = '1' then
	   		  intR2 <= "0011011100";	  
			  speed <="0000";
			  delay <=X"00";	  
			  fireNow <= '0';
			  intC2 <=  "0100101100";
			  state <=s1;
			  intS <= "00000000";
			  intrightside <= '0';
			  mag <= "000000000";
			  intP <= "00000000";
			  intrightside1 <= '0';
  	elsif clk40hz'event and clk40hz = '1' then
		  case state is
			  when s0 =>
			  intR2 <= "0011011100";	  
			  speed <="0000";
			  delay <=X"00";	  
			  fireNow <= '0';
			  intC2 <=  "0100101100";
			  state <=s1;
			  intS <= "00000000";
			  intrightside <= '0';
			  mag <= "000000000";
			  intP <= "00000000";
			  intrightside1 <= '0';
		
			  
			  
			  when s1 =>
			
		  if xkey = KEY_LEFT then 
			  lmotion <='1';   
		  elsif xkey = KEY_LEFT1 then
			  lmotion <='0';   
		  elsif xkey = KEY_RIGHT then
			  rmotion <= '1';	
		  elsif xkey = KEY_RIGHT1 then
			  rmotion <= '0';	
  		  elsif xkey = KEY_UP then
			  inmotion <= '1';	
		  elsif xkey = KEY_UP1 then
			  inmotion <= '0'; 
		  end if;

			if lmotion = '1' then
			 if (intS < "00011000") and intrightside = '0' then
				 intS <= intS + 1;
			 elsif (intS = "00011000") and intrightside = '0' then
				 intrightside <= '1';
			 end if;
			 if (intS > "00000000") and intrightside = '1' then
				 intS <= intS - 1;
			 elsif (intS = "00000000") and intrightside = '1' then
				 intrightside <= '0';
			 end if;
		   elsif rmotion = '1' then
			 if (intS > "00000000") and intrightside = '0' then
				 intS <= intS - 1;
			 elsif (intS = "00000000") and intrightside = '0' then
				 intrightside <= '1';
			 end if;
			 if (intS < "00011000") and intrightside = '1' then
				 intS <= intS + 1;
			 elsif (intS = "00011000") and intrightside = '1' then
				 intrightside <= '0';
			 end if;
		   elsif inmotion = '1' then 
			   intP <= intS;
			   intrightside1 <= intrightside;
			  if (mag < "111111111")then
				  mag <= mag + 1; 
			  elsif mag = "111111111"	then
				  mag <= mag;
			  end if; 		
		   elsif inmotion = '0' then
			  if (mag > "000000000")then
				  mag <= mag - 1; 
			  elsif mag = "000000000" then
				  mag <= mag;
			  end if;		  
		  end if;
		  if intP = X"00" and intrightside1 = '0' then					   --0	 
				  	intR2 <= intR2 - mag(8 downto 4);					  
					intC2 <= intC2;		 
		  elsif (intP = X"00") and intrightside1 = '1' then 					--0
				  	intR2 <= intR2 - mag(8 downto 4);					  
					intC2 <= intC2;		  
		  elsif (intP = X"01") and intrightside1 = '0' then	 --1  
				  	intR2 <= intR2 - mag(8 downto 4);
					intC2 <= intC2 - mag(4);   
		  elsif (intP = X"01") and intrightside1 = '1' then	  --1	 
				  	intR2 <= intR2 - mag(8 downto 4); 
					intC2 <= intC2 + mag(4);  
		  elsif (intP = X"02") and intrightside1 = '0' then	 --2 
				  	intR2 <= intR2 - mag(7 downto 4);
					intC2 <= intC2 - mag(4);	
		  elsif (intP = X"02") and intrightside1 = '1' then	 --2 
				  	intR2 <= intR2 - mag(7 downto 4);
					intC2 <= intC2 + mag(4);  
		  elsif (intP = X"03") and intrightside1 = '0' then	 --3		
				  	intR2 <= intR2 - mag(7 downto 4); 
					intC2 <= intC2 - mag(5 downto 4);				   
		  elsif (intP = X"03") and intrightside1 = '1' then	 --3		 
				  	intR2 <= intR2 - mag(7 downto 4);
					intC2 <= intC2 + mag(5 downto 4);			 
		  elsif (intP = X"04") and intrightside1 = '0' then	 --4  
				  	intR2 <= intR2 - mag(7 downto 4); 
					intC2 <= intC2 - mag(5 downto 4); 					
		  elsif (intP = X"04") and intrightside1 = '1' then	 --4	   
				  	intR2 <= intR2 - mag(7 downto 4);
					intC2 <= intC2 + mag(5 downto 4);		 
		  elsif (intP = X"05") and intrightside1 = '0' then	 --5	   
				  	intR2 <= intR2 - mag(6 downto 4); 
					intC2 <= intC2 - mag(6 downto 4);					
		  elsif (intP = X"05") and intrightside1 = '1' then	 --5	
				  	intR2 <= intR2 - mag(6 downto 4);
					intC2 <= intC2 + mag(6 downto 4);			   
		  elsif (intP = X"06") and intrightside1 = '0' then	 --6   
				  	intR2 <= intR2 - mag(6 downto 4); 
					intC2 <= intC2 - mag(6 downto 4);					 
		  elsif (intP = X"06") and intrightside1 = '1' then	 --6	 
				  	intR2 <= intR2 - mag(6 downto 4);
					intC2 <= intC2 + mag(6 downto 4);				
		  elsif (intP = X"07") and intrightside1 = '0' then	 --7   
				  	intR2 <= intR2 - mag(5 downto 4); 
					intC2 <= intC2 - mag(6 downto 4);				   
		  elsif (intP = X"07") and intrightside1 = '1' then	 --7	   
				  	intR2 <= intR2 - mag(5 downto 4);
					intC2 <= intC2 + mag(6 downto 4);		   
		  elsif (intP = X"08") and intrightside1 = '0' then	 --8		
				  	intR2 <= intR2 - mag(5 downto 4); 
					intC2 <= intC2 - mag(6 downto 4);			   
		  elsif (intP = X"08") and intrightside = '1' then	 --8	   
				  	intR2 <= intR2 - mag(5 downto 4);
					intC2 <= intC2 + mag(6 downto 4);		  
		  elsif (intP = X"09") and intrightside1 = '0' then	 --9	  
				  	intR2 <= intR2 - mag(5 downto 4); 
					intC2 <= intC2 - mag(7 downto 4);					
		  elsif (intP = X"09") and intrightside1 = '1' then	 --9		 
				  	intR2 <= intR2 - mag(5 downto 4);
					intC2 <= intC2 + mag(7 downto 4);		   
		  elsif (intP = X"0A") and intrightside1 = '0' then	 --10		 
				  	intR2 <= intR2 - mag(4); 
					intC2 <= intC2 - mag(7 downto 4);				   
		  elsif (intP = X"0A") and intrightside1 = '1' then	 --10		  
				  	intR2 <= intR2 - mag(4);
					intC2 <= intC2 + mag(7 downto 4);		
		  elsif (intP = X"0B") and intrightside1 = '0' then	 --11		
				  	intR2 <= intR2 - mag(4); 
					intC2 <= intC2 - mag(8 downto 4);					
		  elsif (intP = X"0B") and intrightside1 = '1' then	 --11		
				  	intR2 <= intR2 - mag(4);
					intC2 <= intC2 + mag(8 downto 4);		   
		  elsif (intP = X"0C") and intrightside1 = '0' then	 --12  
			  		intC2 <= intC2 - mag(8 downto 4); 
			  		intR2 <= intR2;					 		 
		  elsif (intP = X"0C") and intrightside1 = '1' then	  --12
			  		intR2 <= intR2;
				  	intC2 <= intC2 + mag(8 downto 4);		  
		  elsif (intP = X"0D") and intrightside1 = '0' then	 --13	  
				  	intR2 <= intR2 + mag(4); 
					intC2 <= intC2 - mag(8 downto 4); 				   
		  elsif (intP = X"0D") and intrightside1 = '1' then	 --13		 
				  	intR2 <= intR2 + mag(4);
					intC2 <= intC2 + mag(8 downto 4);		
		  elsif (intP = X"0E") and intrightside1 = '0' then	 --14		
				  	intR2 <= intR2 + mag(4); 
					intC2 <= intC2 - mag(7 downto 4);					
		  elsif (intP = X"0E") and intrightside1 = '1' then	 --14	   
				  	intR2 <= intR2 + mag(4);
					intC2 <= intC2 + mag(7 downto 4);	   
		  elsif (intP = X"0F") and intrightside1 = '0' then	 --15  
				  	intR2 <= intR2 + mag(5 downto 4); 
					intC2 <= intC2 - mag(7 downto 4);					 
		  elsif (intp = X"0F") and intrightside1 = '1' then	 --15	
				  	intR2 <= intR2 + mag(5 downto 4);
					intC2 <= intC2 + mag(7 downto 4);	   
		  elsif (intP = X"10") and intrightside1 = '0' then	 --16	 
				  	intR2 <= intR2 + mag(5 downto 4); 
					intC2 <= intC2 - mag(6 downto 4); 					  
		  elsif (intP = X"10") and intrightside1 = '1' then	 --16  
				  	intR2 <= intR2 + mag(5 downto 4);
					intC2 <= intC2 + mag(6 downto 4);		 
		  elsif (intP = X"11") and intrightside1 = '0' then	 --17 
				  	intR2 <= intR2 + mag(5 downto 4); 
					intC2 <= intC2 - mag(6 downto 4); 					 
		  elsif (intP = X"11") and intrightside1 = '1' then	 --17		
				  	intR2 <= intR2 + mag(5 downto 4);
					intC2 <= intC2 + mag(6 downto 4);		   
		  elsif (intP = X"12") and intrightside1 = '0' then	 --18	  
				  	intR2 <= intR2 + mag(6 downto 4); 
					intC2 <= intC2 - mag(6 downto 4); 				   
		  elsif (intP = X"12") and intrightside1 = '1' then	 --18	   
				  	intR2 <= intR2 + mag(6 downto 4);
					intC2 <= intC2 + mag(6 downto 4);	 
		  elsif (intP = X"13") and intrightside1 = '0' then	 --19		
				  	intR2 <= intR2 + mag(6 downto 4); 
					intC2 <= intC2 - mag(6 downto 4); 					
		  elsif (intP = X"13") and intrightside1 = '1' then	 --19	   
				  	intR2 <= intR2 + mag(6 downto 4);
					intC2 <= intC2 + mag(6 downto 4);			  
		  elsif (intP = X"14") and intrightside1 = '0' then	 --20	 
				  	intR2 <= intR2 + mag(7 downto 4); 
					intC2 <= intC2 - mag(5 downto 4);					
		  elsif (intP = X"14") and intrightside1 = '1' then	 --20		   
				  	intR2 <= intR2 + mag(7 downto 4);
					intC2 <= intC2 + mag(5 downto 4);	   
		  elsif (intP = X"15") and intrightside1 = '0' then	 --21		
				  	intR2 <= intR2 + mag(7 downto 4); 
					intC2 <= intC2 - mag(5 downto 4);					
		  elsif (intP = X"15") and intrightside1 = '1' then	 --21	 
				  	intR2 <= intR2 + mag(7 downto 4);
					intC2 <= intC2 + mag(5 downto 4);
		  elsif (intP = X"16") and intrightside1 = '0' then	 --22	  
				  	intR2 <= intR2 + mag(8 downto 4);	  
					intC2 <= intC2 - mag(4);  									
		  elsif (intP = X"16") and intrightside1 = '1' then	  --22		  
				  	intR2 <= intR2 + mag(8 downto 4);	   
					intC2 <= intC2 + mag(4);		 	 
		  elsif (intP = X"17") and intrightside1 = '0' then	 --23	   
				  	intR2 <= intR2 + mag(8 downto 4);		  
					intC2 <= intC2 - mag(4);  			  
		  elsif (intP = X"17") and intrightside1 = '1' then	  --23	  
				  	intR2 <= intR2 + mag(8 downto 4);	
					intC2 <= intC2 + mag(4);		  
		  elsif (intP = X"18") and intrightside1 = '0' then				--24 
			  		intR2 <= intR2 + mag(8 downto 4);	
			  		intC2 <= intC2;		  			 
		  elsif intP = X"18" and intrightside1 = '1' then 				--24				  
					intR2 <= intR2 + mag(8 downto 4);
					intC2 <= intC2;					
		  end if;
		  if xkey = KEY_SPACE then
			  fireNow <= '1';	 
		  elsif xkey = KEY_SPACE1 then
			  fireNow <= '0';  
		  end if;
		  
		  if intR2 < "0000001111"	 then	
		  	intR2 <=  "0111100000";
	
		  end if;	
		  
		    if intR2 > "0111101111"	then	
		  	intR2 <=    "0000001111";
	
		  end if;
		  
		  	    if intC2 < "0000001111"	then	
		  	      intC2 <= "1010000000";
	
		  end if;	 
		  
	
		  
		   if intC2 > "1010011111"	then	
		  	intC2 <=  "0000001111";
	
		  end if;
		  
		  
		  
		   when others =>  state <= s0;
			  end case;
	  end if;
	end process;
	S <= intS;
	smotion <= inmotion;
	rightside <= intrightside;
	fire <= fireNow;
	C1 <=intC2;
	R1 <= intR2;		
	  
end controls;
