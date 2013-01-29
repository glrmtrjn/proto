-----------------------------------------------------------------------------------
-- A serial recebe pacotes do software serial nos seguintes formato:
--
-- read   <command - 00> <target> <nword> <addH1> <addL1>
-- write  <command - 01> <target> <nword> <addH1> <addL1> <dataH1> <dataL1> ... <dataHn> <dataLn>
-- reset  <command - 02> <target>
-----------------------------------------------------------------------------------
-- A serial envia pacotes para o software serial nos seguintes formato:
--
-- return read <dataH1> <dataL1> ... <dataHn> <dataLn>
-----------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;
use work.HermesPackage.all;

entity Serial is
port(
	clock:          in  std_logic;
	reset:          in  std_logic;
	start:          out std_logic;
---- Interface Serial ----------------------------------------
 	rxd:            in  std_logic;
	txd:            out std_logic;
---- Interface NoC ------------------------------------------
	address:        in  reg8;
	clock_tx:       out std_logic;
	tx:             out std_logic;
	lane_tx:        out regNlane;
	data_out:       out regflit;
	credit_i:       in  regNlane;
	clock_rx:       in std_logic;
	rx:             in  std_logic;
	lane_rx:        in  regNlane;
	data_in:        in  regflit;
	credit_o:       out regNlane);
end;

architecture Serial of Serial is

type send_network is (S0,S1,S2,S3,S4,S5,S5a,S6,S7,S7a,S7b,S7c,S8,S9,S10,S11,S12,S13);
signal ES: send_network;

type receive_network is (S0,S1,S2,S3,S4,S5,S6,S7,S8);
signal ER: receive_network;

-- serial interface
signal reset_n: std_logic;
signal rx_av, tx_busy, tx_start: std_logic;
signal rx_data, tx_data: reg8;
signal busySerial: std_logic;
-- send network
signal command : regflit;
signal target: regflit;
signal nWord,counterWord: regflit;
signal add: std_logic_vector(15 downto 0);
signal data: regflit;
-- receive network
signal commandReceive : regflit;
signal sourceReceive : regflit;
signal counterWordReceive : regflit;
signal dataReceive: regflit;

begin

	reset_n <= not reset;

	clock_tx <= clock;

	SI : Entity work.SerialInterface(SerialInterface)
	port map(
		clock    => clock,
		reset    => reset_n,
		rxd      => rxd,
		txd      => txd,
		rx_start => tx_start,
		rx_data  => tx_data,
		rx_busy  => tx_busy,
		tx_av    => rx_av,
		tx_data  => rx_data);

-------------------------------------------------------------------------------------------------------
---- RECEIVE FROM SOFTWARE SERIAL  - SEND TO NETWORK
-------------------------------------------------------------------------------------------------------

	process (reset, clock, ES, rx_av, command, credit_i, counterWord, nWord)
	begin
		if reset = '1' then
			ES <= S0;
		elsif clock'event and clock='0' then
			case ES is
			when S0 =>
				-- wait command
				if rx_av='1' then ES <= S1; end if;
			when S1 =>
				-- get command
				if (command/=x"0" and command/=x"1" and command/=x"2") then ES <= S0;
				elsif command=x"2" then ES <= S7; -- ability
				elsif rx_av='1' then ES <= S2; -- read or write
				end if;
			when S2 =>
				-- get target
				-- wait number of words
				if rx_av='1' then ES <= S3; end if;
			when S3 =>
				-- get number of words
				-- wait high byte of address
				if rx_av='1' then ES <= S4; end if;
			when S4 =>
				-- get high byte of address
				-- wait low byte of address
				if rx_av='1' and command=x"00" then ES <= S7a; -- read
				elsif rx_av='1' then ES <= S5; -- write
				end if;
			when S5 =>
				-- get low byte of address
				-- wait high byte of data
				if rx_av='1' then ES <= S6; end if;
			when S5a =>
				-- wait high byte of data
				if rx_av='1' then ES <= S6; end if;
			when S6 =>
				-- get high byte of data
				-- wait low byte of data
				if rx_av='1' then ES <= S7b; end if;
			when S7 => -- ability
				ES <= S0;
			when S7a => -- read
				-- get low byte of address
				-- send target
				if credit_i(L1)='1' then ES <= S8; end if;
			when S7b => -- write
				-- get low byte of data
				-- send target
				if credit_i(L1)='1' then ES <= S8; end if;
			when S7c =>
				-- send target
				if credit_i(L1)='1' then ES <= S8; end if;
			when S8 =>
				-- send size
				if credit_i(L1)='1' then ES <= S9; end if;
			when S9 =>
				-- send source
				if credit_i(L1)='1' then ES <= S10; end if;
			when S10 =>
				-- send command
				if credit_i(L1)='1' and command=x"2" then ES <= S0; -- ability
				elsif credit_i(L1)='1' then ES <= S11; -- read or write
				end if;
			when S11 =>
				-- send address
				if credit_i(L1)='1' and command=x"0" and (counterWord+1)=nWord then ES <= S0; -- read all words
				elsif credit_i(L1)='1' and command=x"0" and (counterWord+1)/=nWord then ES <= S13; -- read and there are more word
				elsif credit_i(L1)='1' then ES <= S12; -- write
				end if;
			when S12 =>
				-- send data
				if credit_i(L1)='1' and (counterWord+1)=nWord then ES <= S0; -- write all words
				elsif credit_i(L1)='1' then ES <= S13; -- write and there are more words
				end if;
			when S13 =>
				if command=x"0" then ES <= S7c; -- read
				else ES <= S5a; -- write
				end if;
			end case;
		end if;
	end process;

	process (reset,clock)
	begin
		if reset='1' then
			tx <= '0';
			lane_tx <= (others => '0');
			data_out <= (others => '0');
			command <= (others=>'0');
			target <= (others=>'0');
			nWord <= (others=>'0');
			counterWord <= (others=>'0');
			add <= (others=>'0');
			data <= (others=>'0');
			start <= '0';
		elsif clock'event and clock='1' then
			case ES is
				when S0 =>
					tx <= '0';
					lane_tx <= (others => '0');
					data_out <= (others => '0');
					command <= (others=>'0');
					target <= (others=>'0');
					nWord <= (others=>'0');
					counterWord <= (others=>'0');
					add <= (others=>'0');
					data <= (others=>'0');
					start <= '0';
				when S1 =>
					-- get command
					command <= x"00" & rx_data;
				when S2 =>
					-- get target
					target <= x"00" & rx_data;
				when S3 =>
					-- get number of words
					nWord <= x"00" & rx_data;
				when S4 =>
					-- get high byte of address
					add(15 downto 8) <= rx_data;
				when S5 =>
					-- get low byte of address
					add(7 downto 0) <= rx_data;
					tx <= '0';
					lane_tx <= (others => '0');
				when S5a =>
					null;
				when S6 =>
					-- get high byte of data
					data(15 downto 8) <= rx_data;
				when S7 =>
					-- ability
					start <= '1';
				when S7a =>
					-- get low byte of address
					add(7 downto 0) <= rx_data;

					-- send target
					tx <= '1';
					lane_tx(L1) <= '1';
					data_out <= target;
				when S7b =>
					-- get low byte of data
					data(7 downto 0) <= rx_data;

					-- send target
					tx <= '1';
					lane_tx(L1) <= '1';
					data_out <= target;
				when S7c =>
					-- send target
					tx <= '1';
					lane_tx(L1) <= '1';
					data_out <= target;
				when S8 =>
					-- send size
					tx <= '1';
					lane_tx(L1) <= '1';
					if command=x"0" then data_out <= x"0003";    -- comando de leitura
					elsif command=x"1" then data_out <= x"0004"; -- comando de escrita
					elsif command=x"2" then data_out <= x"0002"; -- comando de habilitação do processador
					end if;
				when S9 =>
					-- send source
					tx <= '1';
					lane_tx(L1) <= '1';
					data_out <= x"00" & address;
				when S10 =>
					-- envia para rede o flit contendo o comando do pacote
					tx <= '1';
					lane_tx(L1) <= '1';
					data_out <= command;
				when S11 =>
					-- send address
					tx <= '1';
					lane_tx(L1) <= '1';
					data_out <= add;
				when S12 =>
					-- send data
					tx <= '1';
					lane_tx(L1) <= '1';
					data_out <= data;
				when S13 =>
					tx <= '0';
					lane_tx <= (others => '0');
					add <= add + '1';
					counterWord <= counterWord + '1';
			end case;
		end if;
	end process;


