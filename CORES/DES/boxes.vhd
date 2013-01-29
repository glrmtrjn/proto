

library IEEE;
use IEEE.std_logic_1164.all;
entity shift is 
	port( entrada: in std_logic_vector(1 to 56);
		passo: in std_logic;
		saida: out std_logic_vector(1 to 56)	
	);
end shift;

-- para esquerda
architecture crypt of shift is
begin
	saida <= entrada(2 to 28) & entrada(1) & entrada(30 to 56) & entrada(29) when passo = '0' else
					entrada(3 to 28) & entrada(1 to 2) & entrada(31 to 56) & entrada(29 to 30) ;
end crypt;


-------------------------------------------------
--+ Compression Permution
-------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity CompressionPer is 
	port (entrada : in std_logic_vector(1 to 56);
		saida : out std_logic_vector(1 to 48));
end CompressionPer;

architecture comp of CompressionPer is
begin

	saida<=
	entrada(14)&
	entrada(17)&
	entrada(11)&
	entrada(24)&
	entrada(1)&
	entrada(5)&
	entrada(3)&
	entrada(28)&
	entrada(15)&
	entrada(6)&
	entrada(21)&
	entrada(10)&

	entrada(23)&
	entrada(19)&
	entrada(12)&
	entrada(4)&
	entrada(26)&
	entrada(8)&
	entrada(16)&
	entrada(7)&
	entrada(27)&
	entrada(20)&
	entrada(13)&
	entrada(2)&

	entrada(41)&
	entrada(52)&
	entrada(31)&
	entrada(37)&
	entrada(47)&
	entrada(55)&
	entrada(30)&
	entrada(40)&
	entrada(51)&
	entrada(45)&
	entrada(33)&
	entrada(48)&

	entrada(44)&
	entrada(49)&
	entrada(39)&
	entrada(56)&
	entrada(34)&
	entrada(53)&
	entrada(46)&
	entrada(42)&
	entrada(50)&
	entrada(36)&
	entrada(29)&
	entrada(32);

end comp;







--------------------------------------------------
--+ Expansion permutation
--------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity E_box is 
	port (entrada : in std_logic_vector(1 to 32);
		saida : out std_logic_vector(1 to 48));
end E_box;
architecture comp of E_box is
begin

	saida(1)<=entrada(32);
	saida(2 to 6)<=entrada(1 to 5);
	saida(7 to 8)<=entrada(4 to 5);
	saida(9 to 12)<=entrada(6 to 9);
	saida(13 to 14)<=entrada(8 to 9);
	saida(15 to 18)<=entrada(10 to 13);
	saida(19 to 20)<=entrada(12 to 13);
	saida(21 to 24)<=entrada(14 to 17);
	saida(25 to 26)<=entrada(16 to 17);
	saida(27 to 30)<=entrada(18 to 21);
	saida(31 to 32)<=entrada(20 to 21);
	saida(33 to 36)<=entrada(22 to 25);
	saida(37 to 38)<=entrada(24 to 25);
	saida(39 to 42)<=entrada(26 to 29);
	saida(43 to 44)<=entrada(28 to 29);
	saida(45 to 47)<=entrada(30 to 32);
	saida(48)<=entrada(1);

end comp;




--------------------------------------------------
--+ Final permutation
--------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity FinalPer is 
	port (entrada : in std_logic_vector(1 to 64);
		saida : out std_logic_vector(1 to 64));
end FinalPer;

architecture comp of FinalPer is
begin

	saida<=
		entrada(40)&
		entrada(8)&
		entrada(48)&
		entrada(16)&
		entrada(56)&
		entrada(24)&
		entrada(64)&
		entrada(32)&
		entrada(39)&
		entrada(7)&
		entrada(47)&
		entrada(15)&
		entrada(55)&
		entrada(23)&
		entrada(63)&
		entrada(31)&
		entrada(38)&
		entrada(6)&
		entrada(46)&
		entrada(14)&
		entrada(54)&
		entrada(22)&
		entrada(62)&
		entrada(30)&
		entrada(37)&
		entrada(5)&
		entrada(45)&
		entrada(13)&
		entrada(53)&
		entrada(21)&
		entrada(61)&
		entrada(29)&
		entrada(36)&
		entrada(4)&
		entrada(44)&
		entrada(12)&
		entrada(52)&
		entrada(20)&
		entrada(60)&
		entrada(28)&
		entrada(35)&
		entrada(3)&
		entrada(43)&
		entrada(11)&
		entrada(51)&
		entrada(19)&
		entrada(59)&
		entrada(27)&
		entrada(34)&
		entrada(2)&
		entrada(42)&
		entrada(10)&
		entrada(50)&
		entrada(18)&
		entrada(58)&
		entrada(26)&
		entrada(33)&
		entrada(1)&
		entrada(41)&
		entrada(9)&
		entrada(49)&
		entrada(17)&
		entrada(57)&
		entrada(25);

