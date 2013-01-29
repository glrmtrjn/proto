----------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use work.P_AES.all;



entity multRow is
	generic(MODO_DE_OPERACAO : string := "CRYPT");
	port(
		entrada : in coluna;
		saida : out coluna
	);
end multRow;

architecture crypt of multRow is
begin

CRYPT: IF(MODO_DE_OPERACAO = "CRYPT")generate
		signal dobro, triplo : coluna;
		signal i : integer range 0 to 3 := 0;
	begin


		mult:
		for i in 0 to 3 generate
		begin
		dobInst : entity work.vezes(dois)
			port map(
				entrada(i),
				dobro(i)
			);
			
		triInst : entity work.vezes(tres)
			port map(
				entrada(i),
				triplo(i)
			);
		end generate mult;	

					saida(0)<= dobro(0) xor triplo(1) xor entrada(2) xor entrada(3);
					saida(1)<= dobro(1) xor triplo(2) xor entrada(3) xor entrada(0);
					saida(2)<= dobro(2) xor triplo(3) xor entrada(0) xor entrada(1);
					saida(3)<= dobro(3) xor triplo(0) xor entrada(1) xor entrada(2);

end generate CRYPT;

DECRYPT: IF(MODO_DE_OPERACAO = "DECRYPT")generate
		signal quatorze, treze, onze, nove : coluna;
		signal i : integer range 0 to 3 := 0;
	begin


	mult:
	for i in 0 to 3 generate
	begin
	quaInst : entity work.vezes(catorze)
		port map(
			entrada(i),
			quatorze(i)
		);
		
	novInst : entity work.vezes(nove)
		port map(
			entrada(i),
			nove(i)
		);
		
	treInst : entity work.vezes(treze)
		port map(
			entrada(i),
			treze(i)
		);
		
	onzeInst : entity work.vezes(onze)
		port map(
			entrada(i),
			onze(i)
		);
	end generate mult;

				saida(0)<= quatorze(0) xor onze(1) xor treze(2) xor nove(3);
				saida(1)<= quatorze(1) xor onze(2) xor treze(3) xor nove(0);
				saida(2)<= quatorze(2) xor onze(3) xor treze(0) xor nove(1);
				saida(3)<= quatorze(3) xor onze(0) xor treze(1) xor nove(2);

end generate DECRYPT;
end architecture;
--------------------------------
