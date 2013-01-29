library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use work.HermesPackage.all;

entity NOC is
port(
	clock         : in  regNrot;
	reset         : in  std_logic;
	clock_rxLocal : in  regNrot;
	rxLocal       : in  regNrot;
	lane_rxLocal  : in  arrayNrot_regNlane;
	data_inLocal  : in  arrayNrot_regflit;
	credit_oLocal : out arrayNrot_regNlane;
	clock_txLocal : out regNrot;
	txLocal       : out regNrot;
	lane_txLocal  : out arrayNrot_regNlane;
	data_outLocal : out arrayNrot_regflit;
	credit_iLocal : in  arrayNrot_regNlane);
end NOC;

architecture NOC of NOC is

	signal clock_rxN0000, clock_rxN0100 : regNport;
	signal rxN0000, rxN0100 : regNport;
	signal lane_rxN0000, lane_rxN0100 : arrayNport_regNlane;
	signal data_inN0000, data_inN0100 : arrayNport_regflit;
	signal credit_oN0000, credit_oN0100 : arrayNport_regNlane;
	signal clock_txN0000, clock_txN0100 : regNport;
	signal txN0000, txN0100 : regNport;
	signal lane_txN0000, lane_txN0100 : arrayNport_regNlane;
	signal data_outN0000, data_outN0100 : arrayNport_regflit;
	signal credit_iN0000, credit_iN0100 : arrayNport_regNlane;
	signal clock_rxN0001, clock_rxN0101 : regNport;
	signal rxN0001, rxN0101 : regNport;
	signal lane_rxN0001, lane_rxN0101 : arrayNport_regNlane;
	signal data_inN0001, data_inN0101 : arrayNport_regflit;
	signal credit_oN0001, credit_oN0101 : arrayNport_regNlane;
	signal clock_txN0001, clock_txN0101 : regNport;
	signal txN0001, txN0101 : regNport;
	signal lane_txN0001, lane_txN0101 : arrayNport_regNlane;
	signal data_outN0001, data_outN0101 : arrayNport_regflit;
	signal credit_iN0001, credit_iN0101 : arrayNport_regNlane;
	signal clock_rxN0200, clock_rxN0201 : regNport;
	signal rxN0200, rxN0201 : regNport;
	signal lane_rxN0200, lane_rxN0201 : arrayNport_regNlane;
	signal data_inN0200, data_inN0201 : arrayNport_regflit;
	signal credit_oN0200, credit_oN0201 : arrayNport_regNlane;
	signal clock_txN0200, clock_txN0201 : regNport;
	signal txN0200, txN0201 : regNport;
	signal lane_txN0200, lane_txN0201 : arrayNport_regNlane;
	signal data_outN0200, data_outN0201 : arrayNport_regflit;
	signal credit_iN0200, credit_iN0201 : arrayNport_regNlane;