end comp;







--------------------------------------------------
--+ initial permutation
--------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity InitialPer is 
	port (entrada : in std_logic_vector(1 to 64);
		saida : out std_logic_vector(1 to 64));
end InitialPer;
architecture comp of InitialPer is
begin

	saida<=
		entrada(58)&
		entrada(50)&
		entrada(42)&
		entrada(34)&
		entrada(26)&
		entrada(18)&
		entrada(10)&
		entrada(2)&
		entrada(60)&
		entrada(52)&
		entrada(44)&
		entrada(36)&
		entrada(28)&
		entrada(20)&
		entrada(12)&
		entrada(4)&

		entrada(62)&
		entrada(54)&
		entrada(46)&
		entrada(38)&
		entrada(30)&
		entrada(22)&
		entrada(14)&
		entrada(6)&
		entrada(64)&
		entrada(56)&
		entrada(48)&
		entrada(40)&
		entrada(32)&
		entrada(24)&
		entrada(16)&
		entrada(8)&

		entrada(57)&
		entrada(49)&
		entrada(41)&
		entrada(33)&
		entrada(25)&
		entrada(17)&
		entrada(9)&
		entrada(1)&
		entrada(59)&
		entrada(51)&
		entrada(43)&
		entrada(35)&
		entrada(27)&
		entrada(19)&
		entrada(11)&
		entrada(3)&

		entrada(61)&
		entrada(53)&
		entrada(45)&
		entrada(37)&
		entrada(29)&
		entrada(21)&
		entrada(13)&
		entrada(5)&
		entrada(63)&
		entrada(55)&
		entrada(47)&
		entrada(39)&
		entrada(31)&
		entrada(23)&
		entrada(15)&
		entrada(7);

end comp;




--------------------------------------------------
--+ Key permutation
--------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity keyInitialPer is 
	port (entrada : in std_logic_vector(1 to 64);
		saida : out std_logic_vector(1 to 56));
end keyInitialPer;
architecture comp of keyInitialPer is
begin
	saida <=
		entrada(57)&
		entrada(49)&
		entrada(41)&
		entrada(33)&
		entrada(25)&
		entrada(17)&
		entrada(9)&
		entrada(1)&
		entrada(58)&
		entrada(50)&
		entrada(42)&
		entrada(34)&
		entrada(26)&
		entrada(18)&

		entrada(10)&
		entrada(2)&
		entrada(59)&
		entrada(51)&
		entrada(43)&
		entrada(35)&
		entrada(27)&
		entrada(19)&
		entrada(11)&
		entrada(3)&
		entrada(60)&
		entrada(52)&
		entrada(44)&
		entrada(36)&

		entrada(63)&
		entrada(55)&
		entrada(47)&
		entrada(39)&
		entrada(31)&
		entrada(23)&
		entrada(15)&
		entrada(7)&
		entrada(62)&
		entrada(54)&
		entrada(46)&
		entrada(38)&
		entrada(30)&
		entrada(22)&

		entrada(14)&
		entrada(6)&
		entrada(61)&
		entrada(53)&
		entrada(45)&
		entrada(37)&
		entrada(29)&
		entrada(21)&
		entrada(13)&
		entrada(5)&
		entrada(28)&
		entrada(20)&
		entrada(12)&
		entrada(4);
end comp;




--------------------------------------------------
--+ Permutation Box
--------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity P_box is 
	port (entrada : in std_logic_vector(1 to 32);
		saida : out std_logic_vector(1 to 32));
end P_box;
architecture comp of P_box is
begin

	saida<=
		entrada(16)&
		entrada(7)&
		entrada(20)&
		entrada(21)&
		entrada(29)&
		entrada(12)&
		entrada(28)&
		entrada(17)&
		entrada(1)&
		entrada(15)&
		entrada(23)&
		entrada(26)&
		entrada(5)&
		entrada(18)&
		entrada(31)&
		entrada(10)&
		entrada(2)&
		entrada(8)&
		entrada(24)&
		entrada(14)&
		entrada(32)&
		entrada(27)&
		entrada(3)&
		entrada(9)&
		entrada(19)&
		entrada(13)&
		entrada(30)&
		entrada(6)&
		entrada(22)&
		entrada(11)&
		entrada(4)&
		entrada(25);

end comp;

--------------------------------------------------
--+ S-Box
--------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity S_box is
	port (
		entrada: in std_logic_vector(1 to 48);
		saida: out std_logic_vector(1 to 32));
