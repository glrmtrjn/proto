library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-- Instancia n memorias de 8 bits, sendo n = LARGURA_DE_ENTRADA/8;
entity MEM_OUTPUT is
	generic(	LARGURA_DE_ENTRADA : integer := 128; --Define o tamanho da palavra de entrada (por favor, use multiplos de 8)
				PROFUNDIDADE : integer := 8);  -- numero de palavras da mem: 2^PROFUNDIDADE
	port (
		clk : in std_logic;
		rst : in std_logic;
		data_in : in std_logic_vector(LARGURA_DE_ENTRADA-1 downto 0);
		data_out : out std_logic_vector(7 downto 0);		
		get : in std_logic;
		send : in std_logic;
		mem_end: out std_logic
		);
end MEM_OUTPUT;
architecture mem of MEM_OUTPUT is
	constant	ULT_MEM : integer := (LARGURA_DE_ENTRADA / 8)-1; -- ULT_MEM é o indice da ultima memoria instanciada;
	constant	ULT_ADD : std_logic_vector(PROFUNDIDADE-1 downto 0) := (others=>'1');
	type	byte_arr is array(0 to ULT_MEM) of std_logic_vector(7 downto 0);
	signal	bmem_out : byte_arr;
	signal	we : std_logic;
	signal	RPointer : integer range  0 to ULT_MEM;
	signal	R_add, W_add : std_logic_vector(PROFUNDIDADE-1 downto 0);	
begin
MEM_INS:
for i in 0 to ULT_MEM generate
	mem_byte:
		entity work.block_dual_memory
		generic map ( PROFUNDIDADE => PROFUNDIDADE)
		port map (
					clk => clk,
					we => we,
					addr => R_add,
					addw => W_add,
					di => data_in((i*8)+7 downto i*8),
					do => bmem_out(i)
		);

end generate MEM_INS;
	mem_end <= '1' when (get = '1' and W_add = ULT_ADD) or (get = '0' and (R_add = ULT_ADD or R_add = W_add)) else '0';
	we <= '1' when (get = '1' and W_add <= ULT_ADD) else '0';
	data_out <= bmem_out(RPointer);
	


CONTROLE:
process(clk,rst)
begin
	if(rst = '1')then
		R_add <= (others=>'0');
		W_add <= (others=>'0');
		RPointer <= 0; --aponta a leitura para a primeira memória;

	elsif(clk'event and clk = '1')then
		if(get = '1')then	-- Escrita tem prioridade sobre a leitura;
			if( W_add < ULT_ADD)then
				W_add <= std_logic_vector(unsigned(W_add) + 1);
			end if;
		elsif(send = '1')then
			if( R_add <= ULT_ADD and R_add <= W_add)then
				if(RPointer < ULT_MEM)then --verifica se está no ultimo byte da palavra
					RPointer <= RPointer + 1; -- avança para o proximo byte da palavra;
				else
				  	R_add <= std_logic_vector(unsigned(R_add) + 1); -- se sim, vai para o proximo endereço;
					RPointer <= 0; -- e vai para o primeiro byte;
				end if;
			end if;
		end if;
	end if;
end process;
end architecture;
