library IEEE;
use IEEE.std_logic_1164.all;
use work.P_AES.all;

entity mixColumns is
	generic(MODO_DE_OPERACAO : string := "CRYPT");
	port(
		entrada : in matriz;
		saida : out matriz
	);
end mixColumns;

architecture crypt of mixColumns is
	signal c1,c2,c3,c4, s1,s2,s3,s4 : coluna; 
	signal resultado : matriz;

begin

	c1(0) <= entrada(0)(0);
	c1(1) <= entrada(1)(0);
	c1(2) <= entrada(2)(0);
	c1(3) <= entrada(3)(0);
	
	c2(0) <= entrada(0)(1);
	c2(1) <= entrada(1)(1);
	c2(2) <= entrada(2)(1);
	c2(3) <= entrada(3)(1);
	
	c3(0) <= entrada(0)(2);
	c3(1) <= entrada(1)(2);
	c3(2) <= entrada(2)(2);
	c3(3) <= entrada(3)(2);
	
	c4(0) <= entrada(0)(3);
	c4(1) <= entrada(1)(3);
	c4(2) <= entrada(2)(3);
	c4(3) <= entrada(3)(3);
	
	resultado(0)(0) <= s1(0);
	resultado(1)(0) <= s1(1);
	resultado(2)(0) <= s1(2);
	resultado(3)(0) <= s1(3);
	
	resultado(0)(1) <= s2(0);
	resultado(1)(1) <= s2(1);
	resultado(2)(1) <= s2(2);
	resultado(3)(1) <= s2(3);
	
	resultado(0)(2) <= s3(0);
	resultado(1)(2) <= s3(1);
	resultado(2)(2) <= s3(2);
	resultado(3)(2) <= s3(3);
	
	resultado(0)(3) <= s4(0);
	resultado(1)(3) <= s4(1);
	resultado(2)(3) <= s4(2);
	resultado(3)(3) <= s4(3);	
	
	coluna1: entity work.multRow
	generic map( MODO_DE_OPERACAO => MODO_DE_OPERACAO)
	port map(
		entrada => c1,
		saida => s1
	);

	coluna2: entity work.multRow
	generic map( MODO_DE_OPERACAO => MODO_DE_OPERACAO)
	port map(
		entrada => c2,
		saida => s2
	);

	coluna3: entity work.multRow
	generic map ( MODO_DE_OPERACAO => MODO_DE_OPERACAO)
	port map(

		entrada => c3,
		saida => s3
	);
	
	coluna4: entity work.multRow
	generic map( MODO_DE_OPERACAO => MODO_DE_OPERACAO)
	port map(

		entrada => c4,
		saida => s4
	);

	saida <= resultado;

end architecture;
----------------------------------------
----------------------------------------------------------
