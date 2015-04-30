----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:44:50 03/03/2015 
-- Design Name: 
-- Module Name:    addr_gen - Behavioral 
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
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity addr_gen is
GENERIC(width: positive := 14);
PORT(
		rst		:	IN STD_LOGIC;
		count_en	:	IN STD_LOGIC;
		clk		:	IN STD_LOGIC;		
		count_out:	OUT STD_LOGIC_VECTOR(width-1 downto 0));
end addr_gen;

architecture Behavioral of addr_gen is
signal count: unsigned(width-1 downto 0);
begin
	PROCESS(clk,rst)
	BEGIN
		IF(rst = '1') THEN
			count <= (OTHERS => '0');		
		ELSIF(clk'EVENT AND clk='1') THEN
			IF(count_en='1') THEN				
				count<=count+1;		
			ELSE
				count<=count;
			END IF;
		END IF;
	END PROCESS;
	count_out<=std_logic_vector(count);	
end Behavioral;

