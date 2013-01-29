LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.P_AES.ALL;
 
ENTITY AES_tb IS
END AES_tb;
 
ARCHITECTURE comp OF AES_tb IS 
	signal clk, reset, loadkey, Start, Valid, Ready : std_logic:='0';
	signal Input, output, plaintext,  plaintext2,  chave : std_logic_vector(127 downto 0);--:= (others=>'0'); 
	
BEGIN

reset <='1', '0' after 25 ns;

process
	begin
	clk <= '1', '0' after 10 ns;
	wait for 20 ns;
end process;

process
	begin
	wait until (reset'event and reset = '0');
	wait until (clk'event and clk = '1');
	input <= chave;
	wait until (clk'event and clk = '1');
	wait until (clk'event and clk = '1');
	loadkey <= '1';
	wait until (clk'event and clk = '1');
	loadkey <= '0';
	wait until (ready'event and ready = '1');
	input <= plaintext2;
	start <= '1';
	wait until (clk'event and clk = '1');
	start <= '0';
	--input <= plaintext2;
	--wait until (ready'event and ready = '1');
	--start <= '1';
	--wait until (clk'event and clk = '1');
	--start <= '0';
	

end process;

	chave <= x"000102030405060708090a0b0c0d0e0f";
	plaintext <= x"00112233445566778899aabbccddeeff";
	plaintext2 <= x"69c4e0d86a7b0430d8cdb78070b4c55a";

	cifra: entity work.aes
	generic map(MODO_DE_OPERACAO => "DECRYPT",
				NRO_DE_ROUNDS => 0)
	port map(
			clk=>clk,
			reset=>reset,
			loadKey=> loadkey,
			start=>Start,
			textin=>Input,
			textout=>Output,
			valid=>Valid,
			ready=>Ready
	);

		
END comp;
