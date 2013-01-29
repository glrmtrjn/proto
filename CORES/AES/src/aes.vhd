----	parametros:
----		NRO_DE_ROUNDS (int de 0 a 9): define o numero de rouns instanciados.
----		MODO_DE_OPERACAO (CRYPT ou DECRYPT) : define o modo de funcionamento.
----
----
----
----
----	Interface:
----		
----		textin(in) : 	128 bits de entrada para chave e dados
----
----		loadKey(in) : 	Carrega a chave a partir de textin e gera as
----						subchaves.
----		start(in)	: 	Se ready = 1, cifra o dado de textin
----
----
----		ready(out) : 	indica que o circuito ja gerou todas as subchaves e 
----						pode começar a processar entradas
----
----		textOut(out) : 	128 bits de saida para dados cifrados. Se não são validos retorna 'z's
----
----		valid(in) : 	Indica que a saida é válida.(é a entrada 'start' com 11 ciclos de clock de atraso)
----
----


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.P_AES.all;

entity AES is
	generic(
		NRO_DE_ROUNDS : integer := 0; -- Por equanto só 0, 3 e 9 implementados;
		MODO_DE_OPERACAO : string := "CRYPT;"
	);
	port(		
		clk, reset, loadKey, start : in std_logic;
		textin : in std_logic_vector(127 downto 0);
		textout : out std_logic_vector(127 downto 0);
		valid, ready : out std_logic
	);
end AES;


architecture Comp of AES is	
	type vetor_matriz is array(0 to 10) of matriz;
	signal keyin, matrizIn : matriz;
	signal KeysDone : std_logic;
begin

	matrizIn <= vector2matriz(textin);

	ke: entity work.keyExpansion
	port map(
		clk => clk,
		reset => reset,
		loadKey => loadKey,
		chave => matrizIn,
		saida => keyIn,
		ready => KeysDone	
	);
------------------------------------------------
--
---- IMPLEMENTACAO COM TAMANHO REDUZIDO
--		(Instancia cada função apenas uma vez; leva cerca de 40 ciclos para processar 128bits de dados)
------------------------------------------------	
AES_REDUZIDO:  
if (NRO_DE_ROUNDS = 0) generate
	type micro_instrucao is(GET, SEND, ADDRK, SUBBYTE, SHIFTROW, MIXCOLUMN);
	type ins_vetor is array(0 to 41) of micro_instrucao;	
	signal stateOut, saidaSubByte, saidaShiftRows, saidaMixCol, stateIn, saidaAddRK, key : matriz;
	signal we, store, run : std_logic;
	signal comando : micro_instrucao;	
	signal instrucao, micro_program : ins_vetor;
	signal index_key : integer range 0 to 10;
	signal di,do, WATCH_ME : std_logic_vector(127 downto 0);
	signal addr_key : std_logic_vector(3 downto 0);
