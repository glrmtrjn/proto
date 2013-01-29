library IEEE;
use IEEE.std_logic_1164.all;
use work.P_AES.all;

entity SubByte is
	generic(MODO_DE_OPERACAO : string := "CRYPT");
	port( 
		entrada : in matriz;
		saida : out matriz
	);
end SubByte;
---------------------------------
architecture crypt of SubByte is
signal i,j : integer range 0 to 3 := 0;

begin

	sboxx:
		for i in 0 to 3 generate
		begin
			sboxy:
				for j in 0 to 3  generate 
				begin 
				sbox_inst: entity work.Sbox
				generic map(MODO_DE_OPERACAO => MODO_DE_OPERACAO )
				port map(
					entrada=>entrada(i)(j),
					saida => saida(i)(j)
				);
			end generate sboxy;
			
		end generate sboxx;
end crypt;
