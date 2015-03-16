----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:39:58 03/12/2015 
-- Design Name: 
-- Module Name:    datapath - Behavioral 
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity datapath is
GENERIC(width : positive := 8);
PORT(
		p_1	:	IN std_logic_vector(width-1 downto 0);
		p_2	:	IN std_logic_vector(width-1 downto 0);
		p_3	:	IN std_logic_vector(width-1 downto 0);
		q_1	:	IN std_logic_vector(width-1 downto 0);
		q_2	:	IN std_logic_vector(width-1 downto 0);
		q_3	:	IN std_logic_vector(width-1 downto 0);
		r_1	:	IN std_logic_vector(width-1 downto 0);
		r_2	:	IN std_logic_vector(width-1 downto 0);
		r_3	:	IN std_logic_vector(width-1 downto 0);
		en		:	IN std_logic;
		clk	:	IN std_logic;
		rst	:	IN std_logic;
		a_1	: OUT std_logic_vector(width-1 downto 0));
end datapath;

architecture Behavioral of datapath is
constant neg_one: std_logic_vector(7 downto 0) := "11111111";
constant nine:	std_logic_vector(15 downto 0) := "0000000000001001";
constant zero: std_logic_vector (7 downto 0) := "00000000";
signal r1_multout,r2_multout,r3_multout,p1_multout,p2_multout,p3_multout,q1_multout,q2_multout,q3_multout, all_divout : std_logic_vector(15 downto 0) := (OTHERS=>'0'); 
signal r1r2_addout,r3p1_addout, p2p3_addout, q1q2_addout, q3_regout1, q3_regout2, q3_regout3, r1r2r3p1_addout, p2p3q1q2_addout, r1r2r3p1p2p3q1q2_addout, all_addout: std_logic_vector(15 downto 0) := (OTHERS=>'0');
signal mux_out: std_logic_vector(7 downto 0) := "00000000";
signal neg_muxin: std_logic := '0';
component add_pipe
generic (width  :     positive := 16);
PORT(
    clk    : in  std_logic;
    rst    : in  std_logic;
    en     : in  std_logic;
    in1    : in  std_logic_vector(width-1 downto 0);
    in2    : in  std_logic_vector(width-1 downto 0);
    output : out std_logic_vector(width-1 downto 0));
end component;
component comparator
GENERIC(width : positive := 8);
PORT(
		input:	IN std_logic_vector(width-1 downto 0);
		greater_equal:	OUT std_logic);
end component;
component div_pipe
GENERIC(width : positive := 16);
PORT(
		num        :IN STD_LOGIC_VECTOR(width-1 downto 0);
		denom		  :IN STD_LOGIC_VECTOR(width-1 downto 0);
		clk		  :IN STD_LOGIC;
		rst		  :IN STD_LOGIC;	
		en			  :IN STD_LOGIC;
		result	  :OUT STD_LOGIC_VECTOR(width-1 downto 0));
end component;
component mult_pipe
GENERIC(width  :     positive := 8);
PORT (
    clk    : in  std_logic;
    rst    : in  std_logic;
    en     : in  std_logic;
    in1    : in  std_logic_vector(width-1 downto 0);
    in2    : in  std_logic_vector(width-1 downto 0);
    output : out std_logic_vector(width*2-1 downto 0));
end component;
component mux
GENERIC(width : POSITIVE := 32);
PORT ( 
  sel : in  STD_LOGIC;
  in0: in STD_LOGIC_VECTOR(width-1 downto 0);
  in1: in STD_LOGIC_VECTOR(width-1 downto 0);
  output: out STD_LOGIC_VECTOR(width-1 downto 0));
end component;
component reg
GENERIC(width  :     positive := 8);
PORT (
    clk    : in  std_logic;
    rst    : in  std_logic;
    en     : in  std_logic;
    input  : in  std_logic_vector(width-1 downto 0);
    output : out std_logic_vector(width-1 downto 0));
end component;
begin
--Stage 1 Pipeline
MULT_R1: mult_pipe
PORT MAP(clk=>clk,
			rst=>rst,
			en=>en,
			in1=>r_1,
			in2=>neg_one,
			output=>r1_multout);
MULT_R2: mult_pipe
PORT MAP(clk=>clk,
			rst=>rst,
			en=>en,
			in1=>r_2,
			in2=>neg_one,
			output=>r2_multout);
MULT_R3: mult_pipe
PORT MAP(clk=>clk,
			rst=>rst,
			en=>en,
			in1=>r_3,
			in2=>neg_one,
			output=>r3_multout);
