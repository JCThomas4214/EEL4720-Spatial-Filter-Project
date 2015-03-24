--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:55:24 03/22/2015
-- Design Name:   
-- Module Name:   C:/FP/RCProject/trunk/RCproject/RCproject.srcs/sources_1/edk/project_core/pcores/project_core_v1_00_a/devl/projnav/test_tb.vhd
-- Project Name:  project_core
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: top_level
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
use ieee.numeric_std.all;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY test_tb IS
END test_tb;
 
ARCHITECTURE behavior OF test_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT top_level
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         go : IN  std_logic;
         done : OUT  std_logic;
         rdata_out : OUT  std_logic_vector(71 downto 0);
         raddr_out : IN  std_logic_vector(9 downto 0);
         rd_en : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal go : std_logic := '0';
   signal raddr_out : std_logic_vector(9 downto 0) := (others => '0');
   signal rd_en : std_logic := '0';

 	--Outputs
   signal done : std_logic;
   signal rdata_out : std_logic_vector(71 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: top_level PORT MAP (
          clk => clk,
          reset => reset,
          go => go,
          done => done,
          rdata_out => rdata_out,
          raddr_out => raddr_out,
          rd_en => rd_en
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
		reset<='1';
		wait for 25 ns;
		reset<='0';
		wait for 25 ns;
		go<='1';
		wait for 25 ns;
		go<='0';
		wait for 20 us;
      raddr_out<="0000000000";
      rd_en<='1';
		wait for 50 ns;
		raddr_out<="0000000001";
		wait for 50 ns;
		raddr_out<="0000000010";
		wait for 50 ns;
		raddr_out<="0000000011";
		wait for 50 ns;
		raddr_out<="0000000100";
		wait for 50 ns;
		raddr_out<="0000000101";
		wait for 50 ns;
		raddr_out<="0000000110";
		wait for 50 ns;
		raddr_out<="0000000111";
		wait for 50 ns;
		raddr_out<="0000001000";
		wait for 50 ns;
		raddr_out<="0000001001";
		wait for 50 ns;
		raddr_out<="0000000001";
		wait for 50 ns;
		raddr_out<="0000000000";
		wait for 50 ns;
		FOR i in 0 to 906 LOOP
			raddr_out<=std_logic_vector(unsigned(raddr_out)+1);
			wait for 50 ns;
		END LOOP;
      wait;
   end process;

END;
