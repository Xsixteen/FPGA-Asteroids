
library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use IEEE.STD_LOGIC_UNSIGNED.All;

entity process_collision is	 
		 port(
	 clr : in STD_LOGIC;
	 	 clk190 : in STD_LOGIC;
		 destroy : out STD_LOGIC;	
		 destroyA1 : out STD_LOGIC;
		 destroyA2 : out STD_LOGIC;
		 destroyA3 : out STD_LOGIC;
		 destroyA4 : out STD_LOGIC;	   
		 point : out STD_LOGIC;
		 reset : in std_logic;
		 
		 bC1 : in STD_LOGIC_VECTOR(9 downto 0);
		 bR1 : in STD_LOGIC_VECTOR(9 downto 0);	 
		 bC2 : in STD_LOGIC_VECTOR(9 downto 0);
		 bR2 : in STD_LOGIC_VECTOR(9 downto 0);
		 bC3 : in STD_LOGIC_VECTOR(9 downto 0);
		 bR3 : in STD_LOGIC_VECTOR(9 downto 0);
		 bC4 : in STD_LOGIC_VECTOR(9 downto 0);
		 bR4 : in STD_LOGIC_VECTOR(9 downto 0);
		 bC5 : in STD_LOGIC_VECTOR(9 downto 0);
		 bR5: in STD_LOGIC_VECTOR(9 downto 0);	 
		 
		 inC1 : in STD_LOGIC_VECTOR(9 downto 0);
		 inR1 : in STD_LOGIC_VECTOR(9 downto 0);  
		  inC12 : in STD_LOGIC_VECTOR(9 downto 0);
		 inR12 : in STD_LOGIC_VECTOR(9 downto 0);
		  inC13 : in STD_LOGIC_VECTOR(9 downto 0);
		 inR13 : in STD_LOGIC_VECTOR(9 downto 0);
		  inC14 : in STD_LOGIC_VECTOR(9 downto 0);
		 inR14 : in STD_LOGIC_VECTOR(9 downto 0);
		  inC15 : in STD_LOGIC_VECTOR(9 downto 0);
		 inR15 : in STD_LOGIC_VECTOR(9 downto 0)
	     );
end process_collision;


architecture process_collision of process_collision is

	type state_type is (s0, s1, s2);
signal state: state_type := s0;  
signal des, des1,des2,des3,des4 : STD_LOGIC;
begin  					  
	
	process(clk190, clr) 	
	
	begin
	if clr = '1' then
		des <= '0';	
		des1 <= '0';
		des2 <= '0';
		des3 <= '0';
		des4 <= '0';
  	elsif clk190'event and clk190 = '1' then

		  case state is
			  when s0 =>	  	
			  des <='0';
   --Obj2 is bullet and Obj1 is ship	 
   -- The "11110" is the width of the ship object. Change to appropriate size!
   --Size of Obj2 is thought of as irrelevant.
   if( ( inR12 <inR1) and (inR1 < (inR12 + "11001")) ) and ((inC12 < inC1) and (inC12 + "111100") > inC1) then
	   des <= '1';	 
	   state <= s1;  
   end if;	  
   if( ( inR13 <inR1) and (inR1 < (inR13 + "11001")) ) and ((inC13 < inC1) and (inC13 + "111100") > inC1) then
	   des <= '1';	 
	   state <= s1;  
   end if;	  
      if( ( inR14 <inR1) and (inR1 < (inR14 + "11001")) ) and ((inC14 < inC1) and (inC14 + "111100") > inC1) then
	   des <= '1';	 
	   state <= s1;  
   end if;	  
      if( ( inR15 <inR1) and (inR1 < (inR15 + "11001")) ) and ((inC15 < inC1) and (inC15 + "111100") > inC1) then
	   des <= '1';	 
	   state <= s1;  
   end if;	  
   
   --asteroid destruction 
	  
   --Asteroid 1
   if( ( inR12 < bR1) and (bR1 < (inR12 + "11001")) ) and ((inC12 < bC1) and (inC12 + "111100") > bC1) then
	   des1 <= '1'; 

