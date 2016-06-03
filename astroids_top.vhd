
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;


entity astroids_top is
	
	port(
	mclk : in STD_LOGIC;
	PS2C: in STD_LOGIC;
	PS2D: in STD_LOGIC;
	btn : in STD_LOGIC_VECTOR(3 downto 2);
	hsync : out STD_LOGIC; 
	sw : in STD_LOGIC_VECTOR(7 downto 0);
	vsync : out STD_LOGIC;
	red : out STD_LOGIC_VECTOR(2 downto 0);
	green : out STD_LOGIC_VECTOR(2 downto 0);
	 a_to_g : out STD_LOGIC_VECTOR(6 downto 0);
		 an : out STD_LOGIC_VECTOR(3 downto 0);
		 dp : out STD_LOGIC;
		blue : out STD_LOGIC_VECTOR(1 downto 0));

end astroids_top;

--}} End of automatically maintained section

architecture astroids_top of astroids_top is	


	component keyboard
	port(
		clk25 : in STD_LOGIC;
		clr : in STD_LOGIC;
		PS2C : in STD_LOGIC;
		PS2D : in STD_LOGIC;
		xkey : out STD_LOGIC_VECTOR(15 downto 0));
	end component;	 
	

	component clkdivider
	port(
		mclk : in STD_LOGIC;
		clr : in STD_LOGIC;
		clk190 : out STD_LOGIC;
		clk25 : out STD_LOGIC;
		clk40hz : out std_logic;
		clkslow : out std_logic);
	end component;		   
	

	component vga_640x480
	port(
		clk : in STD_LOGIC;
		clr : in STD_LOGIC;
		hsync : out STD_LOGIC;
		vsync : out STD_LOGIC;
		hc : out STD_LOGIC_VECTOR(9 downto 0);
		vc : out STD_LOGIC_VECTOR(9 downto 0);
		vidon : out STD_LOGIC);
	end component;


	

	
	component vgatest
	port(
		vidon : in STD_LOGIC;
		rightside : in STD_LOGIC;
		destroy : in STD_LOGIC;
		hc : in STD_LOGIC_VECTOR(9 downto 0);
		vc : in STD_LOGIC_VECTOR(9 downto 0);
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
		red : out STD_LOGIC_VECTOR(2 downto 0);
		rom_addr4 : out STD_LOGIC_VECTOR(7 downto 0);
		rom1_addr4 : out STD_LOGIC_VECTOR(7 downto 0);
		rom2_addr4 : out STD_LOGIC_VECTOR(7 downto 0);
		rom3_addr4 : out STD_LOGIC_VECTOR(7 downto 0);
		rom4_addr4 : out STD_LOGIC_VECTOR(7 downto 0);
		rom5_addr4 : out STD_LOGIC_VECTOR(7 downto 0);
		green : out STD_LOGIC_VECTOR(2 downto 0);
		sw : in STD_LOGIC_VECTOR(7 downto 0);
		xkey : in STD_LOGIC_VECTOR(15 downto 0);
		M : in STD_LOGIC_VECTOR(38 downto 0);
		D : in STD_LOGIC_VECTOR(60 downto 0);
		D1 : in STD_LOGIC_VECTOR(60 downto 0);
		D2 : in STD_LOGIC_VECTOR(60 downto 0);
		D3 : in STD_LOGIC_VECTOR(60 downto 0);		
		D4 : in STD_LOGIC_VECTOR(60 downto 0);
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
		blue : out STD_LOGIC_VECTOR(1 downto 0));
	end component;

									   
	component asteroids_move
	port(
		clk40hz : in std_logic;
		clr : in std_logic;
		destroyA1 : in std_logic;
		destroyA2 : in std_logic;
		destroyA3 : in std_logic;
		destroyA4 : in std_logic; 		
		RAND : in std_logic_vector(9 downto 0);
		Cd : out std_logic_vector(9 downto 0);
		Rd : out std_logic_vector(9 downto 0);
		Ca : out std_logic_vector(9 downto 0);
		Ra : out std_logic_vector(9 downto 0);
		Cb : out std_logic_vector(9 downto 0);
		Rb : out std_logic_vector(9 downto 0);
		Cc : out std_logic_vector(9 downto 0);
		Rc : out std_logic_vector(9 downto 0));
	end component;															
	
	component rand
	port(
		clk25 : in std_logic;
		xkey : in std_logic;
		RAND : out std_logic_vector(9 downto 0));
	end component;							 
			  
	component prom_asteroids
	port(
		rom_addra : in std_logic_vector(7 downto 0);
		D : out std_logic_vector(0 to 60));
	end component;	 								  
	
	component prom1_asteroid
	port(
		rom_addra : in std_logic_vector(7 downto 0);
		D : out std_logic_vector(0 to 60));
	end component;						
	
	component prom2_asteroid
	port(
		rom_addra : in std_logic_vector(7 downto 0);
		D : out std_logic_vector(0 to 60));
	end component;	   	
										
	component prom3_asteroid
	port(
		rom_addra : in std_logic_vector(7 downto 0);
		D : out std_logic_vector(0 to 60));
	end component;															

	component x7segb
	port(
		clk : in STD_LOGIC;
		clr : in STD_LOGIC;
		x : in STD_LOGIC_VECTOR(15 downto 0);
		dp : out STD_LOGIC;
		a_to_g : out STD_LOGIC_VECTOR(6 downto 0);
		an : out STD_LOGIC_VECTOR(3 downto 0));
	end component;



	component controls
	port(
		rightside : out std_logic;
		S : out std_logic_vector(7 downto 0);
		clr : in STD_LOGIC;
		fire : out STD_LOGIC;
		clk40hz : in STD_LOGIC;	
		xkey : in STD_LOGIC_VECTOR(15 downto 0);
		R1 : out STD_LOGIC_VECTOR(9 downto 0);
		C1 : out STD_LOGIC_VECTOR(9 downto 0));
	end component;






	component prom_dmh
	port(
		clr : in std_logic;
		S : in STD_LOGIC_VECTOR(7 downto 0);
		addr : in STD_LOGIC_VECTOR(7 downto 0);
		M : out STD_LOGIC_VECTOR(0 to 38));
	end component;




	component move_bullets
	port(
		clr : in STD_LOGIC;
		clk190 : in STD_LOGIC;
		startC1 : in STD_LOGIC_VECTOR(9 downto 0);
		startR1 : in STD_LOGIC_VECTOR(9 downto 0);
		nextb : out STD_LOGIC;
		S : in STD_LOGIC_VECTOR(7 downto 0);
		rightside : in STD_LOGIC;
		xkey : in STD_LOGIC_VECTOR(15 downto 0);
		inb : in STD_LOGIC;
		outC1 : out STD_LOGIC_VECTOR(9 downto 0);
		outR1 : out STD_LOGIC_VECTOR(9 downto 0));
	end component;




	-- Component declaration of the "process_collision(process_collision)" unit defined in
	-- file: "./src/process_collision.vhd"
	component process_collision
	port(
		reset : in std_logic;
		clr : in STD_LOGIC;
		clk190 : in STD_LOGIC;
		destroy : out STD_LOGIC;
		destroyA1 : out STD_LOGIC;
		destroyA2 : out STD_LOGIC;
		destroyA3 : out STD_LOGIC;
		destroyA4 : out STD_LOGIC;
		point : out STD_LOGIC;
		bC1 : in STD_LOGIC_VECTOR(9 downto 0);
		bR1 : in STD_LOGIC_VECTOR(9 downto 0);
		bC2 : in STD_LOGIC_VECTOR(9 downto 0);
		bR2 : in STD_LOGIC_VECTOR(9 downto 0);
		bC3 : in STD_LOGIC_VECTOR(9 downto 0);
		bR3 : in STD_LOGIC_VECTOR(9 downto 0);
		bC4 : in STD_LOGIC_VECTOR(9 downto 0);
		bR4 : in STD_LOGIC_VECTOR(9 downto 0);
		bC5 : in STD_LOGIC_VECTOR(9 downto 0);
		bR5 : in STD_LOGIC_VECTOR(9 downto 0);
		inC1 : in STD_LOGIC_VECTOR(9 downto 0);
		inR1 : in STD_LOGIC_VECTOR(9 downto 0);
		inC12 : in STD_LOGIC_VECTOR(9 downto 0);
		inR12 : in STD_LOGIC_VECTOR(9 downto 0);
		inC13 : in STD_LOGIC_VECTOR(9 downto 0);
		inR13 : in STD_LOGIC_VECTOR(9 downto 0);
		inC14 : in STD_LOGIC_VECTOR(9 downto 0);
		inR14 : in STD_LOGIC_VECTOR(9 downto 0);
		inC15 : in STD_LOGIC_VECTOR(9 downto 0);
		inR15 : in STD_LOGIC_VECTOR(9 downto 0));
	end component;																	



	component bcd
	port(
		B : in STD_LOGIC_VECTOR(5 downto 0);
		P : out STD_LOGIC_VECTOR(6 downto 0));
	end component;
	for all: bcd use entity work.bcd(bcd);

		
	component score
	port(
		clk190 : in STD_LOGIC;
		clr : in STD_LOGIC;
		point : in STD_LOGIC;
		seg : out STD_LOGIC_VECTOR(5 downto 0));
	end component;
	for all: score use entity work.score(score); 
		
	component prom_explode
	port(
		clr : in std_logic;
		destroy : in std_logic;
		destroyA1 : in std_logic;
		destroyA2 : in std_logic;
		destroyA3 : in std_logic;
		destroyA4 : in std_logic;
		clkslow : in std_logic;
		rom_addra : in std_logic_vector(7 downto 0);
		D : out std_logic_vector(0 to 60);
		reset : out std_logic);
	end component;													  





	signal R1,C1,Cd,Rd,Ca,Ra,Cb,Rb,Cc,Rc,bulletC1,bulletR1,R10,C10,R12,C12, R13,C13,R14,C14,R15,C15, C1out,R1out : STD_LOGIC_VECTOR (9 downto 0);
	 signal destroyA1, destroyA2,destroyA3,destroyA4, reset, clk25, clk190, clk40hz,clkslow, clr,vidon, bulletNum,point, fire,sig1,sig2,sig3,sig4, destroy: STD_LOGIC;
	 signal xkey : STD_LOGIC_VECTOR(15 downto 0);
	 signal P :  STD_LOGIC_VECTOR(6 downto 0);
	 signal scorecon : std_logic_vector(5 downto 0);
	 signal scoreout : STD_LOGIC_VECTOR(15 downto 0);
	 signal bulletValid, xkey1 : STD_LOGIC;
	 signal hc,vc,Random: STD_LOGIC_VECTOR(9 downto 0); 
	 signal M : STD_LOGIC_VECTOR (0 to 38);	
	 signal D, D1, D2, D3, D4 : STD_LOGIC_VECTOR (0 to 60);
	 signal rom_addr4,rom1_addr4,rom2_addr4,rom3_addr4,rom4_addr4, rom5_addr4: std_logic_vector(7 downto 0); 
	 signal S : std_logic_vector(7 downto 0);
	 signal rightside : std_logic;