end S_box;

architecture comp of S_box is
begin
	S1: entity work.sminibox1
		port map(
			entrada=>entrada(1 to 6),
			saida=>saida(1 to 4)
		);
		
		
	S2: entity work.sminibox2
		port map(
			entrada=>entrada(7 to 12),
			saida=>saida(5 to 8)
		);
		
		
	S3: entity work.sminibox3
		port map(
			entrada=>entrada(13 to 18),
			saida=>saida(9 to 12)
		);
		
		
	S4: entity work.sminibox4
		port map(
			entrada=>entrada(19 to 24),
			saida=>saida(13 to 16)
		);
		
	S5: entity work.sminibox5
		port map(
			entrada=>entrada(25 to 30),
			saida=>saida(17 to 20)
		);
		
	S6: entity work.sminibox6
		port map(
			entrada=>entrada(31 to 36),
			saida=>saida(21 to 24)
		);
		
		
	S7: entity work.sminibox7
		port map(
			entrada=>entrada(37 to 42),
			saida=>saida(25 to 28)
		);
		
		
	S8: entity work.sminibox8
		port map(
			entrada=>entrada(43 to 48),
			saida=>saida(29 to 32)
		);
		
end comp;


--------------------------------------------------
--+ S-Box1
--------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity sminibox1 is 
	port (entrada : in std_logic_vector(1 to 6);
		saida : out std_logic_vector(1 to 4));
end sminibox1;
architecture comp of sminibox1 is
	signal teste : std_logic_vector(1 to 8);
begin
teste<= "00" & entrada;
process(teste)
begin
case teste is
	when x"00" => saida <= x"e"; 
	when x"02" => saida <= x"4"; 
	when x"04" => saida <= x"d"; 
	when x"06" => saida <= x"1"; 
	when x"08" => saida <= x"2"; 
	when x"0a" => saida <= x"f"; 
	when x"0c" => saida <= x"b"; 
	when x"0e" => saida <= x"8"; 
	when x"10" => saida <= x"3"; 
	when x"12" => saida <= x"a"; 
	when x"14" => saida <= x"6"; 
	when x"16" => saida <= x"c"; 
	when x"18" => saida <= x"5"; 
	when x"1a" => saida <= x"9"; 
	when x"1c" => saida <= x"0"; 
	when x"1e" => saida <= x"7"; 

	when x"01" => saida <= x"0"; 
	when x"03" => saida <= x"f"; 
	when x"05" => saida <= x"7"; 
	when x"07" => saida <= x"4"; 
	when x"09" => saida <= x"e"; 
	when x"0b" => saida <= x"2"; 
	when x"0d" => saida <= x"d"; 
	when x"0f" => saida <= x"1"; 
	when x"11" => saida <= x"a"; 
	when x"13" => saida <= x"6"; 
	when x"15" => saida <= x"c"; 
	when x"17" => saida <= x"b"; 
	when x"19" => saida <= x"9"; 
	when x"1b" => saida <= x"5"; 
	when x"1d" => saida <= x"3";
 
	when x"1f" => saida <= x"8"; 
	when x"20" => saida <= x"4"; 
	when x"22" => saida <= x"1"; 
	when x"24" => saida <= x"e"; 
	when x"26" => saida <= x"8";
	when x"28" => saida <= x"d"; 
	when x"2a" => saida <= x"6"; 
	when x"2c" => saida <= x"2"; 
	when x"2e" => saida <= x"b"; 
	when x"30" => saida <= x"f"; 
	when x"32" => saida <= x"c"; 
	when x"34" => saida <= x"9"; 
	when x"36" => saida <= x"7"; 
	when x"38" => saida <= x"3"; 
	when x"3a" => saida <= x"a"; 
	when x"3c" => saida <= x"5"; 
	when x"3e" => saida <= x"0";
 
	when x"21" => saida <= x"f"; 
	when x"23" => saida <= x"c"; 
	when x"25" => saida <= x"8"; 
	when x"27" => saida <= x"2"; 
	when x"29" => saida <= x"4"; 
	when x"2b" => saida <= x"9"; 
	when x"2d" => saida <= x"1"; 
	when x"2f" => saida <= x"7"; 
	when x"31" => saida <= x"5"; 
	when x"33" => saida <= x"b"; 
	when x"35" => saida <= x"3"; 
	when x"37" => saida <= x"e"; 
	when x"39" => saida <= x"a"; 
	when x"3b" => saida <= x"0"; 
	when x"3d" => saida <= x"6"; 
	when others => saida <= x"d"; 
end case;
end process;
end comp;

