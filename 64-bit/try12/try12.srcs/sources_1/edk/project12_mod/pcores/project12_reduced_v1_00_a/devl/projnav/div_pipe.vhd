----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:07:01 03/12/2015 
-- Design Name: 
-- Module Name:    div_pipe - Behavioral 
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

entity div_pipe is
GENERIC(width : positive := 16);
PORT(
		num        :IN STD_LOGIC_VECTOR(width-1 downto 0);
		denom		  :IN STD_LOGIC_VECTOR(width-1 downto 0);
		clk		  :IN STD_LOGIC;
		rst		  :IN STD_LOGIC;	
		en			  :IN STD_LOGIC;
		result:		OUT STD_LOGIC_VECTOR(width-1 downto 0));
end div_pipe;

architecture Behavioral of div_pipe is
signal num_signed: signed(width-1 downto 0) := (OTHERS=>'0');
signal denom_signed: signed(width-1 downto 0) := "0000000000000001";
--signal result_signed: signed(width-1 downto 0) := (OTHERS=>'0');
begin
num_signed<=signed(num);
denom_signed<=signed(denom);
--result_signed<=num_signed/denom_signed;
PROCESS(clk,rst)
	BEGIN
		IF(rst='1') THEN result<=(OTHERS=>'0');
		ELSIF(clk'EVENT AND clk='1') THEN
			IF(en='1') THEN
					result<=std_logic_vector(num_signed/denom_signed);
			END IF;
		END IF;
END PROCESS;
end Behavioral;

