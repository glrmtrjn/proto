library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.all;

entity test_bench is
end;

architecture test_bench of test_bench is
	signal clk, reset, loadkey, cStart, dStart, cValid, dValid, cReady, dReady : std_logic:='0';
	signal cInput, dInput, cOutput, dOutput : std_logic_vector(1 to 64); 

begin

	process(clk)
	begin
		clk <= not clk after 10 ns;
	end process;

	cifra: entity work.des(CRYPT)
	port map(
			clk=>clk,
			rst=>reset,
			loadKey=> loadkey,
			start=>cStart,
			textin=>cInput,
			textout=>cOutput,
			valid=>cValid,
			ready=>cReady
	);

	decifra: entity work.des(DECRYPT)
	port map(	
			clk=>clk,
			rst=>reset,
			loadKey=> loadkey,
			start=>dStart,
			textin=>dInput,
			textout=>dOutput,
			valid=>dValid,
			ready=>dReady
	);

	gen_check: entity work.data_gen
	port map(

		clk=>clk,
		reset=>reset,
		loadkey=> loadkey,
		cStart=> cStart,
		dStart=> dStart,
		cValid=> cValid,
		dValid=> dValid,
		cReady=> cReady,
		dReady=> dReady,
		cInput=> cInput,
		dInput=> dInput,
		cOutput=> cOutput,
		dOutput=> dOutput
		
	);

end test_bench;

