----------------------------------------------------------------------------------
-- Lab 1 Part 3: Pipeline Adder
-- Author: Jonathan Ganyer
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:44:25 01/15/2015 
-- Design Name: 
-- Module Name:    add_pipe - Behavioral 
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

entity add_pipe is
  generic (
    width  :     positive := 16);
  port (
    clk    : in  std_logic;
    rst    : in  std_logic;
    en     : in  std_logic;
    in1    : in  std_logic_vector(width-1 downto 0);
    in2    : in  std_logic_vector(width-1 downto 0);
    output : out std_logic_vector(width downto 0));
end add_pipe;

-- TODO: Implement a behavioral description of a pipelined adder (i.e., an
-- adder with a register on the output). The output should be one bit larger
-- than the input, and should use the "width" generic as opposed to being
-- hardcoded to a specific value.

architecture BHV of add_pipe is
signal temp_in1: signed(width downto 0) := (OTHERS=>'0');
signal temp_in2: signed(width downto 0) := (OTHERS=>'0');
signal temp_add: signed(width downto 0) := (OTHERS=>'0');
begin
temp_in1<=signed('0' & in1);
temp_in2<=signed('0' & in2);
temp_add<=temp_in1+temp_in2;
process(clk,rst)
begin
	IF(rst='1') THEN output<=(OTHERS=>'0');
	ELSIF(clk'EVENT AND clk='1') THEN
		IF(en='1') THEN output<=std_logic_vector(temp_add);
		END IF;
	END IF;
end process;
end BHV;

