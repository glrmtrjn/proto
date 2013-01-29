library IEEE;
use IEEE.std_logic_1164.all;

entity DES is
	port(
		clk,rst,
		loadKey, start : in std_logic;
		textin: in std_logic_vector(1 to 64);
		valid, ready: out std_logic;
		textout: out std_logic_vector(1 to 64)
	);
end DES;

---- MODO DE CRIPTOGRAFIA
architecture crypt of DES is
	type	auxiliar is array(0 to 16) of std_logic_vector(1 to 64);
	signal data : auxiliar; 
	signal keyIn : std_logic_vector(1 to 48);
	signal s,v, shift: std_logic_vector(0 to 16):=(others => '0');
	signal perKey : std_logic_vector(1 to 56);
	signal perText, entradaFinalPer, saidaFinalPer : std_logic_vector(1 to 64);
	signal keysDone : std_logic;	
	
begin
		
		KeyInitPermution:
			entity work.keyInitialPer
			port map(
				entrada =>textIn,
				saida => perKey
			);
			
	KeyExpansion: entity work.keyExpansion
		port map(
			clk => clk,
			rst => rst,
			loadKey => loadKey,
			chave => perKey,
			saida => keyIn,
			strKey => s(0),
			ready => KeysDone	
		);	

			
		DataInitialPermution:
			entity work.InitialPer
			port map(
				entrada =>textIn,
				saida => perText			
			);
		
		DataFinalPermution:
			entity work.FinalPer
			port map(
				entrada => entradaFinalper,
				saida => saidaFinalPer			
			);
			
		entradaFinalper <= data(16)(33 to 64) & data(16)(1 to 32);
		
		data(0) <= perText;
		
		v(0) <= start when keysDone = '1' else '0';
		ready <= keysDone;
		valid <= v(16);
				
		saida:
		textout <= saidaFinalPer when v(16) = '1'
					else (others=>'Z');
					
		rounds : 
		for i in 1 to 16 generate
		begin
			roundInst : entity work.round
			port map(
				clk => clk,
				rst => rst,
				strIn => s(i-1),
				vIn => v(i-1),
				textIn => data(i-1),
				keyIn => keyIn,
				strOut=> s(i),
				vOut => v(i),
				textOut => data(i)
			);
		end generate rounds;

end crypt;

---- MODO DE DECRIPTOGRAFIA
architecture decrypt of DES is


	type	auxiliar is array(0 to 16) of std_logic_vector(1 to 64);
	signal data : auxiliar; 
	signal keyIn : std_logic_vector(1 to 48);
	signal s,v, shift: std_logic_vector(0 to 16):=(others => '0');
	signal perKey : std_logic_vector(1 to 56);
	signal perText, entradaFinalPer, saidaFinalPer : std_logic_vector(1 to 64);
	signal keysDone : std_logic;	
	
begin
		
		KeyInitPermution:
			entity work.keyInitialPer
			port map(
				entrada =>textIn,
				saida => perKey
			);
			
	KeyExpansion: entity work.keyExpansion
		port map(
			clk => clk,
			rst => rst,
			loadKey => loadKey,
			chave => perKey,
			saida => keyIn,
			strKey => s(0),
			ready => KeysDone	
		);	

			
		DataInitialPermution:
			entity work.InitialPer
			port map(
				entrada =>textIn,
				saida => perText			
			);
		
		DataFinalPermution:
			entity work.FinalPer
			port map(
				entrada => entradaFinalper,
				saida => saidaFinalPer			
			);
		entradaFinalper <= data(16)(33 to 64) & data(16)(1 to 32);
		
		data(0) <= perText;
		
		v(0) <= start when keysDone = '1' else '0';
		ready <= keysDone;
		valid <= v(16);
				
		saida:
		textout <= saidaFinalPer when v(16) = '1'
					else (others=>'Z');
					
		rounds : 
		for i in 1 to 16 generate
		begin
			roundInst : entity work.round
			port map(
				clk => clk,
				rst => rst,
				strIn => s(16-i),
				vIn => v(i-1),
				textIn => data(i-1),
				keyIn => keyIn,
				strOut=> s(17-i),
				vOut => v(i),
				textOut => data(i)
			);
		end generate rounds;


end decrypt;
