----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:37:23 03/12/2015 
-- Design Name: 
-- Module Name:    comparator - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity comparator is
GENERIC(width : positive := 8);
port(
		input:	IN std_logic_vector(width-1 downto 0);
		greater_equal:	OUT std_logic);
end comparator;

architecture Behavioral of comparator is
signal signed_input: signed(width-1 downto 0) := (OTHERS=>'0');
signal zero : signed(width-1 downto 0) := (OTHERS=>'0');
begin
signed_input<=signed(input);
PROCESS(signed_input)
	BEGIN
		IF(signed_input>=zero) THEN
			greater_equal<='1';
		ELSE
			greater_equal<='0';
		END IF;
END PROCESS;
end Behavioral;

