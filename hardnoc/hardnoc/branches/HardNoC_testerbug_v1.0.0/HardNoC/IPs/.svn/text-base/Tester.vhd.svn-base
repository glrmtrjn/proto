-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- The Tester IP is a master/slave core responsible to generate packets, send these packets to NoC, 
-- receive packets from others cores connected to NoC and compute the latency values.
--
-- The Tester IP accepts four commands: 
-- 1) read :               <target> <size(3)> <source> <command - 00> <add>
-- 2) write:              <target> <size(4)> <source> <command - 01> <add> <data>
-- 3) data:               <target> <size(6+?)> <source> <command - 03> <TimeStamp1> <TimeStamp2> <TimeStamp3> <TimeStamp4> <Payload>).........
-- 4) return read:     <target> <size(3)> <source> <command - 09> <data>
--
--  minimum packet size equal to 9 Flits
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;
use work.HermesPackage.all;

library UNISIM;
use UNISIM.vcomponents.all;

-- Tester interface
entity Tester is
	port(
	clock:          in  std_logic;
	reset:          in  std_logic;
	start:		    in  std_logic;
	address:        in  reg8;
	clock_tx:       out std_logic;
	tx:             out std_logic;
	lane_tx:	    out regNlane;
	data_out:       out regflit;
	credit_i:       in  regNlane;
	clock_rx:       in  std_logic;
	rx:             in  std_logic;
	lane_rx:	    in  regNlane;
	data_in:        in  regflit;
	credit_o:       out regNlane);
end Tester;

-- Tester implementation
architecture Tester of Tester is

-- BlockRAM interface
component RAMB16_S9
port (DI     : in STD_LOGIC_VECTOR (7 downto 0);
        DIP    : in STD_LOGIC_VECTOR (0 downto 0);
        EN     : in STD_ULOGIC;
        WE     : in STD_ULOGIC;
        SSR    : in STD_ULOGIC;
        CLK    : in STD_ULOGIC;
        ADDR   : in STD_LOGIC_VECTOR (10 downto 0);
        DO     : out STD_LOGIC_VECTOR (7 downto 0);
        DOP    : out STD_LOGIC_VECTOR (0 downto 0));
end component;

-- state machines
type stateER is (R0,R1,R2,R3,R4,R5,R6,R7,R8,R9,R10,R11,R12);
type stateES is (S0,S1,S2,S3,S4,S5,S6,S7,S8,S9,S9b,S10,S11,S12,S13,S14,S15,S16,S17,S18,S19,S20,S21,S22,S23,S24);
signal ER: stateER;
signal ES: stateES;

-- packets reception signals
signal target,size,sizePayload,command: regflit;
signal busy: std_logic;
signal send: std_logic;
-- signals to compute the latency values
signal latency, minLatency, maxLatency, acLatency, nReceivedPackets : std_logic_vector(63 downto 0);
-- packets transmission signals
signal flowType, nTimes, countTimes, nUniformFlows, countUniformFlows: regflit;
signal nParetoPackets, countParetoPackets, nUniformPackets, countUniformPackets: regflit;
signal packetPriority,packetTarget, packetSize, countPacketSize, idleTime,  countIdleTime: regflit;
signal counterClock, timestampIn, timestampOut: std_logic_vector(63 downto 0);

-- memory signal
signal en,we: std_logic;
signal din,dout: std_logic_vector(15 downto 0);
signal addr: std_logic_vector(10 downto 0);
signal paridade: std_logic_vector(0 downto 0);

-- auxiliar signals
signal auxtx: std_logic;
signal auxlane_tx:	regNlane;
signal auxdata_out: regflit;
signal creditIN : std_logic;

begin

-------------------------------------------------------------------------------------------------------
---- BLOCKRAM 
-------------------------------------------------------------------------------------------------------
	paridade <= "1";

	--instanciando o bloco de RAM
	RAM0: RAMB16_S9
	port map(WE=>we, EN=>en, DIP=>paridade, SSR=>reset, CLK=>clock, ADDR=>addr, DI=>din(7 downto 0), DO=>dout(7 downto 0));
	--instanciando o bloco de RAM
	RAM1: RAMB16_S9
	port map(WE=>we, EN=>en, DIP=>paridade, SSR=>reset, CLK=>clock, ADDR=>addr, DI=>din(15 downto 8), DO=>dout(15 downto 8));

