library IEEE;
use IEEE.std_logic_1164.all;
use work.P_AES.all;

entity State is
	port(
		
		clk, reset : in std_logic;
		entrada: in matriz;
		saida: out matriz;
		store: in std_logic
	);
end State;

architecture comp of State is
begin

process(clk,reset)
begin
	if(reset = '1')then
		saida <= vector2matriz(x"00000000000000000000000000000000");
	elsif(clk'event and clk='1')then
		if(store = '1') then
			saida <= entrada;
		end if;		
	end if;		
	
end process;
	
end comp;
