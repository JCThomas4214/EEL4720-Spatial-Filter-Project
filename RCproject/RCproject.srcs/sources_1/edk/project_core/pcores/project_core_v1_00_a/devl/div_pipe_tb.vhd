--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:20:53 03/12/2015
-- Design Name:   
-- Module Name:   C:/Reconfigurable/Final_2/RCSemeserProject/RCSemesterProject.srcs/sources_1/edk/module_1/pcores/project_core_v1_00_a/devl/projnav/div_pipe_tb.vhd
-- Project Name:  project_core
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: div_pipe
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
 
ENTITY div_pipe_tb IS
END div_pipe_tb;
 
ARCHITECTURE behavior OF div_pipe_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT div_pipe
    PORT(
         num : IN  std_logic_vector(7 downto 0);
         denom : IN  std_logic_vector(7 downto 0);
         clk : IN  std_logic;
         rst : IN  std_logic;
         en : IN  std_logic;
         result : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal num : std_logic_vector(7 downto 0) := (others => '0');
   signal denom : std_logic_vector(7 downto 0) := (others => '0');
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal en : std_logic := '0';

 	--Outputs
   signal result : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: div_pipe PORT MAP (
          num => num,
          denom => denom,
          clk => clk,
          rst => rst,
          en => en,
          result => result
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
		rst<='1';
		wait for 100 ns;
		rst<='0';
		wait for 100 ns;
		en<='1';
		num<="10000000";
		denom<="00000010";
		wait for 100 ns;
		wait for 100 ns;
		num<="00010000";
		denom<="00001000";
		wait for 100 ns;
		wait for 100 ns;
		num<="01000000";
		denom<="00000100";
		wait for 100 ns;

      wait;
   end process;

END;