--------------------------------------------------
--+ S-Box2
--------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity sminibox2 is 
	port (entrada : in std_logic_vector(1 to 6);
		saida : out std_logic_vector(1 to 4));
end sminibox2;
architecture comp of sminibox2 is
	signal teste : std_logic_vector(1 to 8);
begin
teste<= "00" & entrada;
process(teste)
begin
case teste is
	when x"00" => saida <= x"f"; 
	when x"02" => saida <= x"1"; 
	when x"04" => saida <= x"8"; 
	when x"06" => saida <= x"e"; 
	when x"08" => saida <= x"6"; 
	when x"0a" => saida <= x"b"; 
	when x"0c" => saida <= x"3"; 
	when x"0e" => saida <= x"4"; 
	when x"10" => saida <= x"9"; 
	when x"12" => saida <= x"7"; 
	when x"14" => saida <= x"2"; 
	when x"16" => saida <= x"d"; 
	when x"18" => saida <= x"c"; 
	when x"1a" => saida <= x"0"; 
	when x"1c" => saida <= x"5"; 
	when x"1e" => saida <= x"a"; 

	when x"01" => saida <= x"3"; 
	when x"03" => saida <= x"d"; 
	when x"05" => saida <= x"4"; 
	when x"07" => saida <= x"7"; 
	when x"09" => saida <= x"f"; 
	when x"0b" => saida <= x"2"; 
	when x"0d" => saida <= x"8"; 
	when x"0f" => saida <= x"e"; 
	when x"11" => saida <= x"c"; 
	when x"13" => saida <= x"0"; 
	when x"15" => saida <= x"1"; 
	when x"17" => saida <= x"a"; 
	when x"19" => saida <= x"6"; 
	when x"1b" => saida <= x"9"; 
	when x"1d" => saida <= x"b"; 
	when x"1f" => saida <= x"5";
 
	when x"20" => saida <= x"0"; 
	when x"22" => saida <= x"e"; 
	when x"24" => saida <= x"7"; 
	when x"26" => saida <= x"b"; 
	when x"28" => saida <= x"a"; 
	when x"2a" => saida <= x"4"; 
	when x"2c" => saida <= x"d"; 
	when x"2e" => saida <= x"1"; 
	when x"30" => saida <= x"5"; 
	when x"32" => saida <= x"8"; 
	when x"34" => saida <= x"c"; 
	when x"36" => saida <= x"6"; 
	when x"38" => saida <= x"9"; 
	when x"3a" => saida <= x"3"; 
	when x"3c" => saida <= x"2"; 
	when x"3e" => saida <= x"f"; 

	when x"21" => saida <= x"d"; 
	when x"23" => saida <= x"8"; 
	when x"25" => saida <= x"a"; 
	when x"27" => saida <= x"1"; 
	when x"29" => saida <= x"3"; 
	when x"2b" => saida <= x"f"; 
	when x"2d" => saida <= x"4"; 
	when x"2f" => saida <= x"2"; 
	when x"31" => saida <= x"b"; 
	when x"33" => saida <= x"6"; 
	when x"35" => saida <= x"7"; 
	when x"37" => saida <= x"c"; 
	when x"39" => saida <= x"0"; 
	when x"3b" => saida <= x"5"; 
	when x"3d" => saida <= x"e"; 
	when others => saida <= x"9";
end case;
end process;
end comp;
--------------------------------------------------
--+ S-Box3
--------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity sminibox3 is 
	port (entrada : in std_logic_vector(1 to 6);
		saida : out std_logic_vector(1 to 4));
end sminibox3;
architecture comp of sminibox3 is
	signal teste : std_logic_vector(1 to 8);
