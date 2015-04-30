----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:40:51 04/21/2015 
-- Design Name: 
-- Module Name:    clk_timer - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clk_timer is generic(width : positive := 16);
    Port ( start_stop : in  STD_LOGIC := '0';
           reset : in  STD_LOGIC := '0';
			  clk : in STD_LOGIC := '0';
           output : out  STD_LOGIC_VECTOR (width-1 downto 0) := (others => '0'));
end clk_timer;

architecture Behavioral of clk_timer is
	signal count : unsigned(width-1 downto 0) := (others => '0');

begin
process(clk, reset)
begin
	if (reset = '1') then
		count <= (others => '0');
	elsif (clk'event and clk = '1') then
		if (start_stop = '1') then
			count <= count + 1;
		else
			count <= count;
		end if;
	end if;
	output <= std_logic_vector(count);
end process;
end Behavioral;