MULT_P1: mult_pipe
PORT MAP(clk=>clk,
			rst=>rst,
			en=>en,
			in1=>p_1,
			in2=>neg_one,
			output=>p1_multout);
MULT_P2: mult_pipe
PORT MAP(clk=>clk,
			rst=>rst,
			en=>en,
			in1=>p_2,
			in2=>nine(7 downto 0),
			output=>p2_multout);
MULT_P3: mult_pipe
PORT MAP(clk=>clk,
			rst=>rst,
			en=>en,
			in1=>p_3,
			in2=>neg_one,
			output=>p3_multout);
MULT_Q1: mult_pipe
PORT MAP(clk=>clk,
			rst=>rst,
			en=>en,
			in1=>q_1,
			in2=>neg_one,
			output=>q1_multout);
MULT_Q2: mult_pipe
PORT MAP(clk=>clk,
			rst=>rst,
			en=>en,
			in1=>q_2,
			in2=>neg_one,
			output=>q2_multout);
MULT_Q3: mult_pipe
PORT MAP(clk=>clk,
			rst=>rst,
			en=>en,
			in1=>q_3,
			in2=>neg_one,
			output=>q3_multout);
--Stage 2 Pipeline
ADD_R1R2: add_pipe
PORT MAP(clk=>clk,
			rst=>rst,
			en=>en,
			in1=>r1_multout,
			in2=>r2_multout,
			output=>r1r2_addout);
ADD_R3P1: add_pipe
PORT MAP(clk=>clk,
			rst=>rst,
			en=>en,
			in1=>r3_multout,
			in2=>p1_multout,
			output=>r3p1_addout);
ADD_P2P3: add_pipe
PORT MAP(clk=>clk,
			rst=>rst,
			en=>en,
			in1=>p2_multout,
			in2=>p3_multout,
			output=>p2p3_addout);
ADD_Q1Q2: add_pipe
PORT MAP(clk=>clk,
			rst=>rst,
			en=>en,
			in1=>q1_multout,
			in2=>q2_multout,
			output=>q1q2_addout);
REG1_Q3: reg
GENERIC MAP(width=>16)
PORT MAP(clk=>clk,
			rst=>rst,
			en=>en,
			input=>q3_multout,
			output=>q3_regout1);
--Stage 3 Pipeline
ADD_R1R2R3P1: add_pipe
PORT MAP(clk=>clk,
			rst=>rst,
			en=>en,
			in1=>r1r2_addout,
			in2=>r3p1_addout,
			output=>r1r2r3p1_addout);
ADD_P2P3Q1Q2: add_pipe
PORT MAP(clk=>clk,
			rst=>rst,
			en=>en,
			in1=>p2p3_addout,
			in2=>q1q2_addout,
			output=>p2p3q1q2_addout);
REG2_Q3: reg
GENERIC MAP(width=>16)
PORT MAP(clk=>clk,
			rst=>rst,
			en=>en,
			input=>q3_regout1,
			output=>q3_regout2);
--Stage 4 Pipeline
ADD_R1R2R3P1P2P3Q1Q2: add_pipe
PORT MAP(clk=>clk,
			rst=>rst,
			en=>en,
			in1=>r1r2r3p1_addout,
			in2=>p2p3q1q2_addout,
			output=>r1r2r3p1p2p3q1q2_addout);
REG3_Q3: reg
GENERIC MAP(width=>16)
PORT MAP(clk=>clk,
			rst=>rst,
			en=>en,
			input=>q3_regout2,
			output=>q3_regout3);
--Stage 5 Pipeline
ADD_ALL: add_pipe
PORT MAP(clk=>clk,
			rst=>rst,
			en=>en,
			in1=>r1r2r3p1p2p3q1q2_addout,
			in2=>q3_regout3,
			output=>all_addout);
--Stage 6 Pipeline
DIVIDE_ALL: div_pipe
PORT MAP(num=>all_addout,
			denom=>nine,
			clk=>clk,
			rst=>rst,
			en=>en,
			result=>all_divout);
--Stage 7 Pipeline
NEG_CHECK: comparator
GENERIC MAP(width=>16)
PORT MAP(input=>all_divout,
			greater_equal=>neg_muxin);
MUX_CHECK: mux
GENERIC MAP(width=>8)
PORT MAP(sel=>neg_muxin,
			in0=>zero,
			in1=>all_divout(7 downto 0),
			output=>mux_out);
OUT_REG: reg
PORT MAP(clk=>clk,
			rst=>rst,
			en=>en,
			input=>mux_out,
			output=>a_1);
end Behavioral;

