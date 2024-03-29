-----------------------------------
-----------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use work.P_AES.all;

entity Sbox is
	generic( MODO_DE_OPERACAO : string := "CRYPT");
	port(
		entrada: in std_logic_vector(7 downto 0);
		saida: out std_logic_vector(7 downto 0)
	);
end Sbox;

architecture comp of Sbox is

begin
CRYPT: if MODO_DE_OPERACAO = "CRYPT" generate
	saida <=x"63" when entrada = x"00" else
			x"7c" when entrada = x"01" else
			x"77" when entrada = x"02" else
			x"7b" when entrada = x"03" else
			x"f2" when entrada = x"04" else
			x"6b" when entrada = x"05" else
			x"6f" when entrada = x"06" else
			x"c5" when entrada = x"07" else
			x"30" when entrada = x"08" else
			x"01" when entrada = x"09" else
			x"67" when entrada = x"0a" else
			x"2b" when entrada = x"0b" else
			x"fe" when entrada = x"0c" else
			x"d7" when entrada = x"0d" else
			x"ab" when entrada = x"0e" else
			x"76" when entrada = x"0f" else
			x"ca" when entrada = x"10" else
			x"82" when entrada = x"11" else
			x"c9" when entrada = x"12" else
			x"7d" when entrada = x"13" else
			x"fa" when entrada = x"14" else
			x"59" when entrada = x"15" else
			x"47" when entrada = x"16" else
			x"f0" when entrada = x"17" else
			x"ad" when entrada = x"18" else
			x"d4" when entrada = x"19" else
			x"a2" when entrada = x"1a" else
			x"af" when entrada = x"1b" else
			x"9c" when entrada = x"1c" else
			x"a4" when entrada = x"1d" else
			x"72" when entrada = x"1e" else
			x"c0" when entrada = x"1f" else
			x"b7" when entrada = x"20" else
			x"fd" when entrada = x"21" else
			x"93" when entrada = x"22" else
			x"26" when entrada = x"23" else
			x"36" when entrada = x"24" else
			x"3f" when entrada = x"25" else
			x"f7" when entrada = x"26" else
			x"cc" when entrada = x"27" else
			x"34" when entrada = x"28" else
			x"a5" when entrada = x"29" else
			x"e5" when entrada = x"2a" else
			x"f1" when entrada = x"2b" else
			x"71" when entrada = x"2c" else
			x"d8" when entrada = x"2d" else
			x"31" when entrada = x"2e" else
			x"15" when entrada = x"2f" else
			x"04" when entrada = x"30" else
			x"c7" when entrada = x"31" else
			x"23" when entrada = x"32" else
			x"c3" when entrada = x"33" else
			x"18" when entrada = x"34" else
			x"96" when entrada = x"35" else
			x"05" when entrada = x"36" else
			x"9a" when entrada = x"37" else
			x"07" when entrada = x"38" else
			x"12" when entrada = x"39" else
			x"80" when entrada = x"3a" else
			x"e2" when entrada = x"3b" else
			x"eb" when entrada = x"3c" else
			x"27" when entrada = x"3d" else
			x"b2" when entrada = x"3e" else
			x"75" when entrada = x"3f" else
			x"09" when entrada = x"40" else
			x"83" when entrada = x"41" else
			x"2c" when entrada = x"42" else
			x"1a" when entrada = x"43" else
			x"1b" when entrada = x"44" else
			x"6e" when entrada = x"45" else
			x"5a" when entrada = x"46" else
			x"a0" when entrada = x"47" else
			x"52" when entrada = x"48" else
			x"3b" when entrada = x"49" else
			x"d6" when entrada = x"4a" else
			x"b3" when entrada = x"4b" else
			x"29" when entrada = x"4c" else
			x"e3" when entrada = x"4d" else
			x"2f" when entrada = x"4e" else
			x"84" when entrada = x"4f" else
			x"53" when entrada = x"50" else
			x"d1" when entrada = x"51" else
			x"00" when entrada = x"52" else
			x"ed" when entrada = x"53" else
			x"20" when entrada = x"54" else
			x"fc" when entrada = x"55" else
			x"b1" when entrada = x"56" else
			x"5b" when entrada = x"57" else
			x"6a" when entrada = x"58" else
			x"cb" when entrada = x"59" else
			x"be" when entrada = x"5a" else
			x"39" when entrada = x"5b" else
			x"4a" when entrada = x"5c" else
			x"4c" when entrada = x"5d" else
			x"58" when entrada = x"5e" else
			x"cf" when entrada = x"5f" else
			x"d0" when entrada = x"60" else
			x"ef" when entrada = x"61" else
			x"aa" when entrada = x"62" else
			x"fb" when entrada = x"63" else
			x"43" when entrada = x"64" else
			x"4d" when entrada = x"65" else
			x"33" when entrada = x"66" else
			x"85" when entrada = x"67" else
			x"45" when entrada = x"68" else
			x"f9" when entrada = x"69" else
			x"02" when entrada = x"6a" else
			x"7f" when entrada = x"6b" else
			x"50" when entrada = x"6c" else
			x"3c" when entrada = x"6d" else
			x"9f" when entrada = x"6e" else
			x"a8" when entrada = x"6f" else
			x"51" when entrada = x"70" else
			x"a3" when entrada = x"71" else
			x"40" when entrada = x"72" else
			x"8f" when entrada = x"73" else
			x"92" when entrada = x"74" else
			x"9d" when entrada = x"75" else
			x"38" when entrada = x"76" else
			x"f5" when entrada = x"77" else
			x"bc" when entrada = x"78" else
			x"b6" when entrada = x"79" else
			x"da" when entrada = x"7a" else
			x"21" when entrada = x"7b" else
			x"10" when entrada = x"7c" else
			x"ff" when entrada = x"7d" else
			x"f3" when entrada = x"7e" else
			x"d2" when entrada = x"7f" else
			x"cd" when entrada = x"80" else
			x"0c" when entrada = x"81" else
			x"13" when entrada = x"82" else
			x"ec" when entrada = x"83" else
			x"5f" when entrada = x"84" else
			x"97" when entrada = x"85" else
			x"44" when entrada = x"86" else
			x"17" when entrada = x"87" else
			x"c4" when entrada = x"88" else
			x"a7" when entrada = x"89" else
			x"7e" when entrada = x"8a" else
			x"3d" when entrada = x"8b" else
			x"64" when entrada = x"8c" else
			x"5d" when entrada = x"8d" else
			x"19" when entrada = x"8e" else
			x"73" when entrada = x"8f" else
			x"60" when entrada = x"90" else
			x"81" when entrada = x"91" else
			x"4f" when entrada = x"92" else
			x"dc" when entrada = x"93" else
			x"22" when entrada = x"94" else
			x"2a" when entrada = x"95" else
			x"90" when entrada = x"96" else
			x"88" when entrada = x"97" else
			x"46" when entrada = x"98" else
			x"ee" when entrada = x"99" else
			x"b8" when entrada = x"9a" else
			x"14" when entrada = x"9b" else
			x"de" when entrada = x"9c" else
			x"5e" when entrada = x"9d" else
			x"0b" when entrada = x"9e" else
			x"db" when entrada = x"9f" else
			x"e0" when entrada = x"a0" else
			x"32" when entrada = x"a1" else
			x"3a" when entrada = x"a2" else
			x"0a" when entrada = x"a3" else
			x"49" when entrada = x"a4" else
			x"06" when entrada = x"a5" else
			x"24" when entrada = x"a6" else
			x"5c" when entrada = x"a7" else
			x"c2" when entrada = x"a8" else
			x"d3" when entrada = x"a9" else
			x"ac" when entrada = x"aa" else
			x"62" when entrada = x"ab" else
			x"91" when entrada = x"ac" else
			x"95" when entrada = x"ad" else
			x"e4" when entrada = x"ae" else
			x"79" when entrada = x"af" else
			x"e7" when entrada = x"b0" else
			x"c8" when entrada = x"b1" else
			x"37" when entrada = x"b2" else
			x"6d" when entrada = x"b3" else
			x"8d" when entrada = x"b4" else
			x"d5" when entrada = x"b5" else
			x"4e" when entrada = x"b6" else
			x"a9" when entrada = x"b7" else
			x"6c" when entrada = x"b8" else
			x"56" when entrada = x"b9" else
			x"f4" when entrada = x"ba" else
			x"ea" when entrada = x"bb" else
			x"65" when entrada = x"bc" else
			x"7a" when entrada = x"bd" else
			x"ae" when entrada = x"be" else
			x"08" when entrada = x"bf" else
			x"ba" when entrada = x"c0" else
			x"78" when entrada = x"c1" else
			x"25" when entrada = x"c2" else
			x"2e" when entrada = x"c3" else
			x"1c" when entrada = x"c4" else
			x"a6" when entrada = x"c5" else
			x"b4" when entrada = x"c6" else
			x"c6" when entrada = x"c7" else
			x"e8" when entrada = x"c8" else
			x"dd" when entrada = x"c9" else
			x"74" when entrada = x"ca" else
			x"1f" when entrada = x"cb" else
			x"4b" when entrada = x"cc" else
			x"bd" when entrada = x"cd" else
			x"8b" when entrada = x"ce" else
			x"8a" when entrada = x"cf" else
			x"70" when entrada = x"d0" else
			x"3e" when entrada = x"d1" else
			x"b5" when entrada = x"d2" else
			x"66" when entrada = x"d3" else
			x"48" when entrada = x"d4" else
			x"03" when entrada = x"d5" else
			x"f6" when entrada = x"d6" else
			x"0e" when entrada = x"d7" else
			x"61" when entrada = x"d8" else
			x"35" when entrada = x"d9" else
			x"57" when entrada = x"da" else
			x"b9" when entrada = x"db" else
			x"86" when entrada = x"dc" else
			x"c1" when entrada = x"dd" else
			x"1d" when entrada = x"de" else
			x"9e" when entrada = x"df" else
			x"e1" when entrada = x"e0" else
			x"f8" when entrada = x"e1" else
			x"98" when entrada = x"e2" else
			x"11" when entrada = x"e3" else
			x"69" when entrada = x"e4" else
			x"d9" when entrada = x"e5" else
			x"8e" when entrada = x"e6" else
			x"94" when entrada = x"e7" else
			x"9b" when entrada = x"e8" else
			x"1e" when entrada = x"e9" else
			x"87" when entrada = x"ea" else
			x"e9" when entrada = x"eb" else
			x"ce" when entrada = x"ec" else
			x"55" when entrada = x"ed" else
			x"28" when entrada = x"ee" else
			x"df" when entrada = x"ef" else
			x"8c" when entrada = x"f0" else
			x"a1" when entrada = x"f1" else
			x"89" when entrada = x"f2" else
			x"0d" when entrada = x"f3" else
			x"bf" when entrada = x"f4" else
			x"e6" when entrada = x"f5" else
			x"42" when entrada = x"f6" else
			x"68" when entrada = x"f7" else
			x"41" when entrada = x"f8" else
			x"99" when entrada = x"f9" else
			x"2d" when entrada = x"fa" else
			x"0f" when entrada = x"fb" else
			x"b0" when entrada = x"fc" else
			x"54" when entrada = x"fd" else
			x"bb" when entrada = x"fe" else
			x"16" when entrada = x"ff";
	end generate CRYPT;

