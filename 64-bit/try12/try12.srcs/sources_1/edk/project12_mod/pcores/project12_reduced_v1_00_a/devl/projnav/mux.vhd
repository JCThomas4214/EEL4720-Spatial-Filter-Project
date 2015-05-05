
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity mux is
	GENERIC( width : POSITIVE := 32);
    Port ( sel : in  STD_LOGIC;
			  in0: in STD_LOGIC_VECTOR(width-1 downto 0);
			  in1: in STD_LOGIC_VECTOR(width-1 downto 0);
			  output: out STD_LOGIC_VECTOR(width-1 downto 0));
end mux;

architecture Behavioral of mux is

begin

PROCESS(in0,in1,sel)
begin
	IF sel = '0' THEN output<=in0;
	ELSE output<=in1;
	END IF;
end process;
end Behavioral;

