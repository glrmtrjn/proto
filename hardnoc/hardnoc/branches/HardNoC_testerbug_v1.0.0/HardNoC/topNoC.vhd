library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_arith.CONV_STD_LOGIC_VECTOR;
use work.HermesPackage.all;
   entity topNoC is
end;

architecture topNoC of topNoC is

	signal clock : regNrot;
	signal reset : std_logic;
	signal clock_rx, clock_tx: regNrot;
	signal rx, tx: regNrot;
	signal lane_rx, lane_tx: arrayNrot_regNlane;
	signal data_in, data_out : arrayNrot_regflit;
	signal credit_o, credit_i: arrayNrot_regNlane;

begin
	reset <= '1', '0' after 15 ns;

	-- clock do roteador N0000
	process
	begin
		clock(N0000) <= '1', '0' after 10 ns;
		wait for 20 ns;
	end process;

	-- clock do roteador N0100
	process
	begin
		clock(N0100) <= '1', '0' after 10 ns;
		wait for 20 ns;
	end process;

	-- clock do roteador N0001
	process
	begin
		clock(N0001) <= '1', '0' after 10 ns;
		wait for 20 ns;
	end process;

	-- clock do roteador N0101
	process
	begin
		clock(N0101) <= '1', '0' after 10 ns;
		wait for 20 ns;
	end process;

	-- clock do roteador N0002
	process
	begin
		clock(N0002) <= '1', '0' after 10 ns;
		wait for 20 ns;
	end process;

	-- clock do roteador N0102
	process
	begin
		clock(N0102) <= '1', '0' after 10 ns;
		wait for 20 ns;
	end process;

	NOC: Entity work.NOC(NOC)
	port map(
		clock         => clock,
		reset         => reset,
		clock_rxLocal => clock_rx,
		rxLocal       => rx,
		lane_rxLocal  => lane_rx,
		data_inLocal  => data_in,
		credit_oLocal => credit_o,
		clock_txLocal => clock_tx,
		txLocal       => tx,
		lane_txLocal  => lane_tx,
		data_outLocal => data_out,
		credit_iLocal => credit_i);

	cim00: Entity work.inputmodule
	port map(
		clock => clock(N0000),
		reset => reset,
		outclock0  => clock_rx(N0000),
		outtx0     => rx(N0000),
		lane_tx0   => lane_rx(N0000),
		outdata0   => data_in(N0000),
		incredit0  => credit_o(N0000),
		outclock1  => clock_rx(N0100),
		outtx1     => rx(N0100),
		lane_tx1   => lane_rx(N0100),
		outdata1   => data_in(N0100),
		incredit1  => credit_o(N0100),
		outclock2  => clock_rx(N0001),
		outtx2     => rx(N0001),
		lane_tx2   => lane_rx(N0001),
		outdata2   => data_in(N0001),
		incredit2  => credit_o(N0001),
		outclock3  => clock_rx(N0101),
		outtx3     => rx(N0101),
		lane_tx3   => lane_rx(N0101),
		outdata3   => data_in(N0101),
		incredit3  => credit_o(N0101),
		outclock4  => clock_rx(N0002),
		outtx4     => rx(N0002),
		lane_tx4   => lane_rx(N0002),
		outdata4   => data_in(N0002),
		incredit4  => credit_o(N0002),
		outclock5  => clock_rx(N0102),
		outtx5     => rx(N0102),
		lane_tx5   => lane_rx(N0102),
		outdata5   => data_in(N0102),
		incredit5  => credit_o(N0102));

	com00: Entity work.outmodule
	port map(
		Clock => clock(N0000),
		Reset => reset,
		inclock0   => clock_tx(N0000),
		inTx0      => tx(N0000),
		inlane_tx0 => lane_tx(N0000),
		inData0    => data_out(N0000),
		outCredit0 => credit_i(N0000),
		inclock1   => clock_tx(N0100),
		inTx1      => tx(N0100),
		inlane_tx1 => lane_tx(N0100),
		inData1    => data_out(N0100),
		outCredit1 => credit_i(N0100),
		inclock2   => clock_tx(N0001),
		inTx2      => tx(N0001),
		inlane_tx2 => lane_tx(N0001),
		inData2    => data_out(N0001),
		outCredit2 => credit_i(N0001),
		inclock3   => clock_tx(N0101),
		inTx3      => tx(N0101),
		inlane_tx3 => lane_tx(N0101),
		inData3    => data_out(N0101),
		outCredit3 => credit_i(N0101),
		inclock4   => clock_tx(N0002),
		inTx4      => tx(N0002),
		inlane_tx4 => lane_tx(N0002),
		inData4    => data_out(N0002),
		outCredit4 => credit_i(N0002),
		inclock5   => clock_tx(N0102),
		inTx5      => tx(N0102),
		inlane_tx5 => lane_tx(N0102),
		inData5    => data_out(N0102),
		outCredit5 => credit_i(N0102));

end topNoC;