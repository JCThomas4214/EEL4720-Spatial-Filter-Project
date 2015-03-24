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
	dp_rst, sb_rst, addr_gen_rst, dp_en, sb_en : out std_logic := '0';
	done, inputAddr, inputMem, valid_in : out std_logic := '0';
	bramout_we,bramout_en					: out std_logic := '0'
);
end master_ctrl;

architecture Behavioral of master_ctrl is

	type CtrlState is (init, wait_0, inLatency, go_0, outLatency, done_0);
	signal state, nextstate : CtrlState := Init;
	signal count1, count2 : unsigned(7 downto 0) := (others => '0');
	signal row_un, col_un : unsigned(10 downto 0) := (others => '0');
	signal max_pixel : unsigned(21 downto 0) := (others => '0');
	signal pixel : unsigned(20 downto 0) := (others => '0');

begin
	row_un <= unsigned(row_length);
	col_un <= unsigned(col_length);
	max_pixel <= (row_un-2) * col_un;

	process(rst, clk)
	begin
		
		dp_rst <= '0';
		sb_rst <= '0';
		addr_gen_rst <= '0';		
	
		if rst = '1' then			
			sb_rst <= '1';
			dp_rst <= '1';			
			addr_gen_rst <= '1';
		elsif (clk'event and clk = '1') then		
			state <= nextstate;		
			if state = inLatency then
				if count1 >= 2 then -- 2 is the # of clocks before the smart buffer outputs fully
					state <= go_0;
				else 
					count1 <= count1 + 1;
				end if;			
			elsif state = go_0 then
				if pixel > (max_pixel) then 
					state <= outLatency;
				else
					pixel <= pixel + 72;
				end if;
			elsif state = outLatency then 
				if count2 > 8 then	-- 8 is the # of clocks before the the last pixels output through the datapath
					state <= done_0;
				else
					count2 <= count2 + 1;
				end if;
			end if;
		end if;
	end process;

	process(state, go)
	begin
		done <= '0';
		inputAddr <= '0';	
		inputMem <= '0';
		sb_en <= '0';
		dp_en <= '0';
		valid_in <= '0';
		bramout_we <= '0';
		bramout_en <= '0';
		
		case state is
			when init => 
				nextstate <= wait_0;
			when wait_0 =>
				if go = '1' then
					inputAddr <= '1';	
					inputMem <= '1';
					sb_en <= '1';										
					nextstate <= inLatency;
				end if;
			when inLatency =>
				inputAddr <= '1';	
				inputMem <= '1';
				sb_en <= '1';				
				nextstate <= inLatency;
			when go_0 => 
				valid_in <= '1';
				inputAddr <= '1';	
				inputMem <= '1';	
				dp_en <= '1';
				sb_en <= '1';
				bramout_we <= '1';
				bramout_en <= '1';
				nextstate <= go_0;
			when outLatency =>
				dp_en <= '1';
				bramout_we <= '1';
				bramout_en <= '1';
				nextstate <= outLatency;
			when done_0 =>
				done <= '1';
				nextstate <= done_0;
		end case;
	end process;	
end Behavioral;

