LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

 
ENTITY mem_out_tb IS
END mem_out_tb;
 
ARCHITECTURE comp OF mem_out_tb IS 
	signal clk, reset, get, send, mem_end : std_logic:='0';
	signal data_in : std_logic_vector(31 downto 0);
	signal data_out	: std_logic_vector(7 downto 0):= (others=>'0'); 
	
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
	data_in <= x"33221100";
	wait until (clk'event and clk = '1');
	data_in <= x"77665544";
	wait until (clk'event and clk = '1');
	data_in <= x"bbaa9988";
	wait until (clk'event and clk = '1');
	data_in <= x"ffeeddcc";
	wait until (clk'event and clk = '1');
	get <= '0';
	send <= '1';



end process;

	mem_out: entity work.MEM_OUTPUT
	generic map(LARGURA_DE_ENTRADA => 32,
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