-------------------------------------------------------------------------------------------------------
---- RECEIVE FROM NETWORK
-------------------------------------------------------------------------------------------------------
	busy <= '1' when (command=x"0" and ES/=S0) else '0';

	process(reset,clock)
		begin
			if reset ='1' then
				credit_o(L1) <= '1';
				credit_o(L2) <= '0';
			elsif clock'event and clock='1' then
				if busy='0' then credit_o(L1) <= '1';
				else credit_o(L1) <= '0';
				end if;
			end if;
	end process;

	process(reset,clock,ER,busy,rx,command,sizePayload)
		begin
		if reset='1' then
			ER <= R0;
			send <= '0';
			size <= (others=>'0');
			target <= (others=>'0');
			command  <= (others=>'1');
			timestampOut <= (others=>'0');
			sizePayload <= (others=>'0');
			nReceivedPackets <= (others=>'0');
			latency <= (others=>'0');
			minLatency <= (others=>'1');
			maxLatency <= (others=>'0');
			acLatency <= (others=>'0');
		elsif clock'event and clock='0' then
		    case ER is
				when R0 =>
					send <= '0';
					sizePayload <= (others=>'0');
					command <= (others=>'1');
					if rx = '1' then	
						-- receiving target
						ER <= R1; 
					end if;
				when R1 =>
					send <= '0';
					sizePayload <= (others=>'0');
					if rx='1' then
						-- receiving the size 
						size <= data_in;
						ER <= R2;
					end if;
				when R2 => 
					if rx='1' then
						-- receiving the source
						target <= data_in;
						sizePayload <= sizePayload + '1';
						ER <= R3;
					end if;
				when R3 => 
					if rx='1' then
						-- receiving the command
						command <= data_in;
						sizePayload <= sizePayload + '1';
						ER <= R4;
					end if;
				when R4 => 
					if command/=x"0" and command/=x"1" and command/=x"3" then -- invalid command
						ER <= R7;
					elsif rx='1' and command=x"0" then 	-- read command
						-- receiving the address
						sizePayload <= sizePayload + '1';
						ER <= R8;
					elsif rx='1' and command=x"1" then 	 -- write command
						-- receiving the address
						sizePayload <= sizePayload + '1';
						ER <= R5;
					elsif rx='1' then			-- data command
						-- receiving the first flit of timestampOut
						timestampOut(63 downto 48) <= data_in;
						sizePayload <= sizePayload + '1';
						ER <= R9;
					end if;
				when R5 => 	-- write command
					if rx='1' then
						-- receiving the data
						sizePayload <= sizePayload + '1';
						ER <= R0;
					end if;
				when R7 => 	-- invalid packet
					if sizePayload = (size -1) then	ER <= R0;
					elsif rx='1' then
						-- receiving invalid packet
						sizePayload <= sizePayload + '1';
						ER <= R7;
					end if;
				when R8 => -- read command
						send <= '1';
						if rx = '1' then ER <= R1;
						else ER <= R0;
						end if;
				when R9 => -- data packet
					if rx='1' then
						-- receiving the second flit of timestampOut
						timestampOut(47 downto 32) <= data_in;
						sizePayload <= sizePayload + '1';
						ER <= R10;
					end if;
				when R10 => -- data packet
					if rx='1' then
						-- receiving the third flit of timestampOut
						timestampOut(31 downto 16) <= data_in;
						sizePayload <= sizePayload + '1';
						ER <= R11;
					end if;
				when R11 => -- data packet
					if rx='1' then
						if (sizePayload=5) then
							-- receiving the third flit of timestampOut
							timestampOut(15 downto 0) <= data_in;
						end if;
						if sizePayload = (size -1 ) then
							-- last flit of the packet
							-- increments the number of received packets
							nReceivedPackets <= nReceivedPackets + 1;
							-- calculate latency value
							latency <= counterClock - timestampOut;
							ER <= R12;
						else 
							sizePayload <= sizePayload + '1';
							ER <= R11;
						end if;
					end if;
				when R12 => -- data packet
					acLatency <= acLatency + latency;
					if maxLatency < latency then
						maxLatency <= latency;
					end if;
					if minLatency > latency then
						minLatency <= latency;
					end if;
					ER <= R0;
				when others=> null;
			end case;
		end if;
	end process;

