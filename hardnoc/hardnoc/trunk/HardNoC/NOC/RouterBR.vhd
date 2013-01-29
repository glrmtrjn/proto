---------------------------------------------------------------------------------------
--                                                ROUTER
--
--                                                 NORTH                   LOCAL
--              ------------------------------------------------------------------
--              |                            ****** ******     ******  ****** |
--              |                          *FILA* *FILA*      *FILA* *FILA* |
--              |                          *   L1  * *  L2  *      *   L1  * *   L2  * |
--              |                           ******  ******      ******  ****** |
--              |                                                                                      |
--              | *********      ***************           *********  |
--              | *FILA L1*      * ARBITRAGEM  *          * FILA L1* |
--              | *********      ***************           *********  |
--  WEST | *********      ****************         ********* |
--              | *FILA L2*      * ROTEAMENTO  *        *FILA L2* |
--              | *********      ****************          ********* |
--              |                                                                                      |
--              |                            ****** ******                                 |
--              |                            *FILA* *FILA*                                |
--              |                            *   L1  * *  L2  *                                |
--              |                             ****** ******                                |
--              ------------------------------------------------------------------
--                                    SOUTH
--
--  Os roteadores realizam a transfer�ncia de mensagens entre n�cleos.
--  O roteador possui uma l�gica de controle de chaveamento e 5 portas bidirecionais:
--  East, West, North, South e Local. Cada porta possui dois canais virtuais, cada
--  um com uma fila para o armazenamento tempor�rio de flits. A porta Local estabelece
--  a comunica��o entre o roteador e seu n�cleo. As demais portas ligam o roteador aos
--  roteadores vizinhos.
--  Os endere�os dos roteadores s�o compostos pelas coordenadas XY da rede de
--  interconex�o, onde X � a posi��o horizontal e Y a posi��o vertical. A atribui��o de
--  endere�os aos roteadores � necess�ria para a execu��o do algoritmo de chaveamento.
--  Os m�dulos que comp�em o roteador s�o: Hermes_buffer (porta de entrada e filas),
--  Hermes_switchcontrol (arbitragem e roteamento) e Hermes_outport (porta de sa�da).
--  Cada uma das filas do roteador, ao receber um novo pacote requisita chaveamento ao
--  �rbitro. O �rbitro seleciona a requisi��o de maior prioridade, quando existem
--  requisi��es simult�neas, e encaminha o pedido � l�gica de chaveamento. A l�gica de
--  chaveamento verifica se � poss�vel atender � solicita��o. Sendo poss�vel, a conex�o
--  � estabelecida e a fila come�a a enviar os flits armazenados. Quando todos os flits
--  do pacote s�o enviados, a fila sinaliza atrav�s do sinal sender que a conex�o deve
--  ser finalizada.
---------------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;
use work.HermesPackage.all;

entity RouterBR is
generic( address: regmetadeflit);
port(
	clock:      in  std_logic;
	reset:      in  std_logic;
	clock_rx:   in  regNport;
	rx:         in  regNport;
	lane_rx:    in  arrayNport_regNlane;
	data_in:    in  arrayNport_regflit;
	credit_o:   out arrayNport_regNlane;
	clock_tx:   out regNport;
	tx:         out regNport;
	lane_tx:    out arrayNport_regNlane;
	data_out:   out arrayNport_regflit;
	credit_i:   in  arrayNport_regNlane);
end RouterBR;

architecture RouterBR of RouterBR is

signal h, ack_h, data_av, data_ack, sender, free: arrayNport_regNlane := (others=>(others=>'0'));
signal aux_lane_tx, last_lane_tx: arrayNport_regNlane := (others=>(others=>'0'));
signal data: matrixNport_Nlane_regflit := (others=>(others=>(others=>'0')));
signal tableIn, tableOut: matrixNport_Nlane_reg8 := (others=>(others=>(others=>'0')));

