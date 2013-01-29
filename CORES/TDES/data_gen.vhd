library ieee;
use ieee.std_logic_1164.all;

entity data_gen is
	port(	
		clk	: in std_logic;
		reset 	: out std_logic;	
		loadKey,
		cStart,
		dStart : out std_logic;
		cReady,
		dReady,
		cvalid,
		dValid : in std_logic;

		cOutput : in std_logic_vector(1 to 64);
		dOutput : in std_logic_vector(1 to 64);
				
		cInput 	: out std_logic_vector(1 to 64);
		dInput 	: out std_logic_vector(1 to 64)
				
	);

end;
architecture SystemC of data_gen is
	attribute foreign of SystemC : architecture is "SystemC";
begin
end;
