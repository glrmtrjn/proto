
library IEEE;
use IEEE.std_logic_1164.all;
use work.P_AES.all;
entity shiftRow is
	generic(MODO_DE_OPERACAO : string := "CRYPT");
	port(
		entrada : in matriz;
		saida : out matriz
	);
end shiftRow;

architecture crypt of shiftRow is

begin

CRYPT: IF(MODO_DE_OPERACAO = "CRYPT") GENERATE
		saida(0)<=entrada(0);
		
		saida(1)(0)<= entrada(1)(1);
		saida(1)(1)<= entrada(1)(2);
		saida(1)(2)<= entrada(1)(3);
		saida(1)(3)<= entrada(1)(0);
		
		saida(2)(0)<= entrada(2)(2);
		saida(2)(1)<= entrada(2)(3);
		saida(2)(2)<= entrada(2)(0);
		saida(2)(3)<= entrada(2)(1);
		
		saida(3)(0)<= entrada(3)(3);
		saida(3)(1)<= entrada(3)(0);
		saida(3)(2)<= entrada(3)(1);
		saida(3)(3)<= entrada(3)(2);
END GENERATE CRYPT;

DECRYPT: IF(MODO_DE_OPERACAO = "DECRYPT") GENERATE

		saida(0)<=entrada(0);
		
		saida(1)(0)<= entrada(1)(3);
		saida(1)(1)<= entrada(1)(0);
		saida(1)(2)<= entrada(1)(1);
		saida(1)(3)<= entrada(1)(2);
		
		saida(2)(0)<= entrada(2)(2);
		saida(2)(1)<= entrada(2)(3);
		saida(2)(2)<= entrada(2)(0);
		saida(2)(3)<= entrada(2)(1);
		
		saida(3)(0)<= entrada(3)(1);
		saida(3)(1)<= entrada(3)(2);
		saida(3)(2)<= entrada(3)(3);
		saida(3)(3)<= entrada(3)(0);
END GENERATE DECRYPT;

end crypt;

