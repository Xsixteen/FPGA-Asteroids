

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_unsigned.all;

entity score is
	port(		  
	clk190 : in STD_LOGIC;
	clr : in STD_LOGIC;
		 point : in STD_LOGIC;
		 seg : out STD_LOGIC_VECTOR(5 downto 0)
	     );
end score;

--}} End of automatically maintained section

architecture score of score is		   
type state_type is (s0, s1);  
signal score : STD_LOGIC_VECTOR( 5 downto 0);
signal state: state_type := s0;  
begin

	process(clk190, clr)
	begin
		
	--begin
	if clr = '1' then
	 score <= "000000";
  	elsif clk190'event and clk190 = '1' then
		  
		  case state is
			  when s0 =>
			 seg <= score;
			 if point = '1' then
			state <= s1;	 
			 end if;	
			 
			 when s1 =>
			 score <= score + 1;
			 state <=s0;
			end case;
	end if;
	end process;
end score;
