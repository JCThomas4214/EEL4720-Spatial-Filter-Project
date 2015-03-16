--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:02:31 03/14/2015
-- Design Name:   
-- Module Name:   C:/RCProject/trunk/RCSemesterProject/RCSemesterProject.srcs/sources_1/edk/module_1/pcores/project_core_v1_00_a/devl/projnav/smart_buff_tb.vhd
-- Project Name:  project_core
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: smart_buff
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY smart_buff_tb IS
END smart_buff_tb;
 
ARCHITECTURE behavior OF smart_buff_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT smart_buff
    PORT(
         clk : IN  std_logic;
         en : IN  std_logic;
			rst : IN std_logic;
         input : IN  std_logic_vector(71 downto 0);
         output : OUT  std_logic_vector(143 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk, rst : std_logic := '0';
   signal en : std_logic := '0';
   signal input : std_logic_vector(71 downto 0) := (others => '0');

 	--Outputs
   signal output : std_logic_vector(143 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: smart_buff PORT MAP (
          clk => clk,
			 rst => rst,
          en => en,
          input => input,
          output => output
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;		

      -- insert stimulus here 
		
		en <= '1';
		
		input <= x"0F0F0F0F0F0F0F0F0F";
		
		wait for 10 ns;
		
		input <= x"010101010101010101";
		
		wait for 10 ns;
		
		input <= x"123456789ABCDEF012";
		
		wait for 10 ns;
		
		input <= x"210FEDCBA987654321";

      wait;
   end process;

END;