-------------------------------------------------------------------------------------------------------
---- SEND TO NETWORK
-------------------------------------------------------------------------------------------------------
	clock_tx <= clock;
	tx<= auxtx;
	lane_tx<= auxlane_tx;
	
	auxlane_tx(L1) <= '1' when (auxtx='1' and packetPriority=x"0") else '0';
	auxlane_tx(L2) <= '1' when (auxtx='1' and packetPriority=x"1") else '0';
	
	creditIN <= credit_i(L1) when packetPriority = 0 else credit_i(L2);

	process (reset,clock)
	begin
		if reset='1' then
			ES <= S0;
			auxtx <= '0';
			data_out <= (others => '0');
			countTimes <= (others => '0');
			countUniformFlows <= (others => '0');
			countParetoPackets <= (others => '0');
			countPacketSize <= (others => '0');
			countUniformPackets <= (others => '0');
			countIdleTime <= (others => '0');
		elsif clock'event and clock='1' then
			case ES is
				when S0 =>
					auxtx <= '0';
					data_out <= (others => '0');
					countTimes <= (others => '0');
					countUniformFlows <= (others => '0');
					countParetoPackets <= (others => '0');
					countPacketSize <= (others => '0');
					countUniformPackets <= (others => '0');
					countIdleTime <= (others => '0');
					if send ='1' then -- send a return packet
						ES <= S1;
					elsif start='1' then -- send a data  packet
						ES <= S6;
					end if;
-------------------------------------------------------------------------------------------------------
---- RETURN PACKET
-------------------------------------------------------------------------------------------------------
				when S1 => -- return packet
					if creditIN = '1' then
						-- sending the target
						auxtx <= '1';
						data_out <= target;
						ES <= S2;
					end if;
				when S2 => -- return packet
					if creditIN = '1' then
						-- sending the size
						auxtx <= '1';
						data_out <= x"0003";
						ES <= S3;
					end if;
				when S3 => -- return packet
					if creditIN = '1' then
						-- sending the source
						auxtx <= '1';
						data_out <= x"00" & address;
						ES <= S4;
					end if;
				when S4 => -- return packet
					if creditIN = '1' then
						-- sending the command
						auxtx <= '1';
						data_out <= x"0009";
						ES <= S5;
					end if;
				when S5 =>  -- return packet
					if creditIN = '1' then
						-- sending the data
						auxtx <= '1';
						data_out <= auxdata_out;
						ES <= S0;
					end if;
