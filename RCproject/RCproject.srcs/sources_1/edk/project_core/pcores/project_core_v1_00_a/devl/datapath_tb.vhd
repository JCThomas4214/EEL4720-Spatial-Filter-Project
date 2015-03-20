--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:10:22 03/13/2015
-- Design Name:   
-- Module Name:   C:/FP/RCProject/trunk/RCSemesterProject/RCSemesterProject.srcs/sources_1/edk/module_1/pcores/project_core_v1_00_a/devl/projnav/datapath_tb.vhd
-- Project Name:  project_core
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: datapath
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
 
ENTITY datapath_tb IS
END datapath_tb;
 
ARCHITECTURE behavior OF datapath_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT datapath
    PORT(
         p_1 : IN  std_logic_vector(7 downto 0);
         p_2 : IN  std_logic_vector(7 downto 0);
         p_3 : IN  std_logic_vector(7 downto 0);
         q_1 : IN  std_logic_vector(7 downto 0);
         q_2 : IN  std_logic_vector(7 downto 0);
         q_3 : IN  std_logic_vector(7 downto 0);
         r_1 : IN  std_logic_vector(7 downto 0);
         r_2 : IN  std_logic_vector(7 downto 0);
         r_3 : IN  std_logic_vector(7 downto 0);
         en : IN  std_logic;
         clk : IN  std_logic;
         rst : IN  std_logic;
			valid_in:IN std_logic;
			valid_out:OUT std_logic;
         a_1 : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal p_1 : std_logic_vector(7 downto 0) := (others => '0');
   signal p_2 : std_logic_vector(7 downto 0) := (others => '0');
   signal p_3 : std_logic_vector(7 downto 0) := (others => '0');
   signal q_1 : std_logic_vector(7 downto 0) := (others => '0');
   signal q_2 : std_logic_vector(7 downto 0) := (others => '0');
   signal q_3 : std_logic_vector(7 downto 0) := (others => '0');
   signal r_1 : std_logic_vector(7 downto 0) := (others => '0');
   signal r_2 : std_logic_vector(7 downto 0) := (others => '0');
   signal r_3 : std_logic_vector(7 downto 0) := (others => '0');
   signal en : std_logic := '0';
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
	signal valid_in: std_logic := '0';

 	--Outputs
   signal a_1 : std_logic_vector(7 downto 0);
	signal valid_out : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: datapath PORT MAP (
          p_1 => p_1,
          p_2 => p_2,
          p_3 => p_3,
          q_1 => q_1,
          q_2 => q_2,
          q_3 => q_3,
          r_1 => r_1,
          r_2 => r_2,
          r_3 => r_3,
          en => en,
          clk => clk,
          rst => rst,
			 valid_in=>valid_in,
			 valid_out=>valid_out,
          a_1 => a_1
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
		r_1<="00001000";
		r_2<="00001000";
		r_3<="00001000";
		p_1<="00001000";
		p_2<="01111111";
		p_3<="00001000";
		q_1<="00001000";
		q_2<="00001000";
		q_3<="00001000";
		rst<='1';
		wait for 100 ns;
		rst<='0';
		en<='1';
		valid_in<='1';
		wait for 10 ns;
		r_1<="00000100";
		r_2<="00001000";
		r_3<="00001100";
		p_1<="00011000";
		p_2<="11111111";
		p_3<="00001111";
		q_1<="00011000";
		q_2<="00001100";
		q_3<="00000001";
		wait for 10 ns;
		r_1<="00000100";
		r_2<="00001000";
		r_3<="00001100";
		p_1<="00011000";
		p_2<="00001111";
		p_3<="00001111";
		q_1<="00011000";
		q_2<="00001100";
		q_3<="00000001";
		wait for 10 ns;
		r_1<="10000100";
		r_2<="00001000";
		r_3<="00001100";
		p_1<="00011000";
		p_2<="00000001";
		p_3<="00001111";
		q_1<="00011000";
		q_2<="00001100";
		q_3<="01000001";
		wait for 10 ns;
		valid_in<='0';
      wait;
   end process;

END;
