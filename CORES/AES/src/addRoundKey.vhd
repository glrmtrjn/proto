library IEEE;
use IEEE.std_logic_1164.all;
use work.P_AES.all;

entity AddRoundKey is
	port(
		entrada,chave : in matriz;
		saida : out matriz
	);
end AddRoundKey;

architecture comp of AddRoundKey is
	signal a,b,resultado : std_logic_vector(127 downto 0);
begin

	resultado <= a xor b;			

	a <= matriz2vector(entrada);
	b <= matriz2vector(chave);	
	saida <= vector2matriz(resultado);
	
end comp;
