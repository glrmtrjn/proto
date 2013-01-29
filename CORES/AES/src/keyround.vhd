library IEEE;
use IEEE.std_logic_1164.all;
use work.p_AES.all;

entity KeyRound is
	port(
		entrada : in matriz;
		Rcon : in std_logic_vector(7 downto 0);
		saida : out matriz
		
	);
end  KeyRound;

architecture comp of KeyRound is
	signal saidaSbox : coluna;
	signal i : integer range 0 to 3 := 0;
begin
	
	sboxes : 
	for i in 0 to 3 generate
	begin
		sboxInst : entity work.sbox
		port map(
			entrada=> entrada(i)(3),
			saida => saidaSbox(i)
		);
	
	end generate sboxes;
	
				saida(0)(0) <= Rcon xor entrada(0)(0) xor saidaSbox(1);
				saida(1)(0) <= entrada(1)(0) xor saidaSbox(2);
				saida(2)(0) <= entrada(2)(0) xor saidaSbox(3);
				saida(3)(0) <= entrada(3)(0) xor saidaSbox(0);	
				
				saida(0)(1) <= Rcon xor entrada(0)(1) xor entrada(0)(0) xor saidaSbox(1); 
				saida(1)(1) <= entrada(1)(1) xor entrada(1)(0) xor saidaSbox(2);
				saida(2)(1) <= entrada(2)(1) xor entrada(2)(0) xor saidaSbox(3);
				saida(3)(1) <= entrada(3)(1) xor entrada(3)(0) xor saidaSbox(0);
				
				saida(0)(2) <= Rcon xor entrada(0)(2) xor entrada(0)(1) xor entrada(0)(0) xor saidaSbox(1);
				saida(1)(2) <= entrada(1)(2) xor entrada(1)(1) xor entrada(1)(0) xor saidaSbox(2);
				saida(2)(2) <= entrada(2)(2) xor entrada(2)(1) xor entrada(2)(0) xor saidaSbox(3);
				saida(3)(2) <= entrada(3)(2) xor entrada(3)(1) xor entrada(3)(0) xor saidaSbox(0);
				
				saida(0)(3) <= Rcon xor entrada(0)(3) xor entrada(0)(2) xor entrada(0)(1) xor entrada(0)(0) xor saidaSbox(1);
				saida(1)(3) <= entrada(1)(3) xor entrada(1)(2) xor entrada(1)(1) xor entrada(1)(0) xor saidaSbox(2);
				saida(2)(3) <= entrada(2)(3) xor entrada(2)(2) xor entrada(2)(1) xor entrada(2)(0) xor saidaSbox(3);
				saida(3)(3) <= entrada(3)(3) xor entrada(3)(2) xor entrada(3)(1) xor entrada(3)(0) xor saidaSbox(0);
				
end comp;