-------------------------------------------------------------------------------------------------------
---- RECEIVE FROM NETWORK  - SEND TO SOFTWARE SERIAL
-------------------------------------------------------------------------------------------------------
	process(reset, clock_rx)
	begin
		if reset='1' then
		-- receive only by the channel L1
			credit_o(L1) <= '1';
			credit_o(L2) <= '0';
		elsif clock_rx'event and clock_rx='1' then
			if busySerial = '0' then credit_o(L1) <= '1';
			else credit_o(L1) <= '0';
			end if;
		end if;
	end process;

	process (reset,clock_rx)
	begin
		if reset='1' then
			busySerial<='0';
			tx_start <= '0';
			tx_data <= (others=>'0');
			sourceReceive <= (others=>'0');
			commandReceive <= (others=>'0');
			counterWordReceive <= (others=>'0');
			dataReceive <= (others=>'0');
			ER <= S0;
		elsif clock_rx'event and clock_rx='0' then
			case ER is
				when S0 =>
					busySerial<='0';
					tx_start <= '0';
					tx_data <= (others=>'0');
					sourceReceive <= (others=>'0');
					commandReceive <= (others=>'0');
					counterWordReceive <= (others=>'0');
					dataReceive <= (others=>'0');
					if rx='1' then
					    -- recebendo target
						ER <= S1;
					end if;
				when S1 =>
					if rx='1' then
					    -- recebendo size
						ER <= S2;
					end if;
				when S2 =>
					if rx='1' then
					    -- recebendo source
						sourceReceive <= data_in;
						ER <= S3;
					end if;
				when S3 =>
					if rx='1' then
					    -- recebendo comando
						commandReceive <= data_in;
						ER <= S4;
					end if;
				when S4 =>
					if rx='1' and commandReceive=x"0009" then
						-- recebendo data
						dataReceive <= data_in;
						busySerial<='1';
						ER <= S5;
					end if;
				when S5 =>
				    -- envio do data parte alta
					tx_start <= '1';
					tx_data <= dataReceive(15 downto 8);
					counterWordReceive <= counterWordReceive + '1';
					ER <= S6;
				when S6 =>
				    -- espera o envio do data parte alta
					tx_start <= '0';
					if tx_busy='0' then
						ER<=S7;
					end if;
				when S7 =>
				    -- envio do data parte baixa
					tx_start <= '1';
					tx_data <= dataReceive(7 downto 0);
					ER <= S8;
				when S8 =>
				    -- espera o envio do data parte baixa
					tx_start <= '0';
					if tx_busy='0' then
						busySerial<='0';
						ER<=S0;
					end if;
			end case;
		end if;
	end process;
end Serial;