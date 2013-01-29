library IEEE;
use IEEE.std_logic_1164.all;

entity round is
	port(
		clk,rst,
		strIn, vIn : in std_logic;
		strOut, vOut: out std_logic;
		
		textIn: in std_logic_vector(1 to 64);
		keyIn : in std_logic_vector(1 to 48);		
		textOut: out std_logic_vector(1 to 64)
		
	);
end round;

architecture crypt of round is
	signal subKey: std_logic_vector(1 to 48);
	signal data : std_logic_vector(1 to 64);
	
	signal entradaPbox, saidaPbox : std_logic_vector(1 to 32);
	signal saidaEbox, entradaSbox : std_logic_vector(1 to 48);
begin

	ebox: entity work.E_box
		port map(
			entrada=> data(33 to 64),
			saida=> saidaEbox
		);
		
	sbox: entity work.S_box
		port map(
			entrada=> entradaSbox,
			saida=> entradaPbox
		);
		
	pbox: entity work.P_box
		port map(
			entrada=> entradaPbox,
			saida=> saidaPbox
		);
			
	entradaSbox <= subkey xor saidaEbox;
	
	textOut <= data(33 to 64) & (data(1 to 32) xor saidaPbox);



process(clk)
	begin
		if(clk'event and clk = '1')then
			if(rst = '1')then
				subkey <= (others=>'0');
				data <= (others=>'0');
				vOut <= '0';
				strOut <= '0';
			else
				data <= textin;				
				strOut <= strIn;
				vOut <= vIn;
				if(strIn = '1')then
					subkey <= keyIn;					
				end if;
			end if;		
		end if;
	end process;
	
end crypt;