begin  
	clr <= btn(3);
	
	Label6 : prom_dmh
	port map(
		S => S,
		clr => btn(3),
		addr => rom_addr4,
		M => M
	);
	
	Label1 : keyboard
	port map(
		clk25 => clk25,
		clr => clr,
		PS2C => PS2C,
		PS2D => PS2D,
		xkey => xkey
	);
	
	Label2 : clkdivider
	port map(
		mclk => mclk,
		clr => clr,
		clk190 => clk190,
		clk25 => clk25,
		clkslow => clkslow,
		clk40hz => clk40hz
	);	  

	
	Label3 : vgatest
	port map(
	rightside => rightside,	
		destroy => destroy,
		vidon => vidon,
		hc => hc,
		vc => vc,
		R1 => R1,
		C1 => C1, 
		Rd => Rd,
		Cd => Cd,
		Ra => Ra,
		Ca => Ca,
		Rb => Rb,
		Cb => Cb,
		Rc => Rc,
		Cc => Cc,
		bulletR1 => bulletR1,
		bulletC1 => bulletC1,
		bulletID => bulletValid,
		red => red,
		rom_addr4 => rom_addr4,	
		rom1_addr4 => rom1_addr4,		
		rom2_addr4 => rom2_addr4,		
		rom3_addr4 => rom3_addr4,		
		rom4_addr4 => rom4_addr4,		
		rom5_addr4 => rom5_addr4,
		green => green,
		sw => sw,
		xkey => xkey,
		M => M,
		D => D,
		D1 => D1,
		D2 => D2,
		D3 => D3, 
		D4 => D4,
		inC1 => C10,
		inR1 => R10,
		inC12 => C12,
		inR12 => R12,
		inC13 => C13,
		inR13 => R13,
		inC14 => C14,
		inR14 => R14,
		inC15 => C15,
		inR15 => R15,  
		destroyA1 => destroyA1,
		destroyA2 => destroyA2,
		destroyA3 => destroyA3,
		destroyA4 => destroyA4,
		blue => blue
	); 	   
	

	Label4 : vga_640x480
	port map(
		clk => clk25,
		clr => clr,
		hsync => hsync,
		vsync => vsync,
		hc => hc,
		vc => vc,
		vidon => vidon
	);	  
	


	
	Label5 : x7segb
	port map(
		clk => mclk,
		clr => clr,
		x => scoreout,
		dp => dp,
		a_to_g => a_to_g,
		an => an
	);	  
	
