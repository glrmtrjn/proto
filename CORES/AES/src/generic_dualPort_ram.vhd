---------------------------------
-- Pode ser inferido em uma BRAM;
---------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity block_dual_memory is
	generic(	LARGURA_DATA : integer := 8; --Define o tamanho da palavra
				LARGURA_ADDR : integer := 8);  -- numero de palavras da mem: 2^LARGURA_ADDR 
	port (
		clk : in std_logic;
		we 	: in std_logic;
		addr: in std_logic_vector(LARGURA_ADDR-1 downto 0);
		addw: in std_logic_vector(LARGURA_ADDR-1 downto 0);
		di : in std_logic_vector(LARGURA_DATA-1 downto 0);
		do : out std_logic_vector(LARGURA_DATA-1 downto 0) 
	);
end block_dual_memory;
architecture mem of block_dual_memory is
	type ram_type is array ((2**LARGURA_ADDR)-1 downto 0) of std_logic_vector(LARGURA_DATA-1 downto 0);
	signal RAM : ram_type; --:= ( valores iniciais aqui )
begin
	do <= RAM(to_integer(unsigned(addr)));
process(clk)
begin
	if(clk'event and clk = '1')then
		if(we = '1')then
			RAM(to_integer(unsigned(addw))) <= di;
		end if;		
	end if;	
end process;
end architecture;
