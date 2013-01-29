library IEEE;
use IEEE.std_logic_1164.all;

entity TOP_TEST is
generic(
        LARGURA_CORE : Integer := 128; --Padrao para o  AES
        PROFUNDIDADE : integer := 8 -- Quantidade de palavras a serem processadas
    );
port(
    clk:    in  std_logic;                        
    rst:    in  std_logic;                        
    rx_data:      inout std_logic_vector(7 downto 0);                          
    tx_data:      inout std_logic_vector(7 downto 0);
    tx_av:    inout std_logic;
    rx_start:inout  std_logic;
    rx_busy:  inout std_logic
  );
end TOP_test;
architecture arch of TOP_test is
    signal  core_rst, core_start, core_valid, core_ready, core_loadKey, 
            in_rst, in_get, in_send, in_end,
            out_rst, out_get, out_send, out_end
            : std_logic;
    signal  out_data, in_data : std_logic_vector(7 downto 0);
    signal  textin, textout : std_logic_vector(LARGURA_CORE - 1 downto 0);




begin

CORE: entity work.AES
port map(
    clk => clk,
    reset => core_rst,
    loadKey => core_loadKey,
    start => core_start,
    textin => textin,
    textout => textout,
    valid => core_valid,
    ready => core_ready
    );



--Interface: entity work.serialinterface
--port map(
--    clock => clk,
--    reset => rst,
 --   rxd => rxd,
 --   txd => txd,
--    rx_start => rx_start,
--    rx_data => rx_data,
--    rx_busy => rx_busy,
--    tx_av => tx_av,
--   tx_data => tx_data
--);

MEM_INPUT: entity work.MEM_INPUT
generic map(
	LARGURA_DE_SAIDA => LARGURA_CORE,
	PROFUNDIDADE => PROFUNDIDADE
)
port map(
    clk => clk, 
    rst => in_rst,
    data_in => in_data,--8bits
    data_out => textin, --128bits
    get => in_get,
    send => in_send,
    mem_end => in_end
    );

MEM_OUTPUT: entity work.MEM_OUTPUT
generic map(
	LARGURA_DE_ENTRADA => LARGURA_CORE,
	PROFUNDIDADE => PROFUNDIDADE
)
port map(
    clk => clk,
    rst => out_rst,
    data_in => textout, --128bits
    data_out =>out_data, --8bits
    get => out_get,
    send => out_send,
    mem_end => out_end
    );

CONTROL: entity work.CONTROL
generic map(
	LARGURA_CORE => LARGURA_CORE,
	PROFUNDIDADE => PROFUNDIDADE
)
port map(
    clk => clk,
    rst => rst,

    -- Interface com  Serial
    rx_start => rx_start,
    rx_data => rx_data,
    rx_busy => rx_busy,
    tx_av => tx_av,
    tx_data => tx_data,

    -- Interface com a Memória de Entrada
    in_data => in_data,
    in_get => in_get,
    in_send => in_send,
    in_rst => in_rst,
    in_end => in_end,

    -- Interface com a Memória de Saída
    out_data => out_data,
    out_get => out_get,
    out_send => out_send,
    out_rst => out_rst,
    out_end => out_end,

    -- Interface com o Core
    core_loadKey => core_loadKey,
    core_ready => core_ready,
    core_start => core_start,
    core_valid => core_valid,
    core_rst => core_rst
    ); 

end architecture ;