begin

	Router0000 : Entity work.RouterBL
	generic map( address => ADDRESSN0000 )
	port map(
		clock => clock(N0000),
		reset => reset,
		clock_rx => clock_rxN0000,
		rx => rxN0000,
		lane_rx => lane_rxN0000,
		data_in => data_inN0000,
		credit_o => credit_oN0000,
		clock_tx => clock_txN0000,
		tx => txN0000,
		lane_tx => lane_txN0000,
		data_out => data_outN0000,
		credit_i => credit_iN0000);

	Router0100 : Entity work.RouterBC
	generic map( address => ADDRESSN0100 )
	port map(
		clock => clock(N0100),
		reset => reset,
		clock_rx => clock_rxN0100,
		rx => rxN0100,
		lane_rx => lane_rxN0100,
		data_in => data_inN0100,
		credit_o => credit_oN0100,
		clock_tx => clock_txN0100,
		tx => txN0100,
		lane_tx => lane_txN0100,
		data_out => data_outN0100,
		credit_i => credit_iN0100);

	Router0001 : Entity work.RouterTL
	generic map( address => ADDRESSN0001 )
	port map(
		clock => clock(N0001),
		reset => reset,
		clock_rx => clock_rxN0001,
		rx => rxN0001,
		lane_rx => lane_rxN0001,
		data_in => data_inN0001,
		credit_o => credit_oN0001,
		clock_tx => clock_txN0001,
		tx => txN0001,
		lane_tx => lane_txN0001,
		data_out => data_outN0001,
		credit_i => credit_iN0001);

	Router0101 : Entity work.RouterTC
	generic map( address => ADDRESSN0101 )
	port map(
		clock => clock(N0101),
		reset => reset,
		clock_rx => clock_rxN0101,
		rx => rxN0101,
		lane_rx => lane_rxN0101,
		data_in => data_inN0101,
		credit_o => credit_oN0101,
		clock_tx => clock_txN0101,
		tx => txN0101,
		lane_tx => lane_txN0101,
		data_out => data_outN0101,
		credit_i => credit_iN0101);

	Router0200 : Entity work.RouterBR
	generic map( address => ADDRESSN0200 )
	port map(
		clock => clock(N0200),
		reset => reset,
		clock_rx => clock_rxN0200,
		rx => rxN0200,
		lane_rx => lane_rxN0200,
		data_in => data_inN0200,
		credit_o => credit_oN0200,
		clock_tx => clock_txN0200,
		tx => txN0200,
		lane_tx => lane_txN0200,
		data_out => data_outN0200,
		credit_i => credit_iN0200);

	Router0201 : Entity work.RouterTR
	generic map( address => ADDRESSN0201 )
	port map(
		clock => clock(N0201),
		reset => reset,
		clock_rx => clock_rxN0201,
		rx => rxN0201,
		lane_rx => lane_rxN0201,
		data_in => data_inN0201,
		credit_o => credit_oN0201,
		clock_tx => clock_txN0201,
		tx => txN0201,
		lane_tx => lane_txN0201,
		data_out => data_outN0201,
		credit_i => credit_iN0201);

	-- router0000 inputs
	clock_rxN0000(EAST)<=clock_txN0100(WEST);
	rxN0000(EAST)<=txN0100(WEST);
	lane_rxN0000(EAST)<=lane_txN0100(WEST);
	data_inN0000(EAST)<=data_outN0100(WEST);
	credit_iN0000(EAST)<=credit_oN0100(WEST);
	clock_rxN0000(WEST)<='0';
	rxN0000(WEST)<='0';
	lane_rxN0000(WEST)<=(others=>'0');
	data_inN0000(WEST)<=(others=>'0');
	credit_iN0000(WEST)<=(others=>'0');
	clock_rxN0000(SOUTH)<='0';
	rxN0000(SOUTH)<='0';
	lane_rxN0000(SOUTH)<=(others=>'0');
	data_inN0000(SOUTH)<=(others=>'0');
	credit_iN0000(SOUTH)<=(others=>'0');
	clock_rxN0000(NORTH)<=clock_txN0001(SOUTH);
	rxN0000(NORTH)<=txN0001(SOUTH);
	lane_rxN0000(NORTH)<=lane_txN0001(SOUTH);
	data_inN0000(NORTH)<=data_outN0001(SOUTH);
	credit_iN0000(NORTH)<=credit_oN0001(SOUTH);
	clock_rxN0000(LOCAL)<=clock_rxLocal(N0000);
	rxN0000(LOCAL)<=rxLocal(N0000);
	lane_rxN0000(LOCAL)<=lane_rxLocal(N0000);
	data_inN0000(LOCAL)<=data_inLocal(N0000);
	credit_iN0000(LOCAL)<=credit_iLocal(N0000);
	clock_txLocal(N0000)<=clock_txN0000(LOCAL);
	txLocal(N0000)<=txN0000(LOCAL);
	lane_txLocal(N0000)<=lane_txN0000(LOCAL);
	data_outLocal(N0000)<=data_outN0000(LOCAL);
	credit_oLocal(N0000)<=credit_oN0000(LOCAL);

	-- router0100 inputs
	clock_rxN0100(EAST)<=clock_txN0200(WEST);
	rxN0100(EAST)<=txN0200(WEST);
	lane_rxN0100(EAST)<=lane_txN0200(WEST);
	data_inN0100(EAST)<=data_outN0200(WEST);
	credit_iN0100(EAST)<=credit_oN0200(WEST);
	clock_rxN0100(WEST)<=clock_txN0000(EAST);
	rxN0100(WEST)<=txN0000(EAST);
	lane_rxN0100(WEST)<=lane_txN0000(EAST);
	data_inN0100(WEST)<=data_outN0000(EAST);
	credit_iN0100(WEST)<=credit_oN0000(EAST);
	clock_rxN0100(SOUTH)<='0';
	rxN0100(SOUTH)<='0';
	lane_rxN0100(SOUTH)<=(others=>'0');
	data_inN0100(SOUTH)<=(others=>'0');
	credit_iN0100(SOUTH)<=(others=>'0');
	clock_rxN0100(NORTH)<=clock_txN0101(SOUTH);
	rxN0100(NORTH)<=txN0101(SOUTH);
	lane_rxN0100(NORTH)<=lane_txN0101(SOUTH);
	data_inN0100(NORTH)<=data_outN0101(SOUTH);
	credit_iN0100(NORTH)<=credit_oN0101(SOUTH);
	clock_rxN0100(LOCAL)<=clock_rxLocal(N0100);
	rxN0100(LOCAL)<=rxLocal(N0100);
	lane_rxN0100(LOCAL)<=lane_rxLocal(N0100);
	data_inN0100(LOCAL)<=data_inLocal(N0100);
	credit_iN0100(LOCAL)<=credit_iLocal(N0100);
	clock_txLocal(N0100)<=clock_txN0100(LOCAL);
	txLocal(N0100)<=txN0100(LOCAL);
	lane_txLocal(N0100)<=lane_txN0100(LOCAL);
	data_outLocal(N0100)<=data_outN0100(LOCAL);
	credit_oLocal(N0100)<=credit_oN0100(LOCAL);
	
	-- router0200 inputs	
	clock_rxN0200(EAST)<='0';
	rxN0200(EAST)<='0';
	lane_rxN0200(EAST)<=(others=>'0');
	data_inN0200(EAST)<=(others=>'0');
	credit_iN0200(EAST)<=(others=>'0');
	clock_rxN0200(WEST)<=clock_txN0100(EAST);
	rxN0200(WEST)<=txN0100(EAST);
	lane_rxN0200(WEST)<=lane_txN0100(EAST);
	data_inN0200(WEST)<=data_outN0100(EAST);
	credit_iN0200(WEST)<=credit_oN0100(EAST);
	clock_rxN0200(SOUTH)<='0';
	rxN0200(SOUTH)<='0';
	lane_rxN0200(SOUTH)<=(others=>'0');
	data_inN0200(SOUTH)<=(others=>'0');
	credit_iN0200(SOUTH)<=(others=>'0');
	clock_rxN0200(NORTH)<=clock_txN0201(SOUTH);
	rxN0200(NORTH)<=txN0201(SOUTH);
	lane_rxN0200(NORTH)<=lane_txN0201(SOUTH);
	data_inN0200(NORTH)<=data_outN0201(SOUTH);
	credit_iN0200(NORTH)<=credit_oN0201(SOUTH);
	clock_rxN0200(LOCAL)<=clock_rxLocal(N0200);
	rxN0200(LOCAL)<=rxLocal(N0200);
	lane_rxN0200(LOCAL)<=lane_rxLocal(N0200);
	data_inN0200(LOCAL)<=data_inLocal(N0200);
	credit_iN0200(LOCAL)<=credit_iLocal(N0200);
	clock_txLocal(N0200)<=clock_txN0200(LOCAL);
	txLocal(N0200)<=txN0200(LOCAL);
	lane_txLocal(N0200)<=lane_txN0200(LOCAL);
	data_outLocal(N0200)<=data_outN0200(LOCAL);
	credit_oLocal(N0200)<=credit_oN0200(LOCAL);

	-- router0001 inputs
	clock_rxN0001(EAST)<=clock_txN0101(WEST);
	rxN0001(EAST)<=txN0101(WEST);
	lane_rxN0001(EAST)<=lane_txN0101(WEST);
	data_inN0001(EAST)<=data_outN0101(WEST);
	credit_iN0001(EAST)<=credit_oN0101(WEST);
	clock_rxN0001(WEST)<='0';
	rxN0001(WEST)<='0';
	lane_rxN0001(WEST)<=(others=>'0');
	data_inN0001(WEST)<=(others=>'0');
	credit_iN0001(WEST)<=(others=>'0');
	clock_rxN0001(SOUTH)<=clock_txN0000(NORTH);
	rxN0001(SOUTH)<=txN0000(NORTH);
	lane_rxN0001(SOUTH)<=lane_txN0000(NORTH);
	data_inN0001(SOUTH)<=data_outN0000(NORTH);
	credit_iN0001(SOUTH)<=credit_oN0000(NORTH);
	clock_rxN0001(NORTH)<='0';
	rxN0001(NORTH)<='0';
	lane_rxN0001(NORTH)<=(others=>'0');
	data_inN0001(NORTH)<=(others=>'0');
	credit_iN0001(NORTH)<=(others=>'0');
	clock_rxN0001(LOCAL)<=clock_rxLocal(N0001);
	rxN0001(LOCAL)<=rxLocal(N0001);
	lane_rxN0001(LOCAL)<=lane_rxLocal(N0001);
	data_inN0001(LOCAL)<=data_inLocal(N0001);
	credit_iN0001(LOCAL)<=credit_iLocal(N0001);
	clock_txLocal(N0001)<=clock_txN0001(LOCAL);
	txLocal(N0001)<=txN0001(LOCAL);
	lane_txLocal(N0001)<=lane_txN0001(LOCAL);
	data_outLocal(N0001)<=data_outN0001(LOCAL);
	credit_oLocal(N0001)<=credit_oN0001(LOCAL);

	-- router0101 inputs
	clock_rxN0101(EAST)<=clock_txN0201(WEST);
	rxN0101(EAST)<=txN0201(WEST);
	lane_rxN0101(EAST)<=lane_txN0201(WEST);
	data_inN0101(EAST)<=data_outN0201(WEST);
	credit_iN0101(EAST)<=credit_oN0201(WEST);
	clock_rxN0101(WEST)<=clock_txN0001(EAST);
	rxN0101(WEST)<=txN0001(EAST);
	lane_rxN0101(WEST)<=lane_txN0001(EAST);
	data_inN0101(WEST)<=data_outN0001(EAST);
	credit_iN0101(WEST)<=credit_oN0001(EAST);
	clock_rxN0101(SOUTH)<=clock_txN0100(NORTH);
	rxN0101(SOUTH)<=txN0100(NORTH);
	lane_rxN0101(SOUTH)<=lane_txN0100(NORTH);
	data_inN0101(SOUTH)<=data_outN0100(NORTH);
	credit_iN0101(SOUTH)<=credit_oN0100(NORTH);
	clock_rxN0101(NORTH)<='0';
	rxN0101(NORTH)<='0';
	lane_rxN0101(NORTH)<=(others=>'0');
	data_inN0101(NORTH)<=(others=>'0');
	credit_iN0101(NORTH)<=(others=>'0');
	clock_rxN0101(LOCAL)<=clock_rxLocal(N0101);
	rxN0101(LOCAL)<=rxLocal(N0101);
	lane_rxN0101(LOCAL)<=lane_rxLocal(N0101);
	data_inN0101(LOCAL)<=data_inLocal(N0101);
	credit_iN0101(LOCAL)<=credit_iLocal(N0101);
	clock_txLocal(N0101)<=clock_txN0101(LOCAL);
	txLocal(N0101)<=txN0101(LOCAL);
	lane_txLocal(N0101)<=lane_txN0101(LOCAL);
	data_outLocal(N0101)<=data_outN0101(LOCAL);
	credit_oLocal(N0101)<=credit_oN0101(LOCAL);

	-- router0201 inputs
	clock_rxN0201(EAST)<='0';
	rxN0201(EAST)<='0';
	lane_rxN0201(EAST)<=(others=>'0');
	data_inN0201(EAST)<=(others=>'0');
	credit_iN0201(EAST)<=(others=>'0');
	clock_rxN0201(WEST)<=clock_txN0101(EAST);
	rxN0201(WEST)<=txN0101(EAST);
	lane_rxN0201(WEST)<=lane_txN0101(EAST);
	data_inN0201(WEST)<=data_outN0101(EAST);
	credit_iN0201(WEST)<=credit_oN0101(EAST);
	clock_rxN0201(SOUTH)<=clock_txN0200(NORTH);
	rxN0201(SOUTH)<=txN0200(NORTH);
	lane_rxN0201(SOUTH)<=lane_txN0200(NORTH);
	data_inN0201(SOUTH)<=data_outN0200(NORTH);
	credit_iN0201(SOUTH)<=credit_oN0200(NORTH);
	clock_rxN0201(NORTH)<='0';
	rxN0201(NORTH)<='0';
	lane_rxN0201(NORTH)<=(others=>'0');
	data_inN0201(NORTH)<=(others=>'0');
	credit_iN0201(NORTH)<=(others=>'0');
	clock_rxN0201(LOCAL)<=clock_rxLocal(N0201);
	rxN0201(LOCAL)<=rxLocal(N0201);
	lane_rxN0201(LOCAL)<=lane_rxLocal(N0201);
	data_inN0201(LOCAL)<=data_inLocal(N0201);
	credit_iN0201(LOCAL)<=credit_iLocal(N0201);
	clock_txLocal(N0201)<=clock_txN0201(LOCAL);
	txLocal(N0201)<=txN0201(LOCAL);
	lane_txLocal(N0201)<=lane_txN0201(LOCAL);
	data_outLocal(N0201)<=data_outN0201(LOCAL);
	credit_oLocal(N0201)<=credit_oN0201(LOCAL);

	-- the component below, router_output, must be commented to simulate without SystemC
