library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_arith.CONV_STD_LOGIC_VECTOR;
use std.TextIO.all;
use work.HermesPackage.all;

entity HardNoC_TB is
end HardNoC_TB;

architecture HardNoC_TB of HardNoC_TB is

file ARQ_IN: TEXT open READ_MODE is "traffic_type0.txt";
file ARQ_OUT: TEXT open WRITE_MODE is "out_tb.txt";

-- sinais para simulação
signal system_clock, system_reset: std_logic;
-- interface serial
signal rxd, txd: std_logic;

begin

	HN: Entity work.HardNoC
	port map(
		system_clock => system_clock,
		system_reset => system_reset,
		rxd          => txd,
 		txd          => rxd);

	-- gera o clock
	process
	begin
		system_clock <= '1', '0' after 10 ns;
		wait for 20 ns;
	end process;

	-- gera o reset
	system_reset <='1','0' after 120 ns,'1' after 200 ns;

	-- le do arquivo os pacotes de entrada da serial
	process
		variable LINHA_ARQ : line;
		variable linha     : string(1 to 2);
		variable data      : std_logic_vector(7 downto 0);
	begin
		txd <='1';
		wait for 1000 ns;
		wait until system_clock='1';
		while NOT (endfile(ARQ_IN)) loop    -- end file checking
			readline(ARQ_IN, LINHA_ARQ);    -- read line of a file
			read(LINHA_ARQ, linha);
			if linha = "UU" then
				wait for  1000 ns;
			else
				data(7 downto 4) := CONV_VECTOR(linha,1);
				data(3 downto 0) := CONV_VECTOR(linha,2);
				-- start bit
				txd <= '0';
				wait for 400 ns;
				txd <= data(0);
				wait for 400 ns;
				txd <= data(1);
				wait for 400 ns;
				txd <= data(2);
				wait for 400 ns;
				txd <= data(3);
				wait for 400 ns;
				txd <= data(4);
				wait for 400 ns;
				txd <= data(5);
				wait for 400 ns;
				txd <= data(6);
				wait for 400 ns;
				txd <= data(7);
				wait for 400 ns;
				-- stop bit
				txd <='1';
				wait for 800 ns;
			end if;
		end loop; -- end loop da leitura do arquivo
	end process;

    -- escreve arquivo os pacotes de saida da serial
	process
		variable linha : line;
		variable data  : std_logic_vector(7 downto 0);
	begin
		loop
			-- start bit
			wait until rxd='0';
			wait for 405 ns;
			data(0) := rxd;
			wait for 400 ns;
			data(1) := rxd;
			wait for 400 ns;
			data(2) := rxd;
			wait for 400 ns;
			data(3) := rxd;
			wait for 400 ns;
			data(4) := rxd;
			wait for 400 ns;
			data(5) := rxd;
			wait for 400 ns;
			data(6) := rxd;
			wait for 400 ns;
			data(7) := rxd;
			wait for 400 ns;
			write(linha, CONV_STRING_8BITS(data));
			writeline(ARQ_OUT, linha);
		end loop;
	end process;

end HardNoC_TB;
