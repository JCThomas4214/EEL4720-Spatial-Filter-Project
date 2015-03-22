--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:53:37 03/15/2015
-- Design Name:   
-- Module Name:   C:/RCProject/trunk/RCSemesterProject/RCSemesterProject.srcs/sources_1/edk/module_1/pcores/project_core_v1_00_a/devl/projnav/master_ctrl_tb.vhd
-- Project Name:  project_core
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: master_ctrl
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
USE ieee.numeric_std.ALL;
 
ENTITY master_ctrl_tb IS
END master_ctrl_tb;
 
ARCHITECTURE behavior OF master_ctrl_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT master_ctrl
    PORT(
         go : IN  std_logic;
         clk : IN  std_logic;
         rst : IN  std_logic;
         row_length : IN  std_logic_vector(10 downto 0);
         col_length : IN  std_logic_vector(10 downto 0);
         dp_rst : OUT  std_logic;
         sb_rst : OUT  std_logic;
         addr_gen_rst : OUT  std_logic;
         dp_en : OUT  std_logic;
         sb_en : OUT  std_logic;
         done : OUT  std_logic;
         inputAddr : OUT  std_logic;
			inputMem : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal go : std_logic := '0';
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal row_length : std_logic_vector(10 downto 0) := (others => '0');
   signal col_length : std_logic_vector(10 downto 0) := (others => '0');

 	--Outputs
   signal dp_rst : std_logic;
   signal sb_rst : std_logic;
   signal addr_gen_rst : std_logic;
   signal dp_en : std_logic;
   signal sb_en : std_logic;
   signal done : std_logic;
   signal inputAddr : std_logic; 
	signal inputMem : std_logic;	

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: master_ctrl PORT MAP (
          go => go,
          clk => clk,
          rst => rst,
          row_length => row_length,
          col_length => col_length,
          dp_rst => dp_rst,
          sb_rst => sb_rst,
          addr_gen_rst => addr_gen_rst,
          dp_en => dp_en,
          sb_en => sb_en,
          done => done,
          inputAddr => inputAddr,
			 inputMem => inputMem
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
		rst <= '1';
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		row_length <= std_logic_vector(to_unsigned(64,11));
		col_length <= std_logic_vector(to_unsigned(64,11));
      wait for clk_period*10;

      -- insert stimulus here 
		rst <= '0';
		go <= '1';
		wait for 20 ns;
		go<= '0';
		

      wait;
   end process;

END;