begin
teste<= "00" & entrada;
process(teste)
begin
case teste is
	when x"00" => saida <= x"a"; 
	when x"02" => saida <= x"0"; 
	when x"04" => saida <= x"9"; 
	when x"06" => saida <= x"e"; 
	when x"08" => saida <= x"6"; 
	when x"0a" => saida <= x"3"; 
	when x"0c" => saida <= x"f"; 
	when x"0e" => saida <= x"5"; 
	when x"10" => saida <= x"1"; 
	when x"12" => saida <= x"d"; 
	when x"14" => saida <= x"c"; 
	when x"16" => saida <= x"7"; 
	when x"18" => saida <= x"b"; 
	when x"1a" => saida <= x"4"; 
	when x"1c" => saida <= x"2"; 
	when x"1e" => saida <= x"8"; 
	when x"01" => saida <= x"d"; 
	when x"03" => saida <= x"7"; 
	when x"05" => saida <= x"0"; 
	when x"07" => saida <= x"9"; 
	when x"09" => saida <= x"3"; 
	when x"0b" => saida <= x"4"; 
	when x"0d" => saida <= x"6"; 
	when x"0f" => saida <= x"a"; 
	when x"11" => saida <= x"2"; 
	when x"13" => saida <= x"8"; 
	when x"15" => saida <= x"5"; 
	when x"17" => saida <= x"e"; 
	when x"19" => saida <= x"c"; 
	when x"1b" => saida <= x"b"; 
	when x"1d" => saida <= x"f"; 
	when x"1f" => saida <= x"1"; 
	when x"20" => saida <= x"d"; 
	when x"22" => saida <= x"6"; 
	when x"24" => saida <= x"4"; 
	when x"26" => saida <= x"9"; 
	when x"28" => saida <= x"8"; 
	when x"2a" => saida <= x"f"; 
	when x"2c" => saida <= x"3"; 
	when x"2e" => saida <= x"0"; 
	when x"30" => saida <= x"b"; 
	when x"32" => saida <= x"1"; 
	when x"34" => saida <= x"2"; 
	when x"36" => saida <= x"c"; 
	when x"38" => saida <= x"5"; 
	when x"3a" => saida <= x"a"; 
	when x"3c" => saida <= x"e"; 
	when x"3e" => saida <= x"7"; 
	when x"21" => saida <= x"1"; 
	when x"23" => saida <= x"a"; 
	when x"25" => saida <= x"d"; 
	when x"27" => saida <= x"0"; 
	when x"29" => saida <= x"6"; 
	when x"2b" => saida <= x"9"; 
	when x"2d" => saida <= x"8"; 
	when x"2f" => saida <= x"7"; 
	when x"31" => saida <= x"4"; 
	when x"33" => saida <= x"f"; 
	when x"35" => saida <= x"e"; 
	when x"37" => saida <= x"3"; 
	when x"39" => saida <= x"b"; 
	when x"3b" => saida <= x"5"; 
	when x"3d" => saida <= x"2"; 
	when others => saida <= x"c";
end case;
end process;
end comp;
--------------------------------------------------
--+ S-Box4
--------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity sminibox4 is 
	port (entrada : in std_logic_vector(1 to 6);
		saida : out std_logic_vector(1 to 4));
end sminibox4;
architecture comp of sminibox4 is
	signal teste : std_logic_vector(1 to 8);
begin
teste<= "00" & entrada; 
process(teste)
begin
case teste is
	when x"00" => saida <= x"7"; 
	when x"02" => saida <= x"d"; 
	when x"04" => saida <= x"e"; 
	when x"06" => saida <= x"3"; 
	when x"08" => saida <= x"0"; 
	when x"0a" => saida <= x"6"; 
	when x"0c" => saida <= x"9"; 
	when x"0e" => saida <= x"a"; 
	when x"10" => saida <= x"1"; 
	when x"12" => saida <= x"2"; 
	when x"14" => saida <= x"8"; 
	when x"16" => saida <= x"5"; 
	when x"18" => saida <= x"b"; 
	when x"1a" => saida <= x"c"; 
	when x"1c" => saida <= x"4"; 
	when x"1e" => saida <= x"f"; 
	when x"01" => saida <= x"d"; 
	when x"03" => saida <= x"8"; 
	when x"05" => saida <= x"b"; 
	when x"07" => saida <= x"5"; 
	when x"09" => saida <= x"6"; 
	when x"0b" => saida <= x"f"; 
	when x"0d" => saida <= x"0"; 
	when x"0f" => saida <= x"3"; 
	when x"11" => saida <= x"4"; 
	when x"13" => saida <= x"7"; 
	when x"15" => saida <= x"2"; 
	when x"17" => saida <= x"c"; 
	when x"19" => saida <= x"1"; 
	when x"1b" => saida <= x"a"; 
	when x"1d" => saida <= x"e"; 
	when x"1f" => saida <= x"9"; 
	when x"20" => saida <= x"a"; 
	when x"22" => saida <= x"6"; 
	when x"24" => saida <= x"9"; 
	when x"26" => saida <= x"0"; 
	when x"28" => saida <= x"c"; 
	when x"2a" => saida <= x"b"; 
	when x"2c" => saida <= x"7"; 
	when x"2e" => saida <= x"d"; 
	when x"30" => saida <= x"f"; 
	when x"32" => saida <= x"1"; 
	when x"34" => saida <= x"3"; 
	when x"36" => saida <= x"e"; 
	when x"38" => saida <= x"5"; 
	when x"3a" => saida <= x"2"; 
	when x"3c" => saida <= x"8"; 
	when x"3e" => saida <= x"4"; 
	when x"21" => saida <= x"3"; 
	when x"23" => saida <= x"f"; 
	when x"25" => saida <= x"0"; 
	when x"27" => saida <= x"6"; 
	when x"29" => saida <= x"a"; 
	when x"2b" => saida <= x"1"; 
	when x"2d" => saida <= x"d"; 
	when x"2f" => saida <= x"8"; 
	when x"31" => saida <= x"9"; 
	when x"33" => saida <= x"4"; 
	when x"35" => saida <= x"5"; 
	when x"37" => saida <= x"b"; 
	when x"39" => saida <= x"c"; 
	when x"3b" => saida <= x"7"; 
	when x"3d" => saida <= x"2"; 
	when others => saida <= x"e"; 
