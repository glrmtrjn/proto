library IEEE;
use IEEE.std_logic_1164.all;

entity keySchedule is
	port(
		clk,rst, loadKey : in std_logic; 
		strKey : out std_logic_vector(1 to 3)
	);
end keySchedule;

architecture crypt of keySchedule is
	signal strdKeys : integer range 0 to 3 := 0; 
begin

	strKey <= 
	"100" when loadkey = '1' and strdKeys = 0 else
	"010" when loadkey = '1' and strdKeys = 1 else
	"001" when loadkey = '1' and strdKeys = 2 else
	"000";
	

process(clk)
	begin
		if(clk'event and clk = '1')then
			if(rst = '1')then
				strdKeys <= 0;
			else
				if(loadkey = '1')then					
					if(strdKeys < 3 )then
						strdKeys <= strdKeys + 1;
					else
						strdKeys <= 0;
					end if;
				end if;
			end if;		
		end if;
	end process;
	
end crypt;