--	router_output: Entity work.outmodulerouter
--	port map(
--		clock           => clock(N0000),
--		reset           => reset,
--		tx_r0p0        => txN0000(EAST),
--		lane_tx_r0p0l0  => lane_txN0000(EAST)(L1),
--		lane_tx_r0p0l1  => lane_txN0000(EAST)(L2),
--		out_r0p0        => data_outN0000(EAST),
--		credit_ir0p0l0  => credit_iN0000(EAST)(L1),
--		credit_ir0p0l1  => credit_iN0000(EAST)(L2),
--		tx_r0p2        => txN0000(NORTH),
--		lane_tx_r0p2l0  => lane_txN0000(NORTH)(L1),
--		lane_tx_r0p2l1  => lane_txN0000(NORTH)(L2),
--		out_r0p2        => data_outN0000(NORTH),
--		credit_ir0p2l0  => credit_iN0000(NORTH)(L1),
--		credit_ir0p2l1  => credit_iN0000(NORTH)(L2),
--		tx_r1p1        => txN0100(WEST),
--		lane_tx_r1p1l0  => lane_txN0100(WEST)(L1),
--		lane_tx_r1p1l1  => lane_txN0100(WEST)(L2),
--		out_r1p1        => data_outN0100(WEST),
--		credit_ir1p1l0  => credit_iN0100(WEST)(L1),
--		credit_ir1p1l1  => credit_iN0100(WEST)(L2),
--		tx_r1p2        => txN0100(NORTH),
--		lane_tx_r1p2l0  => lane_txN0100(NORTH)(L1),
--		lane_tx_r1p2l1  => lane_txN0100(NORTH)(L2),
--		out_r1p2        => data_outN0100(NORTH),
--		credit_ir1p2l0  => credit_iN0100(NORTH)(L1),
--		credit_ir1p2l1  => credit_iN0100(NORTH)(L2),
--		tx_r2p0        => txN0001(EAST),
--		lane_tx_r2p0l0  => lane_txN0001(EAST)(L1),
--		lane_tx_r2p0l1  => lane_txN0001(EAST)(L2),
--		out_r2p0        => data_outN0001(EAST),
--		credit_ir2p0l0  => credit_iN0001(EAST)(L1),
--		credit_ir2p0l1  => credit_iN0001(EAST)(L2),
--		tx_r2p2        => txN0001(NORTH),
--		lane_tx_r2p2l0  => lane_txN0001(NORTH)(L1),
--		lane_tx_r2p2l1  => lane_txN0001(NORTH)(L2),
--		out_r2p2        => data_outN0001(NORTH),
--		credit_ir2p2l0  => credit_iN0001(NORTH)(L1),
--		credit_ir2p2l1  => credit_iN0001(NORTH)(L2),
--		tx_r2p3        => txN0001(SOUTH),
--		lane_tx_r2p3l0  => lane_txN0001(SOUTH)(L1),
--		lane_tx_r2p3l1  => lane_txN0001(SOUTH)(L2),
--		out_r2p3        => data_outN0001(SOUTH),
--		credit_ir2p3l0  => credit_iN0001(SOUTH)(L1),
--		credit_ir2p3l1  => credit_iN0001(SOUTH)(L2),
--		tx_r3p1        => txN0101(WEST),
--		lane_tx_r3p1l0  => lane_txN0101(WEST)(L1),
--		lane_tx_r3p1l1  => lane_txN0101(WEST)(L2),
--		out_r3p1        => data_outN0101(WEST),
--		credit_ir3p1l0  => credit_iN0101(WEST)(L1),
--		credit_ir3p1l1  => credit_iN0101(WEST)(L2),
--		tx_r3p2        => txN0101(NORTH),
--		lane_tx_r3p2l0  => lane_txN0101(NORTH)(L1),
--		lane_tx_r3p2l1  => lane_txN0101(NORTH)(L2),
--		out_r3p2        => data_outN0101(NORTH),
--		credit_ir3p2l0  => credit_iN0101(NORTH)(L1),
--		credit_ir3p2l1  => credit_iN0101(NORTH)(L2),
--		tx_r3p3        => txN0101(SOUTH),
--		lane_tx_r3p3l0  => lane_txN0101(SOUTH)(L1),
--		lane_tx_r3p3l1  => lane_txN0101(SOUTH)(L2),
--		out_r3p3        => data_outN0101(SOUTH),
--		credit_ir3p3l0  => credit_iN0101(SOUTH)(L1),
--		credit_ir3p3l1  => credit_iN0101(SOUTH)(L2),
--		tx_r4p0        => txN0002(EAST),
--		lane_tx_r4p0l0  => lane_txN0002(EAST)(L1),
--		lane_tx_r4p0l1  => lane_txN0002(EAST)(L2),
--		out_r4p0        => data_outN0002(EAST),
--		credit_ir4p0l0  => credit_iN0002(EAST)(L1),
--		credit_ir4p0l1  => credit_iN0002(EAST)(L2),
--		tx_r4p3        => txN0002(SOUTH),
--		lane_tx_r4p3l0  => lane_txN0002(SOUTH)(L1),
--		lane_tx_r4p3l1  => lane_txN0002(SOUTH)(L2),
--		out_r4p3        => data_outN0002(SOUTH),
--		credit_ir4p3l0  => credit_iN0002(SOUTH)(L1),
--		credit_ir4p3l1  => credit_iN0002(SOUTH)(L2),
--		tx_r5p1        => txN0102(WEST),
--		lane_tx_r5p1l0  => lane_txN0102(WEST)(L1),
--		lane_tx_r5p1l1  => lane_txN0102(WEST)(L2),
--		out_r5p1        => data_outN0102(WEST),
--		credit_ir5p1l0  => credit_iN0102(WEST)(L1),
--		credit_ir5p1l1  => credit_iN0102(WEST)(L2),
--		tx_r5p3        => txN0102(SOUTH),
--		lane_tx_r5p3l0  => lane_txN0102(SOUTH)(L1),
--		lane_tx_r5p3l1  => lane_txN0102(SOUTH)(L2),
--		out_r5p3        => data_outN0102(SOUTH),
--		credit_ir5p3l0  => credit_iN0102(SOUTH)(L1),
--		credit_ir5p3l1  => credit_iN0102(SOUTH)(L2));

end NOC;
