library IEEE;
use IEEE.std_logic_1164.all;
use work.P_AES.all;

entity finalRound is
	generic( MODO_DE_OPERACAO : string := "CRYPT";
			SAIDA_COM_REGISTRADOR : bit := '0');
	port(
		clk, reset, valid : in std_logic;
		entrada,chave: in matriz;
		saida: out matriz;
		ValidOut : out std_logic
	);
end finalRound;
--------------------------------
architecture crypt of finalRound is
	signal s1, s2, s3:  matriz;
begin

	subByte : entity work.SubByte
		generic map( MODO_DE_OPERACAO => MODO_DE_OPERACAO)
		port map(
			entrada=>entrada,
			saida=>s1	
		);
		
	shiftRows : entity work.shiftRow
		generic map( MODO_DE_OPERACAO => MODO_DE_OPERACAO)
		port map(
			entrada=>s1,
			saida=>s2	
		);
	
	
	addRK : entity work.addRoundkey
		port map(
			entrada=>s2,
			chave=>chave,
			saida=>s3		
		);		
		
SAIDA_REGISTRADA: if (SAIDA_COM_REGISTRADOR = '1') GENERATE
	

	process(clk, reset)
	begin
		if(reset = '1')then
			saida <= vector2matriz(x"00000000000000000000000000000000");
			validOut <= '0';
		elsif(clk'event and clk='1')then
			saida <= s3;
			validOut <= valid;		
		end if;
	end process;
END GENERATE SAIDA_REGISTRADA;

SAIDA_NAO_REGISTRADA: if (SAIDA_COM_REGISTRADOR = '0') GENERATE
	saida <= s3;
	validOut <= valid;
END GENERATE SAIDA_NAO_REGISTRADA;

end architecture;
