library IEEE;
use IEEE.std_logic_1164.all;
use work.p_AES.all;

entity Round is
	generic( MODO_DE_OPERACAO : string := "CRYPT";
			SAIDA_COM_REGISTRADOR : bit := '0');
	port(
		clk, reset, valid : in std_logic;
		entrada,chave: in matriz;
		saida: out matriz;
		ValidOut : out std_logic
	);
end Round;
architecture crypt of Round is
	signal dado, s1, s2, s3, s4 :  matriz;
begin
CRYPT: IF(MODO_DE_OPERACAO = "CRYPT") GENERATE
	
		subByte : entity work.SubByte
			generic map(MODO_DE_OPERACAO => MODO_DE_OPERACAO)
			port map(
				entrada=>entrada,
				saida=>s1	
			);
			
		shiftRows : entity work.shiftRow
			generic map(MODO_DE_OPERACAO => MODO_DE_OPERACAO)
			port map(
				entrada=>s1,
				saida=>s2	
			);
			
		mixColumns : entity work.mixColumns
			generic map(MODO_DE_OPERACAO => MODO_DE_OPERACAO)
			port map(
				entrada=>s2,
				saida=>s3	
			);
		
		
		addRK : entity work.addRoundkey
			port map(
				entrada=>s3,
				chave=>chave,
				saida=>s4			
			);
end generate CRYPT;
DECRYPT: IF(MODO_DE_OPERACAO = "DECRYPT" )GENERATE


		shiftRows : entity work.shiftRow
		generic map(MODO_DE_OPERACAO => MODO_DE_OPERACAO)
			port map(
				entrada=>entrada,
				saida=>s1	
			);

		subByte : entity work.SubByte
		generic map(MODO_DE_OPERACAO => MODO_DE_OPERACAO)
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
			
			
		mixColumns : entity work.mixColumns
		generic map(MODO_DE_OPERACAO => MODO_DE_OPERACAO)
			port map(
				entrada=>s3,
				saida=>s4
			);


END GENERATE DECRYPT;

SAIDA_REGISTRADA: if (SAIDA_COM_REGISTRADOR = '1') GENERATE

	process(clk, reset)
	begin
		if(reset = '1')then
			saida <= vector2matriz(x"00000000000000000000000000000000");
			validOut <= '0';
		elsif(clk'event and clk='1')then
			saida <= s4;
			validOut <= valid;		
		end if;
	end process;
END GENERATE SAIDA_REGISTRADA;

SAIDA_NAO_REGISTRADA: if (SAIDA_COM_REGISTRADOR = '0') GENERATE
	saida <= s4;
	validOut <= valid;
END GENERATE SAIDA_NAO_REGISTRADA;

end architecture;
