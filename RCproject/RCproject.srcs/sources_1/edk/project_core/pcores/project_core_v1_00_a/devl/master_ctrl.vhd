----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:58:41 03/15/2015 
-- Design Name: 
-- Module Name:    master_ctrl - Behavioral 
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

entity master_ctrl is
generic(width : positive := 8);
port(
	go, clk, rst : in std_logic := '0';
	row_length, col_length : in std_logic_vector(10 downto 0) := (others => '0');
	ctrl_rst, sb_rst, addr_gen_rst, ctrl_en, smart_buff_en, done, INaddrEN : out std_logic := '0';
	pixel_count : out std_logic_vector(20 downto 0) := (others => '0')
);
end master_ctrl;

architecture Behavioral of master_ctrl is

	type CtrlState is (init, wait_0, latency, go_0, done_0);
	signal state, nextstate : CtrlState := Init;
	signal count : unsigned(7 downto 0) := (others => '0');
	signal row_un, col_un : unsigned(10 downto 0) := (others => '0');
	signal max_pixel : unsigned(21 downto 0) := (others => '0');
	signal pixel : unsigned(20 downto 0) := (others => '0');

begin
	row_un <= unsigned(row_length);
	col_un <= unsigned(col_length);
	max_pixel <= row_un * col_un;

	process(rst, clk)
	begin
		
		ctrl_rst <= '0';
		sb_rst <= '0';
		addr_gen_rst <= '0';
		ctrl_en <= '0';
	
		if rst = '1' then
			ctrl_rst <= '1';
			sb_rst <= '1';
			addr_gen_rst <= '1';
		elsif (clk'event and clk = '1') then		
			state <= nextstate;		
			if state = latency then
				if count >= 11 then
					state <= go_0;
				else 
					count <= count + 1;
				end if;
			end if;
			if state = go_0 then
				if pixel >= max_pixel then
					state <= done_0;
				else
					pixel <= pixel + 9;
				end if;
			end if;
		end if;
	end process;

	process(state, go)
	begin
		done <= '0';
		INaddrEN <= '0';
		
		case state is
			when init => 
				nextstate <= wait_0;
			when wait_0 =>
				if go = '1' then
					INaddrEN <= '1';
					nextstate <= latency;
				end if;
			when latency =>
				INaddrEN <= '1';
				nextstate <= latency;
			when go_0 => 
				INaddrEN <= '1';
				nextstate <= go_0;
			when done_0 =>
				done <= '1';
				nextstate <= done_0;
		end case;
	end process;
	pixel_count <= std_logic_vector(pixel);
end Behavioral;