DECRYPT: if MODO_DE_OPERACAO = "DECRYPT" generate	
	saida <=
			x"52" when entrada = x"00" else
			x"09" when entrada = x"01" else
			x"6a" when entrada = x"02" else
			x"d5" when entrada = x"03" else
			x"30" when entrada = x"04" else
			x"36" when entrada = x"05" else
			x"a5" when entrada = x"06" else
			x"38" when entrada = x"07" else
			x"bf" when entrada = x"08" else
			x"40" when entrada = x"09" else
			x"a3" when entrada = x"0a" else
			x"9e" when entrada = x"0b" else
			x"81" when entrada = x"0c" else
			x"f3" when entrada = x"0d" else
			x"d7" when entrada = x"0e" else
			x"fb" when entrada = x"0f" else
			x"7c" when entrada = x"10" else
			x"e3" when entrada = x"11" else
			x"39" when entrada = x"12" else
			x"82" when entrada = x"13" else
			x"9b" when entrada = x"14" else
			x"2f" when entrada = x"15" else
			x"ff" when entrada = x"16" else
			x"87" when entrada = x"17" else
			x"34" when entrada = x"18" else
			x"8e" when entrada = x"19" else
			x"43" when entrada = x"1a" else
			x"44" when entrada = x"1b" else
			x"c4" when entrada = x"1c" else
			x"de" when entrada = x"1d" else
			x"e9" when entrada = x"1e" else
			x"cb" when entrada = x"1f" else
			x"54" when entrada = x"20" else
			x"7b" when entrada = x"21" else
			x"94" when entrada = x"22" else
			x"32" when entrada = x"23" else
			x"a6" when entrada = x"24" else
			x"c2" when entrada = x"25" else
			x"23" when entrada = x"26" else
			x"3d" when entrada = x"27" else
			x"ee" when entrada = x"28" else
			x"4c" when entrada = x"29" else
			x"95" when entrada = x"2a" else
			x"0b" when entrada = x"2b" else
			x"42" when entrada = x"2c" else
			x"fa" when entrada = x"2d" else
			x"c3" when entrada = x"2e" else
			x"4e" when entrada = x"2f" else
			x"08" when entrada = x"30" else
			x"2e" when entrada = x"31" else
			x"a1" when entrada = x"32" else
			x"66" when entrada = x"33" else
			x"28" when entrada = x"34" else
			x"d9" when entrada = x"35" else
			x"24" when entrada = x"36" else
			x"b2" when entrada = x"37" else
			x"76" when entrada = x"38" else
			x"5b" when entrada = x"39" else
			x"a2" when entrada = x"3a" else
			x"49" when entrada = x"3b" else
			x"6d" when entrada = x"3c" else
			x"8b" when entrada = x"3d" else
			x"d1" when entrada = x"3e" else
			x"25" when entrada = x"3f" else
			x"72" when entrada = x"40" else
			x"f8" when entrada = x"41" else
			x"f6" when entrada = x"42" else
			x"64" when entrada = x"43" else
			x"86" when entrada = x"44" else
			x"68" when entrada = x"45" else
			x"98" when entrada = x"46" else
			x"16" when entrada = x"47" else
			x"d4" when entrada = x"48" else
			x"a4" when entrada = x"49" else
			x"5c" when entrada = x"4a" else
			x"cc" when entrada = x"4b" else
			x"5d" when entrada = x"4c" else
			x"65" when entrada = x"4d" else
			x"b6" when entrada = x"4e" else
			x"92" when entrada = x"4f" else
			x"6c" when entrada = x"50" else
			x"70" when entrada = x"51" else
			x"48" when entrada = x"52" else
			x"50" when entrada = x"53" else
			x"fd" when entrada = x"54" else
			x"ed" when entrada = x"55" else
			x"b9" when entrada = x"56" else
			x"da" when entrada = x"57" else
			x"5e" when entrada = x"58" else
			x"15" when entrada = x"59" else
			x"46" when entrada = x"5a" else
			x"57" when entrada = x"5b" else
			x"a7" when entrada = x"5c" else
			x"8d" when entrada = x"5d" else
			x"9d" when entrada = x"5e" else
			x"84" when entrada = x"5f" else
			x"90" when entrada = x"60" else
			x"d8" when entrada = x"61" else
			x"ab" when entrada = x"62" else
			x"00" when entrada = x"63" else
			x"8c" when entrada = x"64" else
			x"bc" when entrada = x"65" else
			x"d3" when entrada = x"66" else
			x"0a" when entrada = x"67" else
			x"f7" when entrada = x"68" else
			x"e4" when entrada = x"69" else
			x"58" when entrada = x"6a" else
			x"05" when entrada = x"6b" else
			x"b8" when entrada = x"6c" else
			x"b3" when entrada = x"6d" else
			x"45" when entrada = x"6e" else
			x"06" when entrada = x"6f" else
			x"d0" when entrada = x"70" else
			x"2c" when entrada = x"71" else
			x"1e" when entrada = x"72" else
			x"8f" when entrada = x"73" else
			x"ca" when entrada = x"74" else
			x"3f" when entrada = x"75" else
			x"0f" when entrada = x"76" else
			x"02" when entrada = x"77" else
			x"c1" when entrada = x"78" else
			x"af" when entrada = x"79" else
			x"bd" when entrada = x"7a" else
			x"03" when entrada = x"7b" else
			x"01" when entrada = x"7c" else
			x"13" when entrada = x"7d" else
			x"8a" when entrada = x"7e" else
			x"6b" when entrada = x"7f" else
			x"3a" when entrada = x"80" else
			x"91" when entrada = x"81" else
			x"11" when entrada = x"82" else
			x"41" when entrada = x"83" else
			x"4f" when entrada = x"84" else
			x"67" when entrada = x"85" else
			x"dc" when entrada = x"86" else
			x"ea" when entrada = x"87" else
			x"97" when entrada = x"88" else
			x"f2" when entrada = x"89" else
			x"cf" when entrada = x"8a" else
			x"ce" when entrada = x"8b" else
			x"f0" when entrada = x"8c" else
			x"b4" when entrada = x"8d" else
			x"e6" when entrada = x"8e" else
			x"73" when entrada = x"8f" else
			x"96" when entrada = x"90" else
			x"ac" when entrada = x"91" else
			x"74" when entrada = x"92" else
			x"22" when entrada = x"93" else
			x"e7" when entrada = x"94" else
			x"ad" when entrada = x"95" else
			x"35" when entrada = x"96" else
			x"85" when entrada = x"97" else
			x"e2" when entrada = x"98" else
			x"f9" when entrada = x"99" else
			x"37" when entrada = x"9a" else
			x"e8" when entrada = x"9b" else
			x"1c" when entrada = x"9c" else
			x"75" when entrada = x"9d" else
			x"df" when entrada = x"9e" else
			x"6e" when entrada = x"9f" else
			x"47" when entrada = x"a0" else
			x"f1" when entrada = x"a1" else
			x"1a" when entrada = x"a2" else
			x"71" when entrada = x"a3" else
			x"1d" when entrada = x"a4" else
			x"29" when entrada = x"a5" else
			x"c5" when entrada = x"a6" else
			x"89" when entrada = x"a7" else
			x"6f" when entrada = x"a8" else
			x"b7" when entrada = x"a9" else
			x"62" when entrada = x"aa" else
			x"0e" when entrada = x"ab" else
			x"aa" when entrada = x"ac" else
			x"18" when entrada = x"ad" else
			x"be" when entrada = x"ae" else
			x"1b" when entrada = x"af" else
			x"fc" when entrada = x"b0" else
			x"56" when entrada = x"b1" else
			x"3e" when entrada = x"b2" else
			x"4b" when entrada = x"b3" else
			x"c6" when entrada = x"b4" else
			x"d2" when entrada = x"b5" else
			x"79" when entrada = x"b6" else
			x"20" when entrada = x"b7" else
			x"9a" when entrada = x"b8" else
			x"db" when entrada = x"b9" else
			x"c0" when entrada = x"ba" else
			x"fe" when entrada = x"bb" else
			x"78" when entrada = x"bc" else
			x"cd" when entrada = x"bd" else
			x"5a" when entrada = x"be" else
			x"f4" when entrada = x"bf" else
			x"1f" when entrada = x"c0" else
			x"dd" when entrada = x"c1" else
			x"a8" when entrada = x"c2" else
			x"33" when entrada = x"c3" else
			x"88" when entrada = x"c4" else
			x"07" when entrada = x"c5" else
			x"c7" when entrada = x"c6" else
			x"31" when entrada = x"c7" else
			x"b1" when entrada = x"c8" else
			x"12" when entrada = x"c9" else
			x"10" when entrada = x"ca" else
			x"59" when entrada = x"cb" else
			x"27" when entrada = x"cc" else
			x"80" when entrada = x"cd" else
			x"ec" when entrada = x"ce" else
			x"5f" when entrada = x"cf" else
			x"60" when entrada = x"d0" else
			x"51" when entrada = x"d1" else
			x"7f" when entrada = x"d2" else
			x"a9" when entrada = x"d3" else
			x"19" when entrada = x"d4" else
			x"b5" when entrada = x"d5" else
			x"4a" when entrada = x"d6" else
			x"0d" when entrada = x"d7" else
			x"2d" when entrada = x"d8" else
			x"e5" when entrada = x"d9" else
			x"7a" when entrada = x"da" else
			x"9f" when entrada = x"db" else
			x"93" when entrada = x"dc" else
			x"c9" when entrada = x"dd" else
			x"9c" when entrada = x"de" else
			x"ef" when entrada = x"df" else
			x"a0" when entrada = x"e0" else
			x"e0" when entrada = x"e1" else
			x"3b" when entrada = x"e2" else
			x"4d" when entrada = x"e3" else
			x"ae" when entrada = x"e4" else
			x"2a" when entrada = x"e5" else
			x"f5" when entrada = x"e6" else
			x"b0" when entrada = x"e7" else
			x"c8" when entrada = x"e8" else
			x"eb" when entrada = x"e9" else
			x"bb" when entrada = x"ea" else
			x"3c" when entrada = x"eb" else
			x"83" when entrada = x"ec" else
			x"53" when entrada = x"ed" else
			x"99" when entrada = x"ee" else
			x"61" when entrada = x"ef" else
			x"17" when entrada = x"f0" else
			x"2b" when entrada = x"f1" else
			x"04" when entrada = x"f2" else
			x"7e" when entrada = x"f3" else
			x"ba" when entrada = x"f4" else
			x"77" when entrada = x"f5" else
			x"d6" when entrada = x"f6" else
			x"26" when entrada = x"f7" else
			x"e1" when entrada = x"f8" else
			x"69" when entrada = x"f9" else
			x"14" when entrada = x"fa" else
			x"63" when entrada = x"fb" else
			x"55" when entrada = x"fc" else
			x"21" when entrada = x"fd" else
			x"0c" when entrada = x"fe" else
			x"7d" when entrada = x"ff";	
	end generate DECRYPT;								
end comp;