-------------------------------------------------------------------------------------------------------
---- DATA PACKET
-------------------------------------------------------------------------------------------------------
				when S6 =>	-- data packet
					-- read the flow type(0=Uniform ; 1=Pareto)
					ES <= S7; 
				when S7 =>	-- data packet
					-- read the number of times that the traffic will be generated (-1 = infinitive; 1 = 1 time; N = N times)
					ES <= S8;
				when S8 =>	-- data packet
					if flowType = 0 then -- Uniform
						countUniformFlows <= (others=>'0');
					else -- Pareto
						countParetoPackets <= (others=>'0');
					end if;
					ES <= S9;
				when S9 => -- data packet
					if nTimes = countTimes then
						ES <=S0;
					else
						countTimes <= countTimes + 1;
						countUniformFlows <= (others=>'0');
						countParetoPackets <= (others=>'0');
						ES <= S9b;
					end if;
				when S9b => -- data packet
					-- read the packet priority
					countUniformFlows <= countUniformFlows + 1;
					ES <= S10;
				when S10 => -- data packet
					-- read the packet target
					ES <= S11;
				when S11 => -- data packet
					-- read the packet size
					ES <= S12;
				when S12 => -- data packet
					if flowType = 0 then -- Uniform
						-- read the number of packets
						countUniformPackets <= (others => '0');
						ES <= S13;
					else -- Pareto
						if nParetoPackets = countParetoPackets then
							ES <= S9;
						else
							-- read the timestamp
							ES <= S13;
						end if;
					end if;
				when S13 => -- data packet
					if flowType = 0 then -- Uniform
						-- read the idle time between consecutive packets
						countIdleTime <= (others=>'0');
						ES <= S14;
					else -- Pareto
						if counterClock=(timestampIn-2) or counterClock>(timestampIn-2) then
							ES <= S14;
						end if;
					end if;
				when S14 => -- data packet
					if nUniformPackets=0 and flowType=0 then
						ES <= S0; 
					elsif creditIN = '1' then
						-- send Target
						auxtx <= '1';
						data_out <= packetTarget;
						countPacketSize <= (others => '0');
						countIdleTime <= (others=>'0');
						countUniformPackets <= countUniformPackets + 1;
						countParetoPackets <= countParetoPackets +1 ;
						ES <= S15;
					end if;
				when S15 => -- data packet
					if creditIN = '1' then
						-- send the size
						auxtx <= '1';
						data_out <= packetSize;
						ES <= S16;
					end if;
				when S16 => -- data packet
					if creditIN = '1' then
						-- send the source
						auxtx <= '1';
						data_out <=  x"00" & address;
						countPacketSize <= countPacketSize + '1';
						ES <= S17;
					end if;
				when S17 => -- data packet
					if creditIN = '1' then
						-- send the command
						auxtx <= '1';
						data_out <= x"0003";
						countPacketSize <= countPacketSize + '1';
						ES <= S18;
					end if;
				when S18 => -- data packet
					if creditIN = '1' then
						-- send the first flit of timestampOut
						auxtx <= '1';
						data_out <= timestampIn(63 downto 48);
						countPacketSize <= countPacketSize + '1';
						ES <= S19;
					end if;
				when S19 => -- data packet
					if creditIN = '1' then
						-- send the second flit of timestampOut
						auxtx <= '1';
						data_out <= timestampIn(47 downto 32);
						countPacketSize <= countPacketSize + '1';
						ES <= S20;
					end if;
				when S20 => -- data packet
					if creditIN = '1' then
						-- send the third flit of timestampOut
						auxtx <= '1';
						data_out <= timestampIn(31 downto 16);
						countPacketSize <= countPacketSize + '1';
						ES <= S21;
					end if;
				when S21 => -- data packet
					if creditIN = '1' then
						-- send the forth flit of timestampOut
						auxtx <= '1';
						data_out <= timestampIn(15 downto 0);
						countPacketSize <= countPacketSize + '1';
						if flowType = 0 then 
							ES <= S22;
						else 
							ES <= S24;
						end if;
					end if;
				when S22 => -- uniform data packet
					if countPacketSize /= packetSize and creditIN = '1' then
						-- send the payload
						auxtx <= '1';
						data_out <=  countPacketSize;
						countPacketSize <= countPacketSize + '1';
					elsif countPacketSize = packetSize and creditIN = '1' then
						auxtx <= '0';
						data_out <=  (others=>'0');
						if idleTime = 0 then
							if countUniformPackets = nUniformPackets then
								if nUniformFlows = countUniformFlows then
									ES <= S9;
								else
									-- read a new flow
									ES <= S9b;
								end if;
							elsif creditIN = '1' then
								-- send more one packet
								-- send Target
								auxtx <= '1';
								data_out <= packetTarget;
								countPacketSize <= (others => '0');
								countIdleTime <= (others=>'0');
								countUniformPackets <= countUniformPackets + 1;
								ES <= S15;
							end if;
						else
							countIdleTime <= countIdleTime + '1';
							ES <= S23;
						end if;
					end if;
				when S23 => -- uniform data packet		
					if countIdleTime>idleTime or countIdleTime=idleTime then
						if countUniformPackets = nUniformPackets then
							if nUniformFlows = countUniformFlows then
								ES <= S9;
							else
								-- read a new flow
								ES <= S9b;
							end if;
						elsif creditIN = '1' then
							-- send more one packet
							-- send Target
							auxtx <= '1';
							data_out <= packetTarget;
							countPacketSize <= (others => '0');
							countIdleTime <= (others=>'0');
							countUniformPackets <= countUniformPackets + 1;
							ES <= S15;
						end if;
					else 
						countIdleTime <= countIdleTime + '1';
					end if;
				when S24 => -- pareto data packet
					-- send the payload
					if countPacketSize /= packetSize and creditIN = '1' then
						auxtx <= '1';
						data_out <=  countPacketSize;
						countPacketSize <= countPacketSize + '1';
					elsif countPacketSize = packetSize and creditIN = '1' then
						auxtx <= '0';
						data_out <=  (others=>'0');
						ES <= S12;
					end if;
			end case;
		end if;
	end process;

	process (reset,clock)
	begin
		if reset='1' then
			flowType <= (others => '0');
			nTimes <= (others => '0');
			nUniformFlows <= (others => '0');
			nParetoPackets <= (others => '0');
			packetPriority <= (others => '0');
			packetTarget <= (others => '0');
			packetSize <= (others => '0');
			nUniformPackets <= (others => '0');
			idleTime <= (others => '0');
			timestampIn <= (others => '0');
		elsif clock'event and clock='0' then
			case ES is
				when S0 =>
					flowType <= (others => '0');
					nTimes <= (others => '0');
					nUniformFlows <= (others => '0');
					nParetoPackets <= (others => '0');
					packetPriority <= (others => '0');
					packetTarget <= (others => '0');
					packetSize <= (others => '0');
					nUniformPackets <= (others => '0');
					idleTime <= (others => '0');
					timestampIn <= (others => '0');
