library IEEE;
use IEEE.std_logic_1164.all;
use work.P_AES.all;

entity initRound is
	generic( SAIDA_COM_REGISTRADOR : bit := '0' );
	port(
		clk, reset, valid : in std_logic;
		entrada,chave: in matriz;
		saida: out matriz;
		ValidOut : out std_logic
	);
end initRound;

architecture comp of initRound is
	signal saidaAdrk :  matriz;
begin
	
	addRK : entity work.addRoundkey
		port map(
			entrada=>entrada,
			chave=>chave,
			saida=>saidaAdrk			
		);
		
SAIDA_REGISTRADA: if (SAIDA_COM_REGISTRADOR = '1') GENERATE

	process(clk, reset)
	begin
		if(reset = '1')then
			saida <= vector2matriz(x"00000000000000000000000000000000");
			validOut <= '0';
		elsif(clk'event and clk='1')then
			saida <= saidaAdrk;
			validOut <= valid;		
		end if;
	end process;
END GENERATE SAIDA_REGISTRADA;

SAIDA_NAO_REGISTRADA: if (SAIDA_COM_REGISTRADOR = '0') GENERATE
	saida <= saidaAdrk;
	validOut <= valid;
END GENERATE SAIDA_NAO_REGISTRADA;

end comp;
