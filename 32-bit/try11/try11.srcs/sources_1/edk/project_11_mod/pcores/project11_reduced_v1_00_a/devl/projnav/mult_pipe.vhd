----------------------------------------------------------------------------------
-- Lab 1 Part 4: Pipelined Multiplier
-- Author: Jonathan Ganyer
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mult_pipe is
  generic (
    width  :     positive := 8);
  port (
    clk    : in  std_logic;
    rst    : in  std_logic;
    en     : in  std_logic;
    in1    : in  std_logic_vector(width-1 downto 0);
    in2    : in  std_logic_vector(width-1 downto 0);
    output : out std_logic_vector(width*2-1 downto 0));
end mult_pipe;

-- TODO: Implement a behavioral description of a pipelined multiplier (i.e., a
-- multiplier with a register on the output). The output should be twice as
-- wide as the input and should use the "width" generic as opposed to being
-- hardcoded to a specific value. Note that the "*" operator automatically
-- returns a value whose width is the sum of the widths of the inputs.

architecture BHV of mult_pipe is
signal in1_sign: signed(width downto 0);
signal in2_sign: signed(width downto 0);
signal mult_temp: signed(17 downto 0);
begin
in1_sign<='0' & signed(in1);
in2_sign<=resize(signed(in2), 9);
mult_temp<=in1_sign*in2_sign;
process(clk,rst,in2)
begin
	IF(rst='1') THEN output<=(OTHERS=>'0');
	ELSIF(clk'EVENT AND clk='1') THEN
		IF(en='1') THEN
			output<=std_logic_vector(resize(mult_temp, 16));
		END IF;
	END IF;
end process;
end BHV;

