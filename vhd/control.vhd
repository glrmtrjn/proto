library IEEE;
use IEEE.std_logic_1164.all;

entity CONTROL is
generic(
        LARGURA_CORE : Integer := 128;
        PROFUNDIDADE : integer := 8;

        -- Instruction codes:
        CLEAR_DATA : std_logic_vector(7 downto 0) := x"00";
        LOAD_KEY : std_logic_vector(7 downto 0) := x"01";
        LOAD_DATA : std_logic_vector(7 downto 0) := x"02";
        PROCESS_DATA : std_logic_vector(7 downto 0) := x"03"; 
        DUMP_DATA : std_logic_vector(7 downto 0) := x"04";
        NOP : std_logic_vector(7 downto 0) := x"05";

        --Status messages:
        waiting_core : std_logic_vector(7 downto 0) := x"00";
        Loading_key : std_logic_vector(7 downto 0) := x"01";
        processing_data : std_logic_vector(7 downto 0) := x"02";
        idle : std_logic_vector(7 downto 0) := x"03";

        --Error Flags:
        NO_ERRORS_FOUND : std_logic_vector(7 downto 0) := x"00";
        ERROR_FOUND :   std_logic_vector(7 downto 0) := x"FF";

        --Error Codes:
        END_OF_READ_MEMORY : std_logic_vector(7 downto 0) := x"01";
        END_OF_WRITE_MEMORY : std_logic_vector(7 downto 0) := x"02";
        NO_KEY_LOADED : std_logic_vector(7 downto 0) := x"03"
     );
port(
    clk : in std_logic;
    rst : in std_logic;

    -- Interface com  Serial
    rx_start : out std_logic;
    rx_data : out std_logic_vector(7 downto 0);
    rx_busy : in std_logic;
    tx_av : in std_logic;
    tx_data : in std_logic_vector(7 downto 0);

    -- Interface com a Memória de Entrada
    in_data : out std_logic_vector(7 downto 0);
    in_get : out std_logic;
    in_send : out std_logic;
    in_rst : out std_logic;
    in_end : in std_logic;

    -- Interface com a Memória de Saída
    out_data : in std_logic_vector(7 downto 0);
    out_get : out std_logic;
    out_send : out std_logic;
    out_rst : out std_logic;
    out_end : in std_logic;

    -- Interface com o Core
    core_loadKey : out std_logic;
    core_ready : in std_logic;
    core_start : out std_logic;
    core_valid : in std_logic;
    core_rst : std_logic);
end CONTROL;
architecture arch of CONTROL is
    type    array_4_bytes is array(0 to 3) of std_logic_vector(7 downto 0);
    signal  status, mem_in_status, mem_out_status, core_status : std_logic_vector(7 downto 0);
    signal  comando : std_logic_vector(7 downto 0);
    signal  data_array : std_logic_vector (0 to (2**PROFUNDIDADE)-1); -- Indicador de dados salvos na memória de entrada;
    signal  data_pointer, data_processed, data_received, data_bottom, data_returned : integer range 0  to (2**PROFUNDIDADE)-1; -- ponteiros para o vetor acima;
    signal  rWordPointer, wWordPointer, sWordPointer  : integer range 0 to (LARGURA_CORE/8); -- A cada N bytes, um byte é para instrução; no caso, o byte 0
    signal  processing, returningData, local_rst, thereIsAkey : std_logic := '0';
    signal  Error_status : std_logic_vector(7 downto 0):= x"00";
    signal  status_msg  :   array_4_bytes; 
begin

local_rst <= '1' when (rst = '1' or comando = CLEAR_DATA);

in_rst <= local_rst;
in_data <= tx_data;
in_get <= '1' when ((comando = LOAD_KEY or comando = LOAD_DATA) and  rWordPointer > 0) else '0';

out_rst <= local_rst;
out_get <= core_valid;



Error_status <= NO_ERRORS_FOUND when 
                mem_in_status = NO_ERRORS_FOUND or 
                mem_in_status = NO_ERRORS_FOUND or
                status = NO_ERRORS_FOUND  else
                ERROR_FOUND;
                
mem_in_status <= ERROR_FOUND when (in_end = '1') else NO_ERRORS_FOUND;
mem_out_status <= ERROR_FOUND when (out_end = '1') else NO_ERRORS_FOUND;
status <= NO_KEY_LOADED when thereIsAKey = '0' else NO_ERRORS_FOUND;

status_msg <= ( status, mem_in_status, mem_out_status, core_status);


