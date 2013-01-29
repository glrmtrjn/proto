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
--  Os roteadores realizam a transferência de mensagens entre núcleos.
--  O roteador possui uma lógica de controle de chaveamento e 5 portas bidirecionais:
--  East, West, North, South e Local. Cada porta possui dois canais virtuais, cada
--  um com uma fila para o armazenamento temporário de flits. A porta Local estabelece
--  a comunicação entre o roteador e seu núcleo. As demais portas ligam o roteador aos
--  roteadores vizinhos.
--  Os endereços dos roteadores são compostos pelas coordenadas XY da rede de
--  interconexão, onde X é a posição horizontal e Y a posição vertical. A atribuição de
--  endereços aos roteadores é necessária para a execução do algoritmo de chaveamento.
--  Os módulos que compõem o roteador são: Hermes_buffer (porta de entrada e filas),
--  Hermes_switchcontrol (arbitragem e roteamento) e Hermes_outport (porta de saída).
--  Cada uma das filas do roteador, ao receber um novo pacote requisita chaveamento ao
--  árbitro. O árbitro seleciona a requisição de maior prioridade, quando existem
--  requisições simultâneas, e encaminha o pedido à lógica de chaveamento. A lógica de
--  chaveamento verifica se é possível atender à solicitação. Sendo possível, a conexão
--  é estabelecida e a fila começa a enviar os flits armazenados. Quando todos os flits
--  do pacote são enviados, a fila sinaliza através do sinal sender que a conexão deve
--  ser finalizada.
---------------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;
use work.HermesPackage.all;

entity RouterTR is
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
end RouterTR;

architecture RouterTR of RouterTR is

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

	-- NORTH input port removed
	h(NORTH)<=(others=>'0');
	data_av(NORTH)<=(others=>'0');
	data(NORTH)<=(others=>(others=>'0'));
	sender(NORTH)<=(others=>'0');
	credit_o(NORTH)<=(others=>'0');

	IP_SOUTH : Entity work.Hermes_inport(Hermes_inport)
	port map(
		clock => clock,
		reset => reset,
		clock_rx => clock_rx(SOUTH),
		rx => rx(SOUTH),
		lane_rx => lane_rx(SOUTH),
		data_in => data_in(SOUTH),
		credit_o => credit_o(SOUTH),
		h => h(SOUTH),
		ack_h => ack_h(SOUTH),
		data_av => data_av(SOUTH),
		data => data(SOUTH),
		data_ack => data_ack(SOUTH),
		sender=>sender(SOUTH));

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

	-- NORTH output port removed
	data_ack(NORTH) <= (others=>'0');
	clock_tx(NORTH) <= clock;
	tx(NORTH) <= '0';
	aux_lane_tx(NORTH) <= (others=>'0');
	data_out(NORTH) <= (others=>'0');

	OP_SOUTH : Entity work.Hermes_outport(Hermes_outport_south)
	port map(
		clock => clock,
		reset => reset,
		data_av => data_av,
		data => data,
		data_ack => data_ack(SOUTH),
		free => free(SOUTH),
		all_lane_tx => aux_lane_tx,
		tableIn => tableIn(SOUTH),
		tableOut => tableOut(SOUTH),
		clock_tx => clock_tx(SOUTH),
		tx => tx(SOUTH),
		lane_tx => aux_lane_tx(SOUTH),
		data_out => data_out(SOUTH),
		credit_i => credit_i(SOUTH));

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

end RouterTR;
