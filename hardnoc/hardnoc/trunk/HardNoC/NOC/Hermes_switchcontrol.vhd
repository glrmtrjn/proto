library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_unsigned.all;
use IEEE.std_logic_arith.all;
use work.HermesPackage.all;

entity Hermes_switchcontrol is
port(
	clock :   in  std_logic;
	reset :   in  std_logic;
	h :       in  arrayNport_regNlane;
	ack_h :   out arrayNport_regNlane;
	address : in  regmetadeflit;
	data :    in  matrixNport_Nlane_regflit;
	sender :  in  arrayNport_regNlane;
	free :    out arrayNport_regNlane;
	mux_in :  out matrixNport_Nlane_reg8;
	mux_out : out matrixNport_Nlane_reg8);
end Hermes_switchcontrol;

architecture Hermes_switchcontrol of Hermes_switchcontrol is

type state is (S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10);
signal ES, PES: state;

-- arbitrator signals
signal ask: std_logic := '0';
signal sel,prox: integer range 0 to (NPORT-1) := 0;
signal sel_lane: integer range 0 to (NLANE-1) := 0;
signal header : regflit := (others=>'0');

-- control signals
signal dirx,diry: integer range 0 to (NPORT-1) := 0;
signal lx,ly,tx,ty: regquartoflit := (others=>'0');
signal auxfree: arrayNport_regNlane := (others=>(others=>'0'));
signal source: matrixNport_Nlane_reg8 := (others=>(others=>(others=>'0')));
signal sender_ant: arrayNport_regNlane := (others=>(others=>'0'));

