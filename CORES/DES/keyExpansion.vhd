library IEEE;
use IEEE.std_logic_1164.all;

entity keyExpansion is
	port(
		clk,rst, loadKey : in std_logic; 
		chave : in std_logic_vector(1 to 56);
		saida : out std_logic_vector(1 to 48);
		strKey, ready  : out std_logic
	);
end keyExpansion;

architecture crypt of keyExpansion is
	signal key, entradaComp: std_logic_vector(1 to 56);	
	signal round : integer range 0 to 16:=0;
	signal shift : std_logic;
begin

	shift <= '0' when round =  1 or round =  2 or round =  9 or round = 16 else '1';
	
	Shiftbox: entity work.shift
	port map(
		entrada => key,
		passo => shift,
		saida => entradaComp
	);


	comp: entity work.CompressionPer
	port map(
		entrada => entradaComp,
		saida=> saida
	);
	

process(clk)
	begin
		if(clk'event and clk = '1')then
			if(rst = '1')then
				key	<= (others=>'0');
				round <= 0;
				strKey <= '0';
				ready <= '0';
			else
				strKey <= loadkey;
				if(loadKey = '1')then
					key <= chave;					
					round <= 1;
					ready <= '0';
				elsif (round > 0) then
					key <=	entradaComp;
					if(round < 16)then
						round <= round +1;
					else
						ready <= '1';	
					end if;	
			
		end if;
			end if;	
		end if;
	end process;
	
end crypt;