Label7 : controls
port map(
		rightside => rightside,
		S => S,
		clr => clr,
		fire => fire,
		clk40hz => clk40hz,
		xkey => xkey,	
		R1 => R1,
		C1 => C1
	);	 

Label9 : asteroids_move
	port map(
		clk40hz => clk40hz,
		clr => clr,
		destroyA1 => destroyA1,
		destroyA2 => destroyA2,
		destroyA3 => destroyA3,
		destroyA4 => destroyA4,
		RAND => random,
		Cd => Cd,
		Rd => Rd,
		Ca => Ca,
		Ra => Ra,
		Cb => Cb,
		Rb => Rb,
		Cc => Cc,
		Rc => Rc
	);
RAND1 : rand
	port map(
		clk25 => clk40hz,
		xkey => xkey1,
		RAND => random
	);
explode1 : prom_explode
	port map( 
		reset => reset,
		clr => btn(3),
		destroy => destroy,
		destroyA1 => destroyA1,
		destroyA2 => destroyA2,
		destroyA3 => destroyA3,
		destroyA4 => destroyA4,
		clkslow => clkslow,
		rom_addra => rom5_addr4,
		D => D4
	);
Label10 : prom_asteroids
	port map(
		rom_addra => rom1_addr4,	
		D => D 
	);