end case;
end process;
end comp;
--------------------------------------------------
--+ S-Box5
--------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity sminibox5 is 
	port (entrada : in std_logic_vector(1 to 6);
		saida : out std_logic_vector(1 to 4));
end sminibox5;
architecture comp of sminibox5 is
	signal teste : std_logic_vector(1 to 8);
begin
teste<= "00" & entrada; 
process(teste)
begin
case teste is
	when x"00" => saida <= x"2"; 
	when x"02" => saida <= x"c"; 
	when x"04" => saida <= x"4"; 
	when x"06" => saida <= x"1"; 
	when x"08" => saida <= x"7"; 
	when x"0a" => saida <= x"a"; 
	when x"0c" => saida <= x"b"; 
	when x"0e" => saida <= x"6"; 
	when x"10" => saida <= x"8"; 
	when x"12" => saida <= x"5"; 
	when x"14" => saida <= x"3"; 
	when x"16" => saida <= x"f"; 
	when x"18" => saida <= x"d"; 
	when x"1a" => saida <= x"0"; 
	when x"1c" => saida <= x"e"; 
	when x"1e" => saida <= x"9"; 
	when x"01" => saida <= x"e"; 
	when x"03" => saida <= x"b"; 
	when x"05" => saida <= x"2"; 
	when x"07" => saida <= x"c"; 
	when x"09" => saida <= x"4"; 
	when x"0b" => saida <= x"7"; 
	when x"0d" => saida <= x"d"; 
	when x"0f" => saida <= x"1"; 
	when x"11" => saida <= x"5"; 
	when x"13" => saida <= x"0"; 
	when x"15" => saida <= x"f"; 
	when x"17" => saida <= x"a"; 
	when x"19" => saida <= x"3"; 
	when x"1b" => saida <= x"9"; 
	when x"1d" => saida <= x"8"; 
	when x"1f" => saida <= x"6"; 
	when x"20" => saida <= x"4"; 
	when x"22" => saida <= x"2"; 
	when x"24" => saida <= x"1"; 
	when x"26" => saida <= x"b"; 
	when x"28" => saida <= x"a"; 
	when x"2a" => saida <= x"d"; 
	when x"2c" => saida <= x"7"; 
	when x"2e" => saida <= x"8"; 
	when x"30" => saida <= x"f"; 
	when x"32" => saida <= x"9"; 
	when x"34" => saida <= x"c"; 
	when x"36" => saida <= x"5"; 
	when x"38" => saida <= x"6"; 
	when x"3a" => saida <= x"3"; 
	when x"3c" => saida <= x"0"; 
	when x"3e" => saida <= x"e"; 
	when x"21" => saida <= x"b"; 
	when x"23" => saida <= x"8"; 
	when x"25" => saida <= x"c"; 
	when x"27" => saida <= x"7"; 
	when x"29" => saida <= x"1"; 
	when x"2b" => saida <= x"e"; 
	when x"2d" => saida <= x"2"; 
	when x"2f" => saida <= x"d"; 
	when x"31" => saida <= x"6"; 
	when x"33" => saida <= x"f"; 
	when x"35" => saida <= x"0"; 
	when x"37" => saida <= x"9"; 
	when x"39" => saida <= x"a"; 
	when x"3b" => saida <= x"4"; 
	when x"3d" => saida <= x"5"; 
	when others => saida <= x"3"; 
end case;
end process;
end comp;
--------------------------------------------------
--+ S-Box6
--------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity sminibox6 is 
	port (entrada : in std_logic_vector(1 to 6);
		saida : out std_logic_vector(1 to 4));
end sminibox6;
architecture comp of sminibox6 is
	signal teste : std_logic_vector(1 to 8);
