library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_arith.CONV_STD_LOGIC_VECTOR;
use work.HermesPackage.all;

entity HardNoC is
port(
	system_clock:   in  std_logic;
	system_reset:   in  std_logic;
	rxd:            in  std_logic;
	txd:            out std_logic);
end HardNoC;

architecture HardNoC of HardNoC is

	signal clock, clock_rx, clock_tx: regNrot;
	signal rx, tx: regNrot;
	signal lane_rx, lane_tx: arrayNrot_regNlane;
	signal data_in, data_out : arrayNrot_regflit;
	signal credit_o, credit_i: arrayNrot_regNlane;
	signal n_reset, reset, ck, locked, start: std_logic;

begin

	n_reset <= not system_reset;

	DCM: Entity work.My_DCM
	port map(
		CLK_Base => system_clock,
		RST      => n_reset,
		CLKDV    => ck,
		LOCKED   => locked);

	reset <= not locked;

	clock(N0000) <= ck;
	clock(N0100) <= ck;
	clock(N0001) <= ck;
	clock(N0101) <= ck;
	clock(N0200) <= ck;
	clock(N0201) <= ck;

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

	IP0000 : Entity work.Serial
	port map(
		clock    => clock(N0000),
		reset    => reset,
		address  => addressN0000,
		start    => start,
		---------------- Interface Serial -----------------
		rxd      => rxd,
		txd      => txd,
		------------------ Interface NoC ------------------
		clock_tx => clock_rx(N0000),
		tx       => rx(N0000),
		lane_tx  => lane_rx(N0000),
		data_out => data_in(N0000),
		credit_i => credit_o(N0000),
		clock_rx => clock_tx(N0000),
		rx       => tx(N0000),
		lane_rx  => lane_tx(N0000),
		data_in  => data_out(N0000),
		credit_o => credit_i(N0000));

	IP0100 : Entity work.Tester
	port map(
		clock    => clock(N0100),
		reset    => reset,
		address  => addressN0100,
		start    => start,
		------------------ Interface NoC ------------------
		clock_tx => clock_rx(N0100),
		tx       => rx(N0100),
		lane_tx  => lane_rx(N0100),
		data_out => data_in(N0100),
		credit_i => credit_o(N0100),
		clock_rx => clock_tx(N0100),
		rx       => tx(N0100),
		lane_rx  => lane_tx(N0100),
		data_in  => data_out(N0100),
		credit_o => credit_i(N0100));

	IP0001 : Entity work.Tester
	port map(
		clock    => clock(N0001),
		reset    => reset,
		address  => addressN0001,
		start    => start,
		------------------ Interface NoC ------------------
		clock_tx => clock_rx(N0001),
		tx       => rx(N0001),
		lane_tx  => lane_rx(N0001),
		data_out => data_in(N0001),
		credit_i => credit_o(N0001),
		clock_rx => clock_tx(N0001),
		rx       => tx(N0001),
		lane_rx  => lane_tx(N0001),
		data_in  => data_out(N0001),
		credit_o => credit_i(N0001));

	IP0101 : Entity work.Tester
	port map(
		clock    => clock(N0101),
		reset    => reset,
		address  => addressN0101,
		start    => start,
		------------------ Interface NoC ------------------
		clock_tx => clock_rx(N0101),
		tx       => rx(N0101),
		lane_tx  => lane_rx(N0101),
		data_out => data_in(N0101),
		credit_i => credit_o(N0101),
		clock_rx => clock_tx(N0101),
		rx       => tx(N0101),
		lane_rx  => lane_tx(N0101),
		data_in  => data_out(N0101),
		credit_o => credit_i(N0101));

	IP0200 : Entity work.Tester
	port map(
		clock    => clock(N0200),
		reset    => reset,
		address  => addressN0200,
		start    => start,
		------------------ Interface NoC ------------------
		clock_tx => clock_rx(N0200),
		tx       => rx(N0200),
		lane_tx  => lane_rx(N0200),
		data_out => data_in(N0200),
		credit_i => credit_o(N0200),
		clock_rx => clock_tx(N0200),
		rx       => tx(N0200),
		lane_rx  => lane_tx(N0200),
		data_in  => data_out(N0200),
		credit_o => credit_i(N0200));

	IP0201 : Entity work.Tester
	port map(
		clock    => clock(N0201),
		reset    => reset,
		address  => addressN0201,
		start    => start,
		------------------ Interface NoC ------------------
		clock_tx => clock_rx(N0201),
		tx       => rx(N0201),
		lane_tx  => lane_rx(N0201),
		data_out => data_in(N0201),
		credit_i => credit_o(N0201),
		clock_rx => clock_tx(N0201),
		rx       => tx(N0201),
		lane_rx  => lane_tx(N0201),
		data_in  => data_out(N0201),
		credit_o => credit_i(N0201));

end HardNoC;