begin

	ask <= '1' when h(LOCAL)(L1)='1' or h(LOCAL)(L2)='1' or
					h(EAST)(L1)='1'  or h(EAST)(L2)='1'  or
					h(WEST)(L1)='1'  or h(WEST)(L2)='1'  or
					h(NORTH)(L1)='1' or h(NORTH)(L2)='1' or
					h(SOUTH)(L1)='1' or h(SOUTH)(L2)='1' else '0';

	header <= data(sel)(sel_lane);

	process(sel,h)
	begin
		case sel is
			when LOCAL=>
				if h(EAST)/="00" then prox<=EAST;
				elsif h(WEST)/="00" then prox<=WEST;
				elsif h(NORTH)/="00" then prox<=NORTH;
				elsif h(SOUTH)/="00" then prox<=SOUTH;
				else prox<=LOCAL; end if;
			when EAST=>
				if h(WEST)/="00" then prox<=WEST;
				elsif h(NORTH)/="00" then prox<=NORTH;
				elsif h(SOUTH)/="00" then prox<=SOUTH;
				elsif h(LOCAL)/="00" then prox<=LOCAL;
				else prox<=EAST; end if;
			when WEST=>
				if h(NORTH)/="00" then prox<=NORTH;
				elsif h(SOUTH)/="00" then prox<=SOUTH;
				elsif h(LOCAL)/="00" then prox<=LOCAL;
				elsif h(EAST)/="00" then prox<=EAST;
				else prox<=WEST; end if;
			when NORTH=>
				if h(SOUTH)/="00" then prox<=SOUTH;
				elsif h(LOCAL)/="00" then prox<=LOCAL;
				elsif h(EAST)/="00" then prox<=EAST;
				elsif h(WEST)/="00" then prox<=WEST;
				else prox<=NORTH; end if;
			when SOUTH=>
				if h(LOCAL)/="00" then prox<=LOCAL;
				elsif h(EAST)/="00" then prox<=EAST;
				elsif h(WEST)/="00" then prox<=WEST;
				elsif h(NORTH)/="00" then prox<=NORTH;
				else prox<=SOUTH; end if;
		end case;
	end process;

	lx <= address((METADEFLIT - 1) downto QUARTOFLIT);
	ly <= address((QUARTOFLIT - 1) downto 0);

	tx <= header((METADEFLIT - 1) downto QUARTOFLIT);
	ty <= header((QUARTOFLIT - 1) downto 0);

	dirx <= WEST when lx > tx else EAST;
	diry <= NORTH when ly < ty else SOUTH;

	process(reset,clock)
	begin
		if reset='1' then
			ES<=S0;
		elsif clock'event and clock='0' then
			ES<=PES;
		end if;
	end process;

	------------------------------------------------------------------------------------------------------
	-- PARTE COMBINACIONAL PARA DEFINIR O PRÓXIMO ESTADO DA MÁQUINA.
	--
	-- SO -> O estado S0 é o estado de inicialização da máquina. Este estado somente é
	--       atingido quando o sinal reset é ativado.
	-- S1 -> O estado S1 é o estado de espera por requisição de chaveamento. Quando o
	--       árbitro recebe uma ou mais requisições o sinal ask é ativado fazendo a
	--       máquina avançar para o estado S2.
	-- S2 -> No estado S2 a porta de entrada que solicitou chaveamento é selecionada. Se
	--       houver mais de uma, aquela com maior prioridade é a selecionada.
	-- S3 -> No estado S3 é realizado algoritmo de chaveamento XY. O algoritmo de chaveamento
	--       XY faz a comparação do endereço da chave atual com o endereço da chave destino do
	--       pacote (armazenado no primeiro flit do pacote). O pacote deve ser chaveado para a
	--       porta Local da chave quando o endereço xLyL* da chave atual for igual ao endereço
	--       xTyT* da chave destino do pacote. Caso contrário, é realizada, primeiramente, a
	--       comparação horizontal de endereços. A comparação horizontal determina se o pacote
	--       deve ser chaveado para o Leste (xL<xT), para o Oeste (xL>xT), ou se o mesmo já
	--       está horizontalmente alinhado à chave destino (xL=xT). Caso esta última condição
	--       seja verdadeira é realizada a comparação vertical que determina se o pacote deve
	--       ser chaveado para o Sul (yL<yT) ou para o Norte (yL>yT). Caso a porta vertical
	--       escolhida esteja ocupada, é realizado o bloqueio dos flits do pacote até que o
	--       pacote possa ser chaveado.
	-- statesConnection-> Nestes estados é estabelecida a conexão da porta de entrada com a de
	--       de saída através do preenchimento dos sinais mux_in e mux_out.
	-- S9 -> O estado S9 é necessário para que a porta selecionada para roteamento baixe o sinal
	--       h.
	--
	process(ES,ask,h,lx,ly,tx,ty,auxfree,dirx,diry)
	begin
		case ES is
			when S0 => PES <= S1;
			when S1 => if ask='1' then PES <= S2; else PES <= S1; end if;
			when S2 => PES <= S3;
			when S3 =>
				if lx = tx and ly = ty and auxfree(LOCAL)(L1)='1' then PES<=S4;
				elsif lx = tx and ly = ty and auxfree(LOCAL)(L2)='1' then PES<=S5;
				elsif lx /= tx and auxfree(dirx)(L1)='1' then PES<=S6;
				elsif lx /= tx and auxfree(dirx)(L2)='1' then PES<=S7;
				elsif lx = tx and ly /= ty and auxfree(diry)(L1)='1' then PES<=S8;
				elsif lx = tx and ly /= ty and auxfree(diry)(L2)='1' then PES<=S9;
				else PES<=S1; end if;
			when S10 => PES<=S1;
			when others => PES<=S10;
		end case;
	end process;

	------------------------------------------------------------------------------------------------------
	-- executa as ações correspondente ao estado atual da máquina de estados
	------------------------------------------------------------------------------------------------------
	process (clock)
	begin
		if clock'event and clock='1' then
		case ES is
			-- Zera variáveis
			when S0 =>
				sel <= 0;
				sel_lane <= 0;
				ack_h <= (others => (others=>'0'));
				auxfree <= (others => (others=>'1'));
				auxfree(LOCAL)(L2) <= '0';
				sender_ant <= (others => (others=>'0'));
				mux_out <= (others=>(others=>(others=>'0')));
				source <= (others=>(others=>(others=>'0')));
			-- Chegou um header
			when S1=>
				ack_h <= (others => (others=>'0'));
			-- Seleciona quem tera direito a requisitar roteamento
			when S2=>
				sel <= prox;
				if h(prox)(L1)='1' then sel_lane <= L1;
				else sel_lane <= L2; end if;
			-- Estabelece a conexão com o canal L1 da porta LOCAL
			when S4 =>
				source(sel)(sel_lane) <= CONV_STD_LOGIC_VECTOR(LOCAL,4) & CONV_STD_LOGIC_VECTOR(L1,4);
				mux_out(LOCAL)(L1) <= CONV_STD_LOGIC_VECTOR(sel,4) & CONV_STD_LOGIC_VECTOR(sel_lane,4);
				auxfree(LOCAL)(L1) <= '0';
				ack_h(sel)(sel_lane)<='1';
			-- Estabelece a conexão com o canal L2 da porta LOCAL
			when S5 =>
				source(sel)(sel_lane) <= CONV_STD_LOGIC_VECTOR(LOCAL,4) & CONV_STD_LOGIC_VECTOR(L2,4);
				mux_out(LOCAL)(L2) <= CONV_STD_LOGIC_VECTOR(sel,4) & CONV_STD_LOGIC_VECTOR(sel_lane,4);
				auxfree(LOCAL)(L2) <= '0';
				ack_h(sel)(sel_lane)<='1';
			-- Estabelece a conexão com o canal L1 da porta EAST ou WEST
			when S6 =>
				source(sel)(sel_lane) <= CONV_STD_LOGIC_VECTOR(dirx,4) & CONV_STD_LOGIC_VECTOR(L1,4);
				mux_out(dirx)(L1) <= CONV_STD_LOGIC_VECTOR(sel,4) & CONV_STD_LOGIC_VECTOR(sel_lane,4);
				auxfree(dirx)(L1) <= '0';
				ack_h(sel)(sel_lane)<='1';
			-- Estabelece a conexão com o canal L2 da porta EAST ou WEST
			when S7 =>
				source(sel)(sel_lane) <= CONV_STD_LOGIC_VECTOR(dirx,4) & CONV_STD_LOGIC_VECTOR(L2,4);
				mux_out(dirx)(L2) <= CONV_STD_LOGIC_VECTOR(sel,4) & CONV_STD_LOGIC_VECTOR(sel_lane,4);
				auxfree(dirx)(L2) <= '0';
				ack_h(sel)(sel_lane)<='1';
			-- Estabelece a conexão com o canal L1 da porta NORTH ou SOUTH
			when S8 =>
				source(sel)(sel_lane) <= CONV_STD_LOGIC_VECTOR(diry,4) & CONV_STD_LOGIC_VECTOR(L1,4);
				mux_out(diry)(L1) <= CONV_STD_LOGIC_VECTOR(sel,4) & CONV_STD_LOGIC_VECTOR(sel_lane,4);
				auxfree(diry)(L1) <= '0';
				ack_h(sel)(sel_lane)<='1';
			-- Estabelece a conexão com o canal L2 da porta NORTH ou SOUTH
			when S9 =>
				source(sel)(sel_lane) <= CONV_STD_LOGIC_VECTOR(diry,4) & CONV_STD_LOGIC_VECTOR(L2,4);
				mux_out(diry)(L2) <= CONV_STD_LOGIC_VECTOR(sel,4) & CONV_STD_LOGIC_VECTOR(sel_lane,4);
				auxfree(diry)(L2) <= '0';
				ack_h(sel)(sel_lane)<='1';
			when others => ack_h(sel)(sel_lane)<='0';
		end case;

		sender_ant(LOCAL)(L1) <= sender(LOCAL)(L1);
		sender_ant(LOCAL)(L2) <= sender(LOCAL)(L2);
		sender_ant(EAST)(L1)  <= sender(EAST)(L1);
		sender_ant(EAST)(L2)  <= sender(EAST)(L2);
		sender_ant(WEST)(L1)  <= sender(WEST)(L1);
		sender_ant(WEST)(L2)  <= sender(WEST)(L2);
		sender_ant(NORTH)(L1) <= sender(NORTH)(L1);
		sender_ant(NORTH)(L2) <= sender(NORTH)(L2);
		sender_ant(SOUTH)(L1) <= sender(SOUTH)(L1);
		sender_ant(SOUTH)(L2) <= sender(SOUTH)(L2);

		if sender(LOCAL)(L1)='0' and sender_ant(LOCAL)(L1)='1' then auxfree(CONV_INTEGER(source(LOCAL)(L1)(7 downto 4)))(CONV_INTEGER(source(LOCAL)(L1)(3 downto 0))) <='1'; end if;
		if sender(LOCAL)(L2)='0' and sender_ant(LOCAL)(L2)='1' then auxfree(CONV_INTEGER(source(LOCAL)(L2)(7 downto 4)))(CONV_INTEGER(source(LOCAL)(L2)(3 downto 0))) <='1'; end if;
		if sender(EAST)(L1) ='0' and sender_ant(EAST)(L1) ='1' then auxfree(CONV_INTEGER(source(EAST)(L1)(7 downto 4)))(CONV_INTEGER(source(EAST)(L1)(3 downto 0)))   <='1'; end if;
		if sender(EAST)(L2) ='0' and sender_ant(EAST)(L2) ='1' then auxfree(CONV_INTEGER(source(EAST)(L2)(7 downto 4)))(CONV_INTEGER(source(EAST)(L2)(3 downto 0)))   <='1'; end if;
		if sender(WEST)(L1) ='0' and sender_ant(WEST)(L1) ='1' then auxfree(CONV_INTEGER(source(WEST)(L1)(7 downto 4)))(CONV_INTEGER(source(WEST)(L1)(3 downto 0)))   <='1'; end if;
		if sender(WEST)(L2) ='0' and sender_ant(WEST)(L2) ='1' then auxfree(CONV_INTEGER(source(WEST)(L2)(7 downto 4)))(CONV_INTEGER(source(WEST)(L2)(3 downto 0)))   <='1'; end if;
		if sender(NORTH)(L1)='0' and sender_ant(NORTH)(L1)='1' then auxfree(CONV_INTEGER(source(NORTH)(L1)(7 downto 4)))(CONV_INTEGER(source(NORTH)(L1)(3 downto 0))) <='1'; end if;
		if sender(NORTH)(L2)='0' and sender_ant(NORTH)(L2)='1' then auxfree(CONV_INTEGER(source(NORTH)(L2)(7 downto 4)))(CONV_INTEGER(source(NORTH)(L2)(3 downto 0))) <='1'; end if;
		if sender(SOUTH)(L1)='0' and sender_ant(SOUTH)(L1)='1' then auxfree(CONV_INTEGER(source(SOUTH)(L1)(7 downto 4)))(CONV_INTEGER(source(SOUTH)(L1)(3 downto 0))) <='1'; end if;
		if sender(SOUTH)(L2)='0' and sender_ant(SOUTH)(L2)='1' then auxfree(CONV_INTEGER(source(SOUTH)(L2)(7 downto 4)))(CONV_INTEGER(source(SOUTH)(L2)(3 downto 0))) <='1'; end if;
		end if;
	end process;

	mux_in <= source;
	free <= auxfree;

end Hermes_switchcontrol;