begin
teste<= "00" & entrada;  
process(teste)
begin
case teste is
	when x"00" => saida <= x"c"; 
	when x"02" => saida <= x"1"; 
	when x"04" => saida <= x"a"; 
	when x"06" => saida <= x"f"; 
	when x"08" => saida <= x"9"; 
	when x"0a" => saida <= x"2"; 
	when x"0c" => saida <= x"6"; 
	when x"0e" => saida <= x"8"; 
	when x"10" => saida <= x"0"; 
	when x"12" => saida <= x"d"; 
	when x"14" => saida <= x"3"; 
	when x"16" => saida <= x"4"; 
	when x"18" => saida <= x"e"; 
	when x"1a" => saida <= x"7"; 
	when x"1c" => saida <= x"5"; 
	when x"1e" => saida <= x"b"; 
	when x"01" => saida <= x"a"; 
	when x"03" => saida <= x"f"; 
	when x"05" => saida <= x"4"; 
	when x"07" => saida <= x"2"; 
	when x"09" => saida <= x"7"; 
	when x"0b" => saida <= x"c"; 
	when x"0d" => saida <= x"9"; 
	when x"0f" => saida <= x"5"; 
	when x"11" => saida <= x"6"; 
	when x"13" => saida <= x"1"; 
	when x"15" => saida <= x"d"; 
	when x"17" => saida <= x"e"; 
	when x"19" => saida <= x"0"; 
	when x"1b" => saida <= x"b"; 
	when x"1d" => saida <= x"3"; 
	when x"1f" => saida <= x"8"; 
	when x"20" => saida <= x"9"; 
	when x"22" => saida <= x"e"; 
	when x"24" => saida <= x"f"; 
	when x"26" => saida <= x"5"; 
	when x"28" => saida <= x"2"; 
	when x"2a" => saida <= x"8"; 
	when x"2c" => saida <= x"c"; 
	when x"2e" => saida <= x"3"; 
	when x"30" => saida <= x"7"; 
	when x"32" => saida <= x"0"; 
	when x"34" => saida <= x"4"; 
	when x"36" => saida <= x"a"; 
	when x"38" => saida <= x"1"; 
	when x"3a" => saida <= x"d"; 
	when x"3c" => saida <= x"b"; 
	when x"3e" => saida <= x"6"; 
	when x"21" => saida <= x"4"; 
	when x"23" => saida <= x"3"; 
	when x"25" => saida <= x"2"; 
	when x"27" => saida <= x"c"; 
	when x"29" => saida <= x"9"; 
	when x"2b" => saida <= x"5"; 
	when x"2d" => saida <= x"f"; 
	when x"2f" => saida <= x"a"; 
	when x"31" => saida <= x"b"; 
	when x"33" => saida <= x"e"; 
	when x"35" => saida <= x"1"; 
	when x"37" => saida <= x"7"; 
	when x"39" => saida <= x"6"; 
	when x"3b" => saida <= x"0"; 
	when x"3d" => saida <= x"8"; 
	when others => saida <= x"d";
end case;
end process;
end comp;
--------------------------------------------------
--+ S-Box7
--------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity sminibox7 is 
	port (entrada : in std_logic_vector(1 to 6);
		saida : out std_logic_vector(1 to 4));
end sminibox7;
architecture comp of sminibox7 is
	signal teste : std_logic_vector(1 to 8);
begin
teste<= "00" & entrada;  
process(teste)
begin
case teste is
	when x"00" => saida <= x"4"; 
	when x"02" => saida <= x"b"; 
	when x"04" => saida <= x"2"; 
	when x"06" => saida <= x"e"; 
	when x"08" => saida <= x"f"; 
	when x"0a" => saida <= x"0"; 
	when x"0c" => saida <= x"8"; 
	when x"0e" => saida <= x"d"; 
	when x"10" => saida <= x"3"; 
	when x"12" => saida <= x"c"; 
	when x"14" => saida <= x"9"; 
	when x"16" => saida <= x"7"; 
	when x"18" => saida <= x"5"; 
	when x"1a" => saida <= x"a"; 
	when x"1c" => saida <= x"6"; 
	when x"1e" => saida <= x"1"; 
	when x"01" => saida <= x"d"; 
	when x"03" => saida <= x"0"; 
	when x"05" => saida <= x"b"; 
	when x"07" => saida <= x"7"; 
	when x"09" => saida <= x"4"; 
	when x"0b" => saida <= x"9"; 
	when x"0d" => saida <= x"1"; 
	when x"0f" => saida <= x"a"; 
	when x"11" => saida <= x"e"; 
	when x"13" => saida <= x"3"; 
	when x"15" => saida <= x"5"; 
	when x"17" => saida <= x"c"; 
	when x"19" => saida <= x"2"; 
	when x"1b" => saida <= x"f"; 
	when x"1d" => saida <= x"8"; 
	when x"1f" => saida <= x"6"; 
	when x"20" => saida <= x"1"; 
	when x"22" => saida <= x"4"; 
	when x"24" => saida <= x"b"; 
	when x"26" => saida <= x"d"; 
	when x"28" => saida <= x"c"; 
	when x"2a" => saida <= x"3"; 
	when x"2c" => saida <= x"7"; 
	when x"2e" => saida <= x"e"; 
	when x"30" => saida <= x"a"; 
	when x"32" => saida <= x"f"; 
	when x"34" => saida <= x"6"; 
	when x"36" => saida <= x"8"; 
	when x"38" => saida <= x"0"; 
	when x"3a" => saida <= x"5"; 
	when x"3c" => saida <= x"9"; 
	when x"3e" => saida <= x"2"; 
	when x"21" => saida <= x"6"; 
	when x"23" => saida <= x"b"; 
	when x"25" => saida <= x"d"; 
	when x"27" => saida <= x"8"; 
	when x"29" => saida <= x"1"; 
	when x"2b" => saida <= x"4"; 
	when x"2d" => saida <= x"a"; 
	when x"2f" => saida <= x"7"; 
	when x"31" => saida <= x"9"; 
	when x"33" => saida <= x"5"; 
	when x"35" => saida <= x"0"; 
	when x"37" => saida <= x"f"; 
	when x"39" => saida <= x"e"; 
	when x"3b" => saida <= x"2"; 
	when x"3d" => saida <= x"3"; 
	when others => saida <= x"c"; 
