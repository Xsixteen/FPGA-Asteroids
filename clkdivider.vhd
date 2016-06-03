-- Example 52: clock divider
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_unsigned.all;
entity clkdivider is
	 port(
		 mclk : in STD_LOGIC;
		 clr : in STD_LOGIC;	
		 clk190 : out STD_LOGIC;  
		 clk40hz : out std_logic;
		 clkslow : out std_logic;
		 clk25 : out STD_LOGIC	
		 
	     );
end clkdivider;



architecture clkdivider of clkdivider is
signal q:STD_LOGIC_VECTOR(23 downto 0);
begin
  -- clock divider
  process(mclk, clr)
  begin
    if clr = '1' then
	 q <= X"000000";
    elsif mclk'event and mclk = '1' then
	 q <= q + 1;
    end if;
  end process;
  clk25 <= q(0);		-- 25 MHz
  clk190 <= q(17);		-- 190 Hz
  clk40hz <= q(19);
  clkslow <= q(22);
end clkdivider;	  