begin
	comando <= instrucao(0);
	PROGRAM_CRYPT: if(MODO_DE_OPERACAO = "CRYPT") generate
		--Aqui so e definida a rotina de execucao
		--cada "micro-instrucao" define o que vai ser salvo no registrador state;
		micro_program <= 
			(GET,
			ADDRK,
			--Aqui começam as 9 iteracoes;
			SUBBYTE,
			SHIFTROW,
			MIXCOLUMN,
			ADDRK,

			SUBBYTE,
			SHIFTROW,
			MIXCOLUMN,
			ADDRK,

			SUBBYTE,
			SHIFTROW,
			MIXCOLUMN,
			ADDRK,

			SUBBYTE,
			SHIFTROW,
			MIXCOLUMN,
			ADDRK,

			SUBBYTE,
			SHIFTROW,
			MIXCOLUMN,
			ADDRK,

			SUBBYTE,
			SHIFTROW,
			MIXCOLUMN,
			ADDRK,

			SUBBYTE,
			SHIFTROW,
			MIXCOLUMN,
			ADDRK,

			SUBBYTE,
			SHIFTROW,
			MIXCOLUMN,
			ADDRK,

			SUBBYTE,
			SHIFTROW,
			MIXCOLUMN,
			ADDRK,
			--Aqui terminam as iteracoes

			SUBBYTE,
			SHIFTROW,
			ADDRK,
			SEND
		);
	end generate PROGRAM_CRYPT;

	PROGRAM_DECRYPT: if(MODO_DE_OPERACAO = "DECRYPT") generate
		--Aqui so e definida a rotina de execucao
		micro_program <= 
			(GET,
			ADDRK,
			--Aqui começa as 9 iteracoes;
			SHIFTROW,
			SUBBYTE,
			ADDRK,
			MIXCOLUMN,

			SHIFTROW,
			SUBBYTE,
			ADDRK,
			MIXCOLUMN,

			SHIFTROW,
			SUBBYTE,
			ADDRK,
			MIXCOLUMN,

			SHIFTROW,
			SUBBYTE,
			ADDRK,
			MIXCOLUMN,

			SHIFTROW,
			SUBBYTE,
			ADDRK,
			MIXCOLUMN,

			SHIFTROW,
			SUBBYTE,
			ADDRK,
			MIXCOLUMN,

			SHIFTROW,
			SUBBYTE,
			ADDRK,
			MIXCOLUMN,

			SHIFTROW,
			SUBBYTE,
			ADDRK,
			MIXCOLUMN,

			SHIFTROW,
			SUBBYTE,
			ADDRK,
			MIXCOLUMN,
			--Aqui terminam as iteracoes
			
			SHIFTROW,
			SUBBYTE,
			ADDRK,
			SEND
		);
	end generate PROGRAM_DECRYPT;


	



	sb : entity work.SubByte
		generic map(MODO_DE_OPERACAO => MODO_DE_OPERACAO)
		port map(
			entrada=>stateOut,
			saida=>saidaSubByte	
		);
		
	sr : entity work.shiftRow
		generic map(MODO_DE_OPERACAO => MODO_DE_OPERACAO)
		port map(
			entrada=>stateOut,
			saida=>saidaShiftRows	
		);
		
	mx : entity work.mixColumns
		generic map(MODO_DE_OPERACAO => MODO_DE_OPERACAO)
		port map(
			entrada=>stateOut,
			saida=>saidaMixCol	
		);
	
	ark : entity work.addRoundkey
		port map(
			entrada=>stateOut,
			chave=>key,
			saida=>saidaAddRK	
		);

	state : entity work.state
	port map(
		clk => clk,
		reset => reset,
		entrada => stateIn,
		saida=> stateOut,
		store=> '1'
	);
	-- para fins de simulação;
	WATCH_ME <= matriz2vector(stateOut);
	-- Conversão de tipos para a memória;
	di <= textin when index_key = 0 else matriz2vector(keyIn);
	key <= vector2matriz(do);
	addr_key <= std_logic_vector(to_unsigned(index_key, addr_key'length));

	keys : entity work.block_dual_memory
		generic map(LARGURA_DATA => 128,
				LARGURA_ADDR => 4)
		port map(
				clk => clk,
				we 	=> store,
				addr=> addr_key,
				addw=> addr_key,
				di => di,
				do => do
			);

	textout <= matriz2vector(stateOut) when comando = SEND else (others=>'Z');

	stateIn <= 	saidaSubByte when comando = SUBBYTE else
				saidaShiftRows when comando = SHIFTROW else
				saidaMixCol when comando = MIXCOLUMN else
				saidaAddRK when comando = ADDRK else
				matrizIn when	comando = GET else
				stateOut when comando = SEND;

	valid <='1' when comando = SEND else 
			'0';

	ready <= '1' when	KeysDone = '1' and comando = GET and run='0' and start = '0' else 
			'0';

	CONTROLE:
	process(clk,reset)
	begin
		if(reset = '1')then
		run <= '0'; 
		elsif(clk'event and clk = '1')then
			if(run = '1' and comando = SEND)then
				run <= '0';
			elsif(run = '0' and comando= GET and start = '1' and KeysDone ='1')then
				run <= '1';			
			end if;
		end if;		
	end process;

	INSTRUCOES:
	process(clk,reset)
	begin
		if(reset = '1' or loadKey = '1' or KeysDone = '0' )then
			instrucao <= micro_program;
		elsif(clk'event and clk='1')then
			if(run = '1' or (start = '1' and keysDone = '1' and comando = GET))then
				for i in 0 to 40 loop
					instrucao(i) <= instrucao(i+1);
				end loop;
				instrucao(41) <= instrucao(0);
			end if;
		end if;		
	end process;

	store <= we or loadKey;

	CHAVES:process(clk,reset) 
	begin
		if(reset = '1')then
			index_key <= 0;
			we <= '0';
		elsif(clk'event and clk='1')then
		--PREENCHE A MEMÓRIA;
			if(loadKey = '1')then -- começa a preencher a memória de chaves;
				-- Load key reseta as execução da rotina no process INSTRUCOES;
				index_key<= 0;
				we<='1';
			elsif (we = '1') then --preenchendo a memória de chaves
				if(index_key < 10 ) then
					index_key <= index_key + 1;
				else --chegou na ultima chave;
					we <= '0';
					if(MODO_DE_OPERACAO = "CRYPT")then
						index_key <= 0; -- zera o index, para ser usado agora na leitura;
					end if;	-- Como no modo DECRYPT as chaves são lidas da ultima para primeira, deixa o indice no 10
				end if;
		--LE A MEMÓRIA;
			elsif(comando=ADDRK) then
				if(MODO_DE_OPERACAO = "CRYPT")then
					if(index_key < 10 ) then
						index_key <= index_key + 1;
					else --chegou na ultima chave;
						index_key <= 0; -- zera o index, para ser usado agora na leitura;
					end if;
				else-- DECRYPT
					if(index_key > 0) then
						index_key <= index_key - 1;
					else --chegou na ultima chave;
						index_key <= 10; -- zera o index, para ser usado agora na leitura;
					end if;
				end if;
			end if;
		end if;
	end process;



end generate AES_REDUZIDO;

------------------------------------------------
--
---- IMPLEMENTACAO COM PIPELINE
--
------------------------------------------------
AES_PIPELINE:
If(NRO_DE_ROUNDS > 0 and NRO_DE_ROUNDS /= 3 )generate -- Por enquanto qualquer numero maior que 0 e diferente de 3 gera um pipeline de 10 estágios;
	signal v : std_logic_vector(0 to 10); -- canal de propagação da flag de validade de dado;
	signal data : vetor_matriz; -- canal de dados entre os rounds; 
	signal finalRoundOut : matriz;
	signal vi : std_logic; --Flag que indica que o dado que esta entrando no pipeline é para ser processado;
	signal key : vetor_matriz;
begin

		vi <= KeysDone and start; 


		initRound : entity work.initRound
			port map(
				clk => clk,
				reset => reset,
				valid => vi,
				entrada => matrizIn,
				chave => key(0),
				saida => data(0),
				ValidOut => v(0)
			
			);

		rounds : 
			for i in 1 to 9 generate
			begin
				roundInst : entity work.round
				generic map( MODO_DE_OPERACAO => MODO_DE_OPERACAO,	
							SAIDA_COM_REGISTRADOR => '1')
				port map(
					clk => clk,
					reset => reset,
					valid => v(i-1),
					entrada => data(i-1),
					chave=> key(i),
					saida=> data(i),
					ValidOut => v(i)

				);
			end generate rounds;

		finalRound : entity work.finalRound
			generic map( MODO_DE_OPERACAO => MODO_DE_OPERACAO,
						SAIDA_COM_REGISTRADOR => '1')

			port map(
				clk => clk,
				reset => reset,
				valid => v(9),
				entrada => data(9),
				chave=> key(10),
				saida=> finalRoundOut,
				ValidOut => v(10)
			);   

	ready <= KeysDone;		
	textout <= matriz2vector(finalRoundOut) when v(10)='1' else (others=>'Z');
	valid <= v(10);

	CHAVES:process(clk,reset) --Processo que preenche um vetor de chaves
			begin
				if(reset = '1')then
					for i in 0 to 9 loop
						key(i)<= vector2matriz(x"00000000000000000000000000000000");
					end loop ;
				elsif(clk'event and clk='1')then
					if(MODO_DE_OPERACAO = "CRYPT")then
						if (KeysDone = '0') then -- Enquanto as chaves estão sendo geradas vai preenchendo a lista de subchaves
							key(10)<= keyIn;
							for i in 0 to 9 loop
								key(i) <= key(i+1);
							end loop;	
						end if;
					elsif (MODO_DE_OPERACAO ="DECRYPT") then
						if(loadKey = '1')then
							key(0)<=matrizIn;
						elsif (KeysDone = '0') then
							key(0)<= keyin;
							for i in 1 to 10 loop
								key(i) <= key(i-1);
							end loop;			
						end if;
					end if;
				end if;
			end process;
end generate AES_PIPELINE;
------------------------------------------------
--
---- IMPLEMENTACAO COM PIPELINE DE 3 ESTAGIOS
--
------------------------------------------------

AES_PIPELINE_3_ESTAGIOS: -- cada barreira leva dados processados por 3 rounds;
If(NRO_DE_ROUNDS = 3 )generate -- Por enquanto qualquer numero maior que 0 gera um pipeline de 10 estágios;
	type barreira is 
		record 
			dado : matriz;
			v : std_logic;
	end record;
	type arr_barreira is array (0 to 3) of barreira;
	signal round_barr : arr_barreira;
	signal rnd_input, rnd_output : vetor_matriz; -- canal de dados entre os rounds; 
	signal finalRoundOut : matriz;
	signal vi : std_logic; --Flag que indica que o dado que esta entrando no pipeline é para ser processado;
	signal key : vetor_matriz;
begin

		vi <= KeysDone and start; 


		initRound : entity work.initRound
			generic map( SAIDA_COM_REGISTRADOR => '0' )
			port map(
				clk => clk,
				reset => reset,
				valid => '0',
				entrada => rnd_input(0),
				chave => key(0),
				saida => rnd_output(0),
				ValidOut => open
			
			);

		rounds : 
			for i in 1 to 9 generate
				roundInst : entity work.round
				generic map( MODO_DE_OPERACAO => MODO_DE_OPERACAO,	
							SAIDA_COM_REGISTRADOR => '0')
				port map(
					clk => clk,
					reset => reset,
					valid => '0',
					entrada => rnd_input(i),
					chave=> key(i),
					saida=> rnd_output(i),
					ValidOut => open

				);
			end generate rounds;

		finalRound : entity work.finalRound
			generic map( MODO_DE_OPERACAO => MODO_DE_OPERACAO,
						SAIDA_COM_REGISTRADOR => '0')

			port map(
				clk => clk,
				reset => reset,
				valid => '0',
				entrada => rnd_input(10),
				chave=> key(10),
				saida=> rnd_output(10),
				ValidOut => open 
			);   

	ready <= KeysDone; -- rever isso aqui!!!
	textout <= matriz2vector(rnd_output(10)) when round_barr(3).v ='1' else (others=>'Z');
	valid <= round_barr(3).v;

	-----
	rnd_input(0) <= matrizIn;
	rnd_input(1) <= round_barr(0).dado;
	rnd_input(2) <= rnd_output(1);
	rnd_input(3) <= rnd_output(2);
	rnd_input(4) <= round_barr(1).dado;
	rnd_input(5) <= rnd_output(4);
	rnd_input(6) <= rnd_output(5);
	rnd_input(7) <= round_barr(2).dado;
	rnd_input(8) <= rnd_output(7);
	rnd_input(9) <= rnd_output(8);
	rnd_input(10) <= round_barr(3).dado;

	-----

	BARREIRAS:process(clk,reset)
		begin
		if(reset = '1')then
			round_barr(0)<=(v=> '0',dado=>vector2matriz(x"00000000000000000000000000000000"));
			round_barr(1)<=(v=> '0',dado=>vector2matriz(x"00000000000000000000000000000000"));
			round_barr(2)<=(v=> '0',dado=>vector2matriz(x"00000000000000000000000000000000"));
			round_barr(3)<=(v=> '0',dado=>vector2matriz(x"00000000000000000000000000000000"));
		elsif(clk'event and clk='1')then
			round_barr(0)<=(rnd_output(0), vi);
			round_barr(1).dado <= rnd_output(3);
			round_barr(2).dado <= rnd_output(6);
			round_barr(3).dado <= rnd_output(9);
			for i in 1 to 3 loop
				round_barr(i).v <= round_barr(i-1).v;
			end loop;

		end if;
	end process;


	CHAVES:process(clk,reset) --Processo que preenche um vetor de chaves
			begin
				if(reset = '1')then
					for i in 0 to 9 loop
						key(i)<= vector2matriz(x"00000000000000000000000000000000");
					end loop ;
				elsif(clk'event and clk='1')then
					if(MODO_DE_OPERACAO = "CRYPT")then
						if (KeysDone = '0') then -- Enquanto as chaves estão sendo geradas vai preenchendo a lista de subchaves
							key(10)<= keyIn;
							for i in 0 to 9 loop
								key(i) <= key(i+1);
							end loop;	
						end if;
					elsif (MODO_DE_OPERACAO ="DECRYPT") then
						if (KeysDone = '0') then
							key(0)<= keyin;
							for i in 1 to 10 loop
								key(i) <= key(i-1);
							end loop;			
						end if;
					end if;
				end if;
			end process;

end generate AES_PIPELINE_3_ESTAGIOS;


end comp;