end case;
end process;
end comp;
--------------------------------------------------
--+ S-Box8
--------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity sminibox8 is 
	port (entrada : in std_logic_vector(1 to 6);
		saida : out std_logic_vector(1 to 4));
end sminibox8;
architecture comp of sminibox8 is
	signal teste : std_logic_vector(1 to 8);
begin
teste<= "00" & entrada; 
process(teste)
begin
case teste is
	when x"00" => saida <= x"d"; 
	when x"02" => saida <= x"2"; 
	when x"04" => saida <= x"8"; 
	when x"06" => saida <= x"4"; 
	when x"08" => saida <= x"6"; 
	when x"0a" => saida <= x"f"; 
	when x"0c" => saida <= x"b"; 
	when x"0e" => saida <= x"1"; 
	when x"10" => saida <= x"a"; 
	when x"12" => saida <= x"9"; 
	when x"14" => saida <= x"3"; 
	when x"16" => saida <= x"e"; 
	when x"18" => saida <= x"5"; 
	when x"1a" => saida <= x"0"; 
	when x"1c" => saida <= x"c"; 
	when x"1e" => saida <= x"7"; 
	when x"01" => saida <= x"1"; 
	when x"03" => saida <= x"f"; 
	when x"05" => saida <= x"d"; 
	when x"07" => saida <= x"8"; 
	when x"09" => saida <= x"a"; 
	when x"0b" => saida <= x"3"; 
	when x"0d" => saida <= x"7"; 
	when x"0f" => saida <= x"4"; 
	when x"11" => saida <= x"c"; 
	when x"13" => saida <= x"5"; 
	when x"15" => saida <= x"6"; 
	when x"17" => saida <= x"b"; 
	when x"19" => saida <= x"0"; 
	when x"1b" => saida <= x"e"; 
	when x"1d" => saida <= x"9"; 
	when x"1f" => saida <= x"2"; 
	when x"20" => saida <= x"7"; 
	when x"22" => saida <= x"b"; 
	when x"24" => saida <= x"4"; 
	when x"26" => saida <= x"1"; 
	when x"28" => saida <= x"9"; 
	when x"2a" => saida <= x"c"; 
	when x"2c" => saida <= x"e"; 
	when x"2e" => saida <= x"2"; 
	when x"30" => saida <= x"0"; 
	when x"32" => saida <= x"6"; 
	when x"34" => saida <= x"a"; 
	when x"36" => saida <= x"d"; 
	when x"38" => saida <= x"f"; 
	when x"3a" => saida <= x"3"; 
	when x"3c" => saida <= x"5"; 
	when x"3e" => saida <= x"8"; 
	when x"21" => saida <= x"2"; 
	when x"23" => saida <= x"1"; 
	when x"25" => saida <= x"e"; 
	when x"27" => saida <= x"7"; 
	when x"29" => saida <= x"4"; 
	when x"2b" => saida <= x"a"; 
	when x"2d" => saida <= x"8"; 
	when x"2f" => saida <= x"d"; 
	when x"31" => saida <= x"f"; 
	when x"33" => saida <= x"c"; 
	when x"35" => saida <= x"9"; 
	when x"37" => saida <= x"0"; 
	when x"39" => saida <= x"3"; 
	when x"3b" => saida <= x"5"; 
	when x"3d" => saida <= x"6"; 
	when others => saida <= x"b"; 
end case;
end process;
end comp;


