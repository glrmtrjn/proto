library IEEE;
use IEEE.STD_LOGIC_1164.all;

package P_AES is

	type MODO is (CRYPT, DECRYPT);
	type coluna is array (0 to 3) of std_logic_vector(7 downto 0);
	type matriz is array (0 to 3) of coluna; 

	function vector2matriz(V : std_logic_vector(127 downto 0)) return matriz;
	function matriz2vector(M : matriz) return std_logic_vector;
end package;

package body P_AES is	
	function vector2matriz(V : std_logic_vector(127 downto 0)) return matriz is 
	variable result : matriz;
	begin
	
		result(0)(0) := V(127 downto 120);
		result(1)(0) := V(119 downto 112);
		result(2)(0) := V(111 downto 104);
		result(3)(0) := V(103 downto 96);
		
		result(0)(1) := V(95 downto 88);
		result(1)(1) := V(87 downto 80);		
		result(2)(1) := V(79 downto 72);
		result(3)(1) := V(71 downto 64);
		
		result(0)(2) := V(63 downto 56);
		result(1)(2) := V(55 downto 48);
		result(2)(2) := V(47 downto 40);
		result(3)(2) := V(39 downto 32);
		
		result(0)(3) := V(31 downto 24);
		result(1)(3) := V(23 downto 16);
		result(2)(3) := V(15 downto 8);
		result(3)(3) := V(7 downto 0);
		
		return result;
		
	end function vector2matriz;
	
	function matriz2vector(M : matriz) return std_logic_vector is 
	variable result : std_logic_vector(127 downto 0);
	begin
		result(127 downto 120) := M(0)(0);
		result(119 downto 112) := M(1)(0);
		result(111 downto 104) := M(2)(0);
		result(103 downto 96) := M(3)(0);
		
		result(95 downto 88) := M(0)(1);
		result(87 downto 80) := M(1)(1);
		result(79 downto 72) := M(2)(1);
		result(71 downto 64) := M(3)(1);
		
		result(63 downto 56) := M(0)(2);
		result(55 downto 48) := M(1)(2);
		result(47 downto 40) := M(2)(2);
		result(39 downto 32) := M(3)(2);
		
		result(31 downto 24) := M(0)(3);
		result(23 downto 16) := M(1)(3);
		result(15 downto 8) := M(2)(3);
		result(7 downto 0) := M(3)(3);
		
		return result;
		
	end function matriz2vector;
end package body;