-------------------------------------------------------------------------------------------------------
---- DATA PACKET
-------------------------------------------------------------------------------------------------------
				when S6 => -- data packet
					-- read the flow type(0=Uniform ; 1=Pareto)
					flowType <= dout;
				when S7 => -- data packet
					-- read the number of times that the traffic will be generated (-1 = infinitive; 1 = 1 time; N = N times)
					nTimes <= dout;
				when S8 => -- data packet
					if flowType = 0 then -- Uniform
						nUniformFlows <= dout;
					else -- Pareto
						nParetoPackets <= dout;
					end if;
				when S9b => -- data packet
					-- read the packet priority
					packetPriority <= dout;
				when S10 => -- data packet
					-- read the packet target
					packetTarget <= dout;
				when S11 => -- data packet
					-- read the packet size
					packetSize <= dout;
				when S12 => -- data packet
					if flowType = 0 then -- Uniform
						-- read the number of packets
						nUniformPackets <= dout;
					else -- Pareto
						if nParetoPackets/=countParetoPackets then
							-- read the timestamp
							timestampIn <= (counterClock + dout); 	
						end if;
					end if;
				when S13 => -- data packet
					if flowType = 0 then -- Uniform
						-- read the idle time between consecutive packets
						idleTime <= dout;
					end if;
				when S15 => -- data packet
					if creditIN = '1' then
						timestampIn <= counterClock;
					end if;
				when others=> null;
			end case;
		end if;
	end process;
	
