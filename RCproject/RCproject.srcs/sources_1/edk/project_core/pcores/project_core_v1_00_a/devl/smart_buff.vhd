----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:55:49 03/14/2015 
-- Design Name: 
-- Module Name:    smart_buff - Behavioral 
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

entity smart_buff is
port (
	clk, en, rst : in std_logic := '0';
	input : in std_logic_vector(71 downto 0) := (others => '0');
	output : out std_logic_vector(143 downto 0) := (others => '0')
);
end smart_buff;

architecture Behavioral of smart_buff is

	signal tmp : std_logic_vector(143 downto 0) := (others => '0');
	signal tmpOLD : std_logic_vector(71 downto 0) := (others => '0');
	signal tmpNEW : std_logic_vector(71 downto 0) := (others => '0');

begin
	process(rst, clk)
	begin
		if rst = '1' then
			tmp <= (others => '0');
		elsif (clk'event and clk = '1') then
			if en = '1' then
				tmpNEW <= input;
				tmp <= tmpNEW & tmpOLD;
				tmpOLD <= tmpNEW;				
			end if;			
		end if;		
	end process;
	output <= tmp;	
end Behavioral;

