library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-- Instancia 'n' memorias de 8 bits, sendo n = (LARGURA_DE_SAIDA/8);
entity MEM_INPUT is
	generic(	LARGURA_DE_SAIDA : integer := 128; --Define o tamanho da palavra de saida (use multiplos de 8)
				PROFUNDIDADE : integer := 8);  -- tamanho do endereço (numero de palavras da mem: 2^PROFUNDIDADE)
	port (
		clk : in std_logic;
		rst : in std_logic;
		data_in : in std_logic_vector(7 downto 0);
		data_out : out std_logic_vector(LARGURA_DE_SAIDA-1 downto 0);
		get : in std_logic; --grava o conteudo de data_in nas memórias;
		send : in std_logic; --avança para o proximo dado na memória;
		mem_end: out std_logic --sinaliza o fim da memória;
		);
end MEM_INPUT;
architecture mem of MEM_INPUT is
	constant	ULT_MEM : integer := (LARGURA_DE_SAIDA / 8)-1; -- ULT_MEM é o indice da ultima memoria instanciada;
	constant	ULT_ADD : std_logic_vector(PROFUNDIDADE-1 downto 0) := (others=>'1');
	signal	we, wPointer : std_logic_vector(ULT_MEM downto 0);
	signal	R_add, W_add : std_logic_vector(PROFUNDIDADE-1 downto 0);	
begin
MEM_INS:
for i in 0 to ULT_MEM generate
	mem_byte:
		entity work.block_dual_memory
		generic map ( PROFUNDIDADE => PROFUNDIDADE)
		port map (
					clk => clk,
					we => we(i),
					addr => R_add,
					addw => W_add,
					di => data_in,
					do => data_out((i*8)+7 downto i*8)
		);

end generate MEM_INS;
	mem_end <= '1' when (get = '1' and W_add = ULT_ADD) or (get = '0' and (R_add = ULT_ADD or R_add = W_add)) else '0';
	we <= wPointer when get = '1' else (others => '0');

CONTROLE:
process(clk,rst)
begin
	if(rst = '1')then
		R_add <= (others=>'0');
		W_add <= (others=>'0');
		--wPointer <= (0=>'1', others => '0'); --aponta a escrita para a primeira memória;
		wPointer(0) <= '1'; -- Cadence não aceita a linha acima;
		for i in 1 to ULT_MEM loop
			wPointer(i) <= '0';
		end loop;

	elsif(clk'event and clk = '1')then
		if(get = '1')then	-- Escrita tem prioridade sobre a leitura;
			wPointer(0) <= wPointer(ULT_MEM); -- reveza o sinal de we das memorias(apenas uma é escrita por vez)
			for i in 1 to ULT_MEM loop
				wPointer(i) <= wPointer(i-1);
			end loop;
			if(wPointer(ULT_MEM) = '1')then -- verifica se chegou no ultimo byte da palavra;
				if( W_add <= ULT_ADD)then -- testa se não é o ultimo endereço;
					W_add <= std_logic_vector(unsigned(W_add) + 1); --passa para novo endereço;
				end if;
			end if;
		elsif(send = '1')then
			if( R_add <= ULT_ADD and R_add <= W_add)then
				R_add <= std_logic_vector(unsigned(R_add) + 1);
			end if;
		end if;
	end if;
end process;
end architecture;
