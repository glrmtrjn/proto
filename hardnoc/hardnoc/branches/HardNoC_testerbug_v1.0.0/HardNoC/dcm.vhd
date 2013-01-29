--########################################################################
--
-- DCM
-- Guilherme Montez Guindani  
-- Hugo Artur Weber Schmitt
--
--########################################################################
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

library unisim;
use unisim.vcomponents.all;

entity My_DCM is
port(
	CLK_Base : in  std_logic;
	RST      : in  std_logic;
	CLKDV    : out std_logic;
	LOCKED   : out std_logic);             
end My_DCM;

architecture My_DCM of My_DCM is
  
	signal ckf, ck0, zero : std_logic;
	signal in_clk_base : std_logic;

	component BUFG is
	port (
		I : in  std_ulogic;
		O : out std_ulogic);
	end component;

	component DCM is
	port (
		CLKFB    : in  std_logic;
		CLKIN    : in  std_logic;
		DSSEN    : in  std_logic;
		PSCLK    : in  std_logic;
		PSEN     : in  std_logic;
		PSINCDEC : in  std_logic;
		RST      : in  std_logic;
		CLK0     : out std_logic;
		CLK90    : out std_logic;
		CLK180   : out std_logic;
		CLK270   : out std_logic;
		CLK2X    : out std_logic;
		CLK2X180 : out std_logic;
		CLKDV    : out std_logic;
		CLKFX    : out std_logic;
		CLKFX180 : out std_logic;
		LOCKED   : out std_logic;
		PSDONE   : out std_logic;
		STATUS   : out std_logic_vector(7 downto 0));
	end component;

begin

	zero <= '0';

	inst_BUFG_0 : BUFG
	port map(
		I => ck0,
		O => ckf
	);

	inst_BUFG_1 : BUFG
	port map(
		I => CLK_Base,
		O => in_clk_base
	);

	inst_DCM : DCM
	port map(
		CLKFB    => ckf,
		CLKIN    => in_clk_base,
		DSSEN    => zero,
		PSCLK    => zero,
		PSEN     => zero,
		PSINCDEC => zero,
		RST      => rst,
		CLK0     => ck0,
		CLK90    => open,
		CLK180   => open,
		CLK270   => open,
		CLK2X    => open,
		CLK2X180 => open,
		CLKDV    => CLKDV,
		CLKFX    => open,
		CLKFX180 => open,
		LOCKED   => LOCKED,
		PSDONE   => open,
		STATUS   => open
	);       

end My_DCM;