Label11 : prom1_asteroid
	port map(
		rom_addra => rom2_addr4,
		D => D1
	);
Label12 : prom2_asteroid
	port map(
		rom_addra => rom3_addr4,
		D => D2
	);
Label13 : prom3_asteroid
	port map(
		rom_addra => rom4_addr4,
		D => D3
	);		 

	bullet1 : move_bullets
	port map(
		clr => clr,
		clk190 => clk40hz,
		startC1 => C1,
		startR1 => R1,
		xkey => xkey,
			S => S,
		rightside => rightside,
		nextb => sig1,
		inb => '1',
		outC1 => C10,
		outR1 => R10
	);	  	  
	
	Label100 : process_collision
	port map(
		reset => reset,
		clr => clr,
		clk190 => clk40hz,
		destroy => destroy,
				point => point,
				destroyA1 => destroyA1,
		destroyA2 => destroyA2,
		destroyA3 => destroyA3,
		destroyA4 => destroyA4,
		bC1 => C10,
		bR1 => R10,
		bC2 => C12,
		bR2 => R12,
		bC3 => C13,
		bR3 => R13,
		bC4 => C14,
		bR4 => R14,
		bC5 => C15,
		bR5 => R15,
		inC1 => C1,
		inR1 => R1,
		inC12 => Ca,
		inR12 => Ra,
		inC13 => Cb,
		inR13 => Rb,
		inC14 => Cc,
		inR14 => Rc,
		inC15 => Cd,
		inR15 => Rd
	);			


	bullet2 : move_bullets
	port map(
		clr => clr,
		clk190 => clk40hz,
		startC1 => C1,
		startR1 => R1,
			xkey => xkey,
			S => S,
		rightside => rightside,
		nextb => sig2,
		inb => sig1,
		outC1 => C12,
		outR1 => R12
	);			
	
		bullet3 : move_bullets
	port map(
		clr => clr,
		clk190 => clk40hz,
		startC1 => C1,
		startR1 => R1,
		xkey => xkey,
			S => S,
		rightside => rightside,
		nextb => sig3,
		inb => sig2,
		outC1 => C13,
		outR1 => R13
	);
		bullet4 : move_bullets
	port map(
		clr => clr,
		clk190 => clk40hz,
		startC1 => C1,
		startR1 => R1,
		xkey => xkey,
			S => S,
		rightside => rightside,
		nextb => sig4,
		inb => sig3,
		outC1 => C14,
		outR1 => R14
	);
		bullet5 : move_bullets
	port map(
		clr => clr,
		clk190 => clk40hz,
		startC1 => C1,
		startR1 => R1,
		xkey => xkey,
			S => S,
		rightside => rightside,
		nextb => open,
		inb => sig4,
		outC1 => C15,
		outR1 => R15
	); 
	
	Label112 : bcd
	port map(
		B => scorecon,
		P => P
	);
		 Label1444 : score
	port map(
		clk190 => clk190,
		clr => clr,
		point => point,
		seg => scorecon
	);
	  	bulletValid <= fire;
		scoreout ( 6 downto 0) <=  P;
end astroids_top;
