LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY tdes_tb IS
END tdes_tb;
 
ARCHITECTURE comp OF tdes_tb IS 
	signal clk, reset, loadkey, Start, Valid, Ready : std_logic:='0';
	signal Input, output, plaintext, plaintext2, chave : std_logic_vector(1 to 64);--:= (others=>'0'); 
	
BEGIN

reset <='1', '0' after 25 ns;

process
	begin
	clk <= '1', '0' after 10 ns;
	wait for 20 ns;
end process;

process
	begin
	wait until ( reset = '0');
	wait until (clk = '1');
	input <= chave;
	wait until (clk = '1');
	wait until (clk = '1');
	loadkey <= '1';
	wait until (clk = '1');
	wait until (clk = '1');
	wait until (clk = '1');
	loadkey <= '0';
	wait until (ready = '1');
	input <= plaintext;
	start <= '1';
	wait until (clk = '1');
	wait until (clk = '1');
	wait until (clk = '1');
	wait until (clk = '1');
	wait until (clk = '1');
	wait until (clk = '1');
	input <= plaintext2;


end process;

	chave <= x"1234567890abcdef";
	plaintext <= x"2B86C06A5ECB1E33";
	plaintext2 <= x"1234567890abcdef";

	cifra: entity work.tdes(Crypt)
	port map(
			clk=>clk,
			rst=>reset,
			loadKey=> loadkey,
			start=>Start,
			textin=>Input,
			textout=>Output,
			valid=>Valid,
			ready=>Ready
	);

		
END comp;
