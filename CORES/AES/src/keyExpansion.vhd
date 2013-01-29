library IEEE;
use IEEE.std_logic_1164.all;
use work.P_AES.all;

entity KeyExpansion is
	port(
		clk,reset, loadKey : in std_logic; 
		chave : in matriz;
		saida : out matriz;
		ready  : out std_logic
	);
end KeyExpansion;

architecture comp of KeyExpansion is
	signal entradaKR, stateKR, saidaKr : matriz;
	signal round : integer range 0 to 10;
	signal rcon : std_logic_vector(7 downto 0):=x"00";
	signal rdy : std_logic;
begin

	rcon <= x"01" when round = 1 else
			x"02" when round = 2 else
			x"04" when round = 3 else
			x"08" when round = 4 else
			x"10" when round = 5 else
			x"20" when round = 6 else
			x"40" when round = 7 else
			x"80" when round = 8 else
			x"1b" when round = 9 else
			x"36" when round = 10 else
			x"00";
							
	kr : entity work.KeyRound
		port map (
			entrada=>entradaKR,
			rcon=>rcon,
			saida=>saidaKR
		);
	mux_de_entrada_do_kr:	
	entradaKr <= chave when loadKey = '1' else  stateKR;
	
	saida <= stateKR;

	

controle:
process(clk, reset)
begin
	if(reset = '1')then
		stateKR <= vector2matriz(x"00000000000000000000000000000000");
		round <= 0;
		rdy <= '0';
	elsif(clk'event and clk='1')then
		if(round = 0 or rdy = '1')then
			stateKR <= chave;
		else
			stateKR <= saidaKR;
		end if;	
		if(loadKey = '1')then
			round <= 1;
			rdy <= '0';
		elsif (round > 0) then
					
				if(round < 10)then
					round <= round +1;
				else
					rdy <= '1';	
				end if;				
		end if;
		ready <= rdy;		
	end if;	
end process;
	
	
end comp;