-------------------------------------------------------------------------------------------------------
---- ACCESS TO MEMORY
-------------------------------------------------------------------------------------------------------
	-- signal ADDR
	process(clock, reset)
	begin
		if reset='1' then
			addr<= (others=>'0');
		elsif clock'event and clock='0' then
			if start='1' then
				addr <= (others=>'0');
			elsif ER=R4 and rx='1' and (command=x"0" or command=x"1") then -- write or read command
				--addr <= data_in(9 downto 0);  	-- Virtex 800
				addr <= data_in(10 downto 0); 	-- Virtex 1000
			elsif ES=S9 then
				addr <= "00000000011";
			elsif ES=S6 or ES=S7 or ES=S8 or ES=S9b or ES=S10 or ES=S11 or ES=S12 or (ES=S13 and flowType=0) then
				addr <= addr + 1;
			end if;
		end if;
	end process;

	-- signal auxdata_out
	-- last update: 01.11.2011
	-- address modified by Guilherme Heck
	-- consistent with documentation v2.0
	process(clock, reset)
	begin
		if reset='1' then
			auxdata_out <= (others => '0');
		elsif clock'event and clock='0' then
			if ER=R8 and command=x"0" then	
				if addr = x"3F0" then
					auxdata_out <= acLatency(63 downto 48);
				elsif addr = x"3F1" then
					auxdata_out <= acLatency(47 downto 32);
				elsif addr = x"3F2" then
					auxdata_out <= acLatency(31 downto 16);
				elsif addr = x"3F3" then
					auxdata_out <= acLatency(15 downto 0);
				elsif addr = x"3F4" then
					auxdata_out <= maxLatency(63 downto 48);
				elsif addr = x"3F5" then
					auxdata_out <= maxLatency(47 downto 32);
				elsif addr = x"3F6" then
					auxdata_out <= maxLatency(31 downto 16);
				elsif addr = x"3F7" then
					auxdata_out <= maxLatency(15 downto 0);
				elsif addr = x"3F8" then
					if minLatency(63 downto 48) = x"FFFF" then auxdata_out <= (others=>'0');
					else auxdata_out <= minLatency(63 downto 48);
					end if;
				elsif addr = x"3F9" then
					if minLatency(47 downto 32) = x"FFFF" then auxdata_out <= (others=>'0');
					else auxdata_out <= minLatency(47 downto 32);
					end if;
				elsif addr = x"3FA" then
					if minLatency(31 downto 16) = x"FFFF" then auxdata_out <= (others=>'0');
					else auxdata_out <= minLatency(31 downto 16);
					end if;
				elsif addr = x"3FB" then
					if minLatency(15 downto 0) = x"FFFF" then auxdata_out <= (others=>'0');
					else auxdata_out <= minLatency(15 downto 0);
					end if;
				elsif addr = x"3FC" then
					auxdata_out <= nReceivedPackets(63 downto 48);
				elsif addr = x"3FD" then
					auxdata_out <= nReceivedPackets(47 downto 32);
				elsif addr = x"3FE" then
					auxdata_out <= nReceivedPackets(31 downto 16);
				elsif addr = x"3FF" then
					auxdata_out <= nReceivedPackets(15 downto 0);
				else
					auxdata_out <= dout;
				end if;
			end if;
		end if;
	end process;
	
	-- signal EN
	process(clock, reset)
	begin
		if reset='1' then
			en<='0';
		elsif clock'event and clock='0' then
			if (ER=R4 and command=x"0") or ER=R5 or start='1' or ES=S6 or ES=S7 or 
			ES=S8 or ES=S9 or ES=S9b or ES=S10 or ES=S11 or ES=S12 or (ES=S13 and flowType = 0) then
				en <= '1';
			else
				en <= '0';
			end if;
		end if;
	end process;
	
	-- signal WE
	process(clock, reset)
	begin
		if reset='1' then
			we<='0';
		elsif clock'event and clock='0' then
			if ER=R5 then we <= '1';
			else we <= '0';
			end if;
		end if;
	end process;

	-- signal DIN
	process(clock, reset)
	begin
		if reset='1' then
			din <= (others=>'0');
		elsif clock'event and clock='0' then
			if ER=R5 then
				din <= data_in;
			end if;
		end if;
	end process;

--------------------------------------------------------------------------------------------------------------------------
---- COUNT THE NUMBER OF CLOCK CYCLES AFTER RECEIVING THE START SIGNAL
-------------------------------------------------------------------------------------------------------------------------
	process(clock, reset, start)
	begin
		if reset='1' or start='1' then
			counterClock <= (others=>'0');
		elsif clock'event and clock='1' then
			counterClock <= counterClock + '1';
		end if;
	end process;

end Tester;