begin
	lane_tx <= aux_lane_tx;

	-- EAST input port removed
	h(EAST)<=(others=>'0');
	data_av(EAST)<=(others=>'0');
	data(EAST)<=(others=>(others=>'0'));
	sender(EAST)<=(others=>'0');
	credit_o(EAST)<=(others=>'0');

	IP_WEST : Entity work.Hermes_inport(Hermes_inport)
	port map(
		clock => clock,
		reset => reset,
		clock_rx => clock_rx(WEST),
		rx => rx(WEST),
		lane_rx => lane_rx(WEST),
		data_in => data_in(WEST),
		credit_o => credit_o(WEST),
		h => h(WEST),
		ack_h => ack_h(WEST),
		data_av => data_av(WEST),
		data => data(WEST),
		data_ack => data_ack(WEST),
		sender=>sender(WEST));

	IP_NORTH : Entity work.Hermes_inport(Hermes_inport)
	port map(
		clock => clock,
		reset => reset,
		clock_rx => clock_rx(NORTH),
		rx => rx(NORTH),
		lane_rx => lane_rx(NORTH),
		data_in => data_in(NORTH),
		credit_o => credit_o(NORTH),
		h => h(NORTH),
		ack_h => ack_h(NORTH),
		data_av => data_av(NORTH),
		data => data(NORTH),
		data_ack => data_ack(NORTH),
		sender=>sender(NORTH));

	-- SOUTH input port removed
	h(SOUTH)<=(others=>'0');
	data_av(SOUTH)<=(others=>'0');
	data(SOUTH)<=(others=>(others=>'0'));
	sender(SOUTH)<=(others=>'0');
	credit_o(SOUTH)<=(others=>'0');

	IP_LOCAL : Entity work.Hermes_inport(Hermes_inport)
	port map(
		clock => clock,
		reset => reset,
		clock_rx => clock_rx(LOCAL),
		rx => rx(LOCAL),
		lane_rx => lane_rx(LOCAL),
		data_in => data_in(LOCAL),
		credit_o => credit_o(LOCAL),
		h => h(LOCAL),
		ack_h => ack_h(LOCAL),
		data_av => data_av(LOCAL),
		data => data(LOCAL),
		data_ack => data_ack(LOCAL),
		sender=>sender(LOCAL));

	SC : Entity work.Hermes_switchcontrol
	port map(
		clock => clock,
		reset => reset,
		h => h,
		ack_h => ack_h,
		address => address,
		data => data,
		sender => sender,
		free => free,
		mux_in => tableIn,
		mux_out => tableOut);

	-- EAST output port removed
	data_ack(EAST) <= (others=>'0');
	clock_tx(EAST) <= clock;
	tx(EAST) <= '0';
	aux_lane_tx(EAST) <= (others=>'0');
	data_out(EAST) <= (others=>'0');

	OP_WEST : Entity work.Hermes_outport(Hermes_outport_west)
	port map(
		clock => clock,
		reset => reset,
		data_av => data_av,
		data => data,
		data_ack => data_ack(WEST),
		free => free(WEST),
		all_lane_tx => aux_lane_tx,
		tableIn => tableIn(WEST),
		tableOut => tableOut(WEST),
		clock_tx => clock_tx(WEST),
		tx => tx(WEST),
		lane_tx => aux_lane_tx(WEST),
		data_out => data_out(WEST),
		credit_i => credit_i(WEST));

	OP_NORTH : Entity work.Hermes_outport(Hermes_outport_north)
	port map(
		clock => clock,
		reset => reset,
		data_av => data_av,
		data => data,
		data_ack => data_ack(NORTH),
		free => free(NORTH),
		all_lane_tx => aux_lane_tx,
		tableIn => tableIn(NORTH),
		tableOut => tableOut(NORTH),
		clock_tx => clock_tx(NORTH),
		tx => tx(NORTH),
		lane_tx => aux_lane_tx(NORTH),
		data_out => data_out(NORTH),
		credit_i => credit_i(NORTH));

	-- SOUTH output port removed
	data_ack(SOUTH) <= (others=>'0');
	clock_tx(SOUTH) <= clock;
	tx(SOUTH) <= '0';
	aux_lane_tx(SOUTH) <= (others=>'0');
	data_out(SOUTH) <= (others=>'0');

	OP_LOCAL : Entity work.Hermes_outport(Hermes_outport_local)
	port map(
		clock => clock,
		reset => reset,
		data_av => data_av,
		data => data,
		data_ack => data_ack(LOCAL),
		free => free(LOCAL),
		all_lane_tx => aux_lane_tx,
		tableIn => tableIn(LOCAL),
		tableOut => tableOut(LOCAL),
		clock_tx => clock_tx(LOCAL),
		tx => tx(LOCAL),
		lane_tx => aux_lane_tx(LOCAL),
		data_out => data_out(LOCAL),
		credit_i => credit_i(LOCAL));

end RouterBR;
