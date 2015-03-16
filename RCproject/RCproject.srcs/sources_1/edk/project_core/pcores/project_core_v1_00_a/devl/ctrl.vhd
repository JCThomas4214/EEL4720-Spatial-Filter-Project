----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:15:52 03/15/2015 
-- Design Name: 
-- Module Name:    ctrl - Behavioral 
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

entity ctrl is
generic(width : positive := 8);
port (
	en, rst, clk : in std_logic := '0';
	row_length : in std_logic_vector(10 downto 0);	
	pixel_count : in std_logic_vector(20 downto 0) := (others => '0');
	p_out, r_out, q_out : out std_logic_vector(width-1 downto 0) := (others => '0');
	dp_en, dp_rst : out std_logic := '0'
);
end ctrl;

architecture Behavioral of ctrl is

	signal itr : unsigned(20 downto 0) := (others => '0');
	signal pixel_un : unsigned(20 downto 0);
	signal row_un : unsigned(10 downto 0);
	signal p_un, q_un, r_un : signed(width-1 downto 0);

begin
	process(en, rst, clk, itr)
	begin
		dp_en <= '0';
		dp_rst <= '0';
	
		pixel_un <= unsigned(pixel_count);
		row_un <= unsigned(row_length);
		itr <= (pixel_un / row_un) mod 3;	
			if rst = '1' then
				dp_rst <= '1';			
			elsif en = '1' then
				dp_en <= '1';							
				if itr = 0 then
					p_un <= to_signed(-1, width);
					q_un <= to_signed(9, width);
					r_un <= to_signed(-1, width);	
				end if;
				if itr = 1 then
					p_un <= to_signed(-1, width);
					q_un <= to_signed(-1, width);
					r_un <= to_signed(9, width);
				end if;
				if itr = 2 then
					p_un <= to_signed(9, width);
					q_un <= to_signed(-1, width);
					r_un <= to_signed(-1, width);
				end if;
			end if;			
		
	end process;
	p_out <= std_logic_vector(p_un);
	q_out <= std_logic_vector(q_un);
	r_out <= std_logic_vector(r_un);
end Behavioral;

