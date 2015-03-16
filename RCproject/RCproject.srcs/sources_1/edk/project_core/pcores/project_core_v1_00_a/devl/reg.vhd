----------------------------------------------------------------------------------
-- Lab 1 Part 5: Register
-- Author: Jonathan Ganyer
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:57:19 01/15/2015 
-- Design Name: 
-- Module Name:    reg - Behavioral 
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

entity reg is
  generic (
    width  :     positive);
  port (
    clk    : in  std_logic;
    rst    : in  std_logic;
    en     : in  std_logic;
    input  : in  std_logic_vector(width-1 downto 0);
    output : out std_logic_vector(width-1 downto 0));
end reg;

architecture BHV of reg is
begin
  process(clk, rst)
  begin
    if (rst = '1') then
      output   <= (others => '0');
    elsif (clk'event and clk = '1') then
      if (en = '1') then
        output <= input;
      end if;
    end if;
  end process;
end BHV;