Leitura_de_instrucao:
process(clk, rst)
begin
    if(local_rst = '1')then
        data_array <= (others => '0');
        data_pointer <= 0;
        data_bottom <= 0;
        rWordPointer <= 0;
        comando <= NOP;
    elsif (clk'event and clk = '1') then
        if(tx_av = '1' and data_pointer < (2**PROFUNDIDADE))then --tem dados a receber
            if(rWordPointer = 0)then -- Leitura de instrução;
                case tx_data is
                    when    CLEAR_DATA => 
                        comando<= CLEAR_DATA;
                        data_pointer <= 0;
                        rWordPointer <= 0;
                    when    LOAD_KEY => 
                        comando <= LOAD_KEY;
                        data_array(data_pointer) <= '0'; -- 0 indica que é uma chave;
                        data_pointer <= data_pointer + 1;
                    when    LOAD_DATA => 
                        comando <= LOAD_DATA;
                        data_array(data_pointer) <= '1'; -- 1 indica que é um dado;
                        data_pointer <= data_pointer + 1;
                    when    PROCESS_DATA =>
                        comando <= PROCESS_DATA;
                        data_bottom <= data_pointer;
                    when    DUMP_DATA =>
                        comando <= DUMP_DATA;
                    when    others => 
                        comando <= NOP;
                end case;
                    rWordPointer <= 1; -- Avança pro proximo byte;
            else -- atualiza o rWordPointer;
                if(rWordPointer = (LARGURA_CORE/8)) then
                    rWordPointer <= 0;
                else
                    rWordPointer <= rWordPointer + 1;
                end if;  
                end if;
        end if;
    end if;        
end process;

Processa_dados:
process(clk, local_rst)
begin
    if(local_rst= '1')then
        data_processed <= 0;
        data_received <= 0;
        core_status <= idle;
        processing <= '0';
        in_send <= '0';
        core_start <= '0';
        thereIsAKey <= '0';
    elsif(clk'event and clk = '1')then

        if(core_valid = '1') then
            data_received <= data_received + 1;
        end if;

        if(comando = PROCESS_DATA)then
            processing <= '1';
        elsif (processing = '1') then
            if(data_processed > data_bottom)then
                case( data_array(data_processed) ) is
                    when '1' => -- carrega um bloco de dados para o core, se ele estiver pronto;
                        core_loadKey <= '0';
                        if(thereIsAKey = '1')then -- Tem uma chave;
                            if(core_ready = '1')then --Core Pronto
                                core_status <= processing_data;
                                in_send <= '1'; -- manda uma palavra
                                core_start <= '1'; -- e manda processar
                                data_processed <= data_processed + 1; -- atualiza o ponteiro
                            else -- Core não pronto
                                in_send <= '0'; -- Aguarda
                                core_start <= '0'; -- Aguarda
                                core_status <= waiting_core; -- Aguarda
                            end if;
                        else                    --Não há chave carregada
                            processing <= '0';  --Para de processar, para que o circuito não aguarde para sempre;
                                end if;
                    when others => -- carrega uma chave para o core;
                        core_loadKey <= '1';
                        core_start <= '0';
                        in_send <= '1';
                        data_processed <= data_processed + 1;
                        core_status <= Loading_key;   
                        thereIsAKey <= '1';                
                end case ;
            else
                processing <= '0';
            end if;
        else
            core_status <= idle;
        end if;
    end if;
end process;

Retorna_dados:
process(clk, local_rst)
begin
    if(local_rst= '1')then
        data_returned <= 0;
        wWordPointer <= 0;
        returningData <= '0';
        rx_data <= NO_ERRORS_FOUND;
    elsif(clk'event and clk = '1')then
        if(comando = DUMP_DATA and out_end = '0' and data_returned < data_received)then
            returningData <= '1';
            sWordPointer <= 0;
        elsif(rx_busy = '0')then
            if (returningData = '1')then

                    if (out_end = '1' or data_returned = data_received) then 
                        returningData <= '0';
                    end if;

                    if(wWordPointer = 0)then
                        rx_data <= Error_status;
                        wWordPointer <= 1;
                    else
                        if(Error_status = NO_ERRORS_FOUND)then
                            out_send <= '1';           
                            rx_data <= out_data;
                            if(wWordPointer < (LARGURA_CORE/8))then -- avança pro proximo byte
                                wWordPointer <= wWordPointer + 1;
                            else
                                data_returned <= data_returned + 1;
                                wWordPointer <= 0;
                            end if;
                        else
                            rx_data <= Error_status;
                                end if;
                    end if;               
            else
                if(sWordPointer < (LARGURA_CORE/8))then -- avança pro proximo byte
                          sWordPointer <= sWordPointer + 1;
                     else
                          sWordPointer <= 0;
                     end if;
                case( sWordPointer ) is
                
                    when 0 => rx_data <= Error_status;
                    when (LARGURA_CORE/8)-1 => rx_data <= status_msg(0);
                    when (LARGURA_CORE/8)-2 => rx_data <= status_msg(1);
                    when (LARGURA_CORE/8)-3 => rx_data <= status_msg(2); 
                    when (LARGURA_CORE/8)-3 => rx_data <= status_msg(3);
                    when others => rx_data <= x"00";
                
                end case ;
            end if;
        end if;
    end if;
end process;
end architecture;