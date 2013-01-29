----
----	Interface:
----		
----		textin(in) : 	64 bits de entrada para chaves e dados
----
----		loadKey(in) : 	Carrega a chave a partir de textin e gera as
----						subchaves.(Como o tamanho da chave do Triple DES é 192bits (contando os bits descartados)
----						o hardware recebe a chave em 3 partes)
----
----		start(in)	: 	Se ready = 1, cifra o dado de textin
----
----
----		ready(out) : 	indica que o circuito ja gerou todas as subchaves e 
----						pode começar a processar entradas
----
----		textOut(out) : 	64 bits de saida para dados cifrados. Se não são validos retorna 'z's
----
----		valid(in) : 	Indica que a saida é válida.
----
-- 
-- 
-- 
-- 
--                            _________________
--                   clk --->|                 |
--                   rst --->|                 |
--                           |                 |                
--            textin ===/===>|                 |===/===> textOut
--                     64    |                 |  64
--                           |     TDES        |
--                           |                 |
--             start ------->|                 |-----> valid
--                           |                 |
--           loadkey ------->|                 |-----> ready
--                           |_________________|
--  
--
--

library IEEE;
use IEEE.std_logic_1164.all;

entity TDES is
	port(
		clk,rst,
		loadKey, start : in std_logic;
		textin: in std_logic_vector(1 to 64);
		valid, ready: out std_logic;
		textout: out std_logic_vector(1 to 64)
	);
end TDES;

---- MODO DE CRIPTOGRAFIA
architecture crypt of TDES is
	type auxiliar is array (1 to 3) of std_logic_vector(1 to 64);
	signal startDES, loadKeyDES, validDES, readyDES : std_logic_vector(1 to 3);
	signal data, inputDES, outputDES : auxiliar;
begin
FirstDES:
	entity work.DES(crypt)
		port map(
			clk => clk,
			rst => rst,
			start =>startDES(1),
			loadkey =>loadkeyDES(1),
			textin => inputDES(1),
			valid =>validDES(1),
			ready => readyDES(1),
			textOut => outputDES(1)
		);library IEEE;
		
SecondDES:
	entity work.DES(decrypt)
		port map(
			clk => clk,
			rst => rst,
			start =>startDES(2),
			loadkey =>loadkeyDES(2),
			textin => inputDES(2),
			valid =>validDES(2),
			ready => readyDES(2),
			textOut => outputDES(2)
		);

ThirdDES:
	entity work.DES(crypt)
		port map(
			clk => clk,
			rst => rst,
			start =>startDES(3),
			loadkey =>loadkeyDES(3),
			textin => inputDES(3),
			valid =>validDES(3),
			ready => readyDES(3),
			textOut => outputDES(3)
		);

keys:
		entity work.KeySchedule
		port map(
			clk => clk,
			rst => rst,
			loadkey => loadkey,
			strKey => loadkeyDES
		);
startDES(1) <= start;
inputDES(1) <= textin;
inputDES(2) <= textin when loadkeyDES(2) = '1' else  data(1);
inputDES(3) <= textin when loadkeyDES(3) = '1' else  data(2);	
ready <= readyDES(1) and readyDES(2) and readyDES(3);
valid <= validDES(3);
textOut <= outputDES(3);

barreiras:
process(clk)
	begin
		if(clk'event and clk = '1')then
			if(rst = '1')then
				data(1) <= (others=>'0');
				data(2) <= (others=>'0');
				startDES(2 to 3) <= "00";
			else
				startDES(2) <= validDES(1);
				startDES(3) <= validDES(2);
				data(1) <= outputDES(1);
				data(2) <=outputDES(2);
			end if;		
		end if;
	end process;

	
end crypt;


---- MODO DE DECRIPTOGRAFIA
architecture decrypt of TDES is
	type auxiliar is array (1 to 3) of std_logic_vector(1 to 64);
	signal startDES, loadKeyDES, validDES, readyDES : std_logic_vector(1 to 3);
	signal data, inputDES, outputDES : auxiliar;
begin
FirstDES:
	entity work.DES(decrypt)
		port map(
			clk => clk,
			rst => rst,
			start =>startDES(1),
			loadkey =>loadkeyDES(3),
			textin => inputDES(1),
			valid =>validDES(1),
			ready => readyDES(1),
			textOut => outputDES(1)
		);
		
SecondDES:
	entity work.DES(crypt)
		port map(
			clk => clk,
			rst => rst,
			start =>startDES(2),
			loadkey =>loadkeyDES(2),
			textin => inputDES(2),
			valid =>validDES(2),
			ready => readyDES(2),
			textOut => outputDES(2)
		);

ThirdDES:
	entity work.DES(decrypt)
		port map(
			clk => clk,
			rst => rst,
			start =>startDES(3),
			loadkey =>loadkeyDES(1),
			textin => inputDES(3),
			valid =>validDES(3),
			ready => readyDES(3),
			textOut => outputDES(3)
		);

keys:
		entity work.KeySchedule
		port map(
			clk => clk,
			rst => rst,
			loadkey => loadkey,
			strKey => loadkeyDES
		);
startDES(1) <= start;
inputDES(1) <= textin;
inputDES(2) <= textin when loadkeyDES(2) = '1' else  data(1);
inputDES(3) <= textin when loadkeyDES(1) = '1' else  data(2);	
ready <= readyDES(1) and readyDES(2) and readyDES(3);
valid <= validDES(3);
textOut <= outputDES(3);

barreiras:
process(clk)
	begin
		if(clk'event and clk = '1')then
			if(rst = '1')then
				data(1) <= (others=>'0');
				data(2) <= (others=>'0');
				startDES(2 to 3) <= "00";
			else
				startDES(2) <= validDES(1);
				startDES(3) <= validDES(2);
				data(1) <= outputDES(1);
				data(2) <=outputDES(2);
			end if;		
		end if;
	end process;





end decrypt;