elsif( ( inR12 < bR2) and (bR2 < (inR12 + "11001")) ) and ((inC12 < bC2) and (inC12 + "111100") > bC2) then
		des1 <= '1';  
	
  elsif( ( inR12 < bR3) and (bR3 < (inR12 + "11001")) ) and ((inC12 < bC3) and (inC12 + "111100") > bC3) then
		des1 <= '1'; 	
	
  elsif( ( inR12 < bR4) and (bR4 < (inR12 + "11001")) ) and ((inC12 < bC4) and (inC12 + "111100") > bC4) then
		des1 <= '1'; 
	
  elsif( ( inR12 < bR5) and (bR5 < (inR12 + "11001")) ) and ((inC12 < bC5) and (inC12 + "111100") > bC5) then
		des1 <= '1'; 
		  else 
	   des1 <='0';
	   
   end if;	  			  
   
      --Asteroid2
   if( ( inR13 < bR1) and (bR1 < (inR13 + "11001")) ) and ((inC13 < bC1) and (inC13 + "111100") > bC1) then
	   des2 <= '1'; 	
	 
   elsif( ( inR13 < bR2) and (bR2 < (inR13 + "11001")) ) and ((inC13 < bC2) and (inC13 + "111100") > bC2) then
		des2 <= '1';
	
   elsif( ( inR13 < bR3) and (bR3 < (inR13 + "11001")) ) and ((inC13 < bC3) and (inC13 + "111100") > bC3) then
		des2 <= '1';  
	
  elsif( ( inR13 < bR4) and (bR4 < (inR13 + "11001")) ) and ((inC13 < bC4) and (inC13 + "111100") > bC4) then
		des2 <= '1';  
	
  elsif( ( inR13 < bR5) and (bR5 < (inR13+ "11001")) ) and ((inC13 < bC5) and (inC13 + "111100") > bC5) then
		des2 <= '1'; 
		  else 
	   des2 <='0';
   end if;	  		 
   
         --Asteroid3
   if( ( inR14 < bR1) and (bR1 < (inR14 + "11001")) ) and ((inC14 < bC1) and (inC14 + "111100") > bC1) then
	   des3 <= '1';  
	   
 elsif (( inR14 < bR2) and (bR2 < (inR14 + "11001")) ) and ((inC14 < bC2) and (inC14 + "111100") > bC2) then
		des3 <= '1';
		 
 elsif( ( inR14 < bR3) and (bR3 < (inR14 + "11001")) ) and ((inC14 < bC3) and (inC14 + "111100") > bC3) then
		des3 <= '1';
	
 elsif( ( inR14 < bR4) and (bR4 < (inR14 + "11001")) ) and ((inC14 < bC4) and (inC14 + "111100") > bC4) then
		des3 <= '1';  
		
  elsif( ( inR14 < bR5) and (bR5 < (inR14 + "11001")) ) and ((inC14 < bC5) and (inC14 + "111100") > bC5) then
		des3 <= '1';
		  else 
	   des3<='0';
   end if;	  
   
         --Asteroid4
   if( ( inR15 < bR1) and (bR1 < (inR15 + "11001")) ) and ((inC15 < bC1) and (inC15 + "111100") > bC1) then
	   des4 <= '1'; 	
	 
   elsif( ( inR15 < bR2) and (bR2 < (inR15 + "11001")) ) and ((inC15 < bC2) and (inC15 + "111100") > bC2) then
		des4 <= '1'; 	
	
   elsif( ( inR15 < bR3) and (bR3 < (inR15 + "11001")) ) and ((inC15 < bC3) and (inC15 + "111100") > bC3) then
		des4 <= '1';
	
   elsif( ( inR15 < bR4) and (bR4 < (inR15 + "11001")) ) and ((inC15 < bC4) and (inC15 + "111100") > bC4) then
		des4 <= '1';  
		
   elsif( ( inR15 < bR5) and (bR5 < (inR15 + "11001")) ) and ((inC15 < bC5) and (inC15 + "111100") > bC5) then
		des4 <= '1'; 		
		  else 
	   des4 <='0';
   end if;	  
   
   
   
   
   
   
   
   
   when s1 =>
   des <='1';
   state <= s2;
   when s2 =>
   if reset = '1' then
	   state <= s0;
   end if;
		  end case;
   end if; 
   
   if(des1 or des2 or des3 or des4 ) = '1' then	
	   point <='1';	  
   else
	   point <='0';
	   end if;
	  destroy <= des;  
	  destroyA4 <= des4;
	  destroyA3 <= des3;
	  destroyA2 <= des2;
	  destroyA1<=des1;
   end process;
end process_collision;