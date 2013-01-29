LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

 
ENTITY mem_in_tb IS
END mem_in_tb;
 
ARCHITECTURE comp OF mem_in_tb IS 
	signal clk, reset, get, send, mem_end : std_logic:='0';
	signal data_out : std_logic_vector(31 downto 0);
	signal data_in	: std_logic_vector(7 downto 0):= (others=>'0'); 
	
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
	get <= '1';
	data_in <= x"00";
	wait until (clk'event and clk = '1');
	data_in <= x"11";
	wait until (clk'event and clk = '1');
	data_in <= x"22";
	wait until (clk'event and clk = '1');
	data_in <= x"33";
	wait until (clk'event and clk = '1');
	data_in <= x"44";
	wait until (clk'event and clk = '1');
	data_in <= x"55";
	wait until (clk'event and clk = '1');
	data_in <= x"66";
	wait until (clk'event and clk = '1');
	data_in <= x"77";
	wait until (clk'event and clk = '1');
	data_in <= x"88";
	wait until (clk'event and clk = '1');
	data_in <= x"99";
	wait until (clk'event and clk = '1');
	data_in <= x"aa";
	wait until (clk'event and clk = '1');
	data_in <= x"bb";
	wait until (clk'event and clk = '1');
	data_in <= x"cc";
	wait until (clk'event and clk = '1');
	data_in <= x"dd";
	wait until (clk'event and clk = '1');
	data_in <= x"ee";
	wait until (clk'event and clk = '1');
	data_in <= x"ff";
	get <= '0';
	send <= '1';



end process;

	mem_in: entity work.MEM_INPUT
	generic map(LARGURA_DE_SAIDA => 32,
				PROFUNDIDADE => 4)
	port map(
			clk=>clk,
			rst=>reset,
			data_in=>data_in,
			data_out=>data_out,
			get=>get,
			send=>send,
			mem_end=>mem_end
	);

		
END comp;
