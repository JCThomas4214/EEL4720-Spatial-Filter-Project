----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:21:39 03/19/2015 
-- Design Name: 
-- Module Name:    top_level - Behavioral 
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

entity top_level is
generic(width : positive := 8);
port(	clk: 		IN std_logic;
		reset:	IN std_logic;
		go:		IN std_logic;
		done:		OUT std_logic;
		rdata_out:OUT std_logic_vector(31 downto 0);
		raddr_out:IN std_logic_vector(13 downto 0);
		rd_en		:IN std_logic;
		timingCount :OUT std_logic_vector(31 downto 0) := (others => '0'));		
end top_level;

architecture Behavioral of top_level is
--Signal Declarations
signal bramr_outbuff,bramp_outbuff,bramq_outbuff, a_1_buff,bramout_data_buff: std_logic_vector(31 downto 0) := (OTHERS=>'0');
signal r_outbuff,p_outbuff,q_outbuff: std_logic_vector(63 downto 0) := (OTHERS=>'0');
signal ctrl_en_buff, countin_en_buff, countout_en_buff: std_logic := '0';
signal countin_addr_buff,countout_addr_buff,bramout_rdaddr_buff: std_logic_vector(13 downto 0) := (OTHERS=>'0');
signal bramout_rden_buff,bramout_wren_buff,bramout_we_buff,INaddrEN_buff, smart_en_buff: std_logic := '0';                                                                                
signal pixel_count_buff: std_logic_vector(20 downto 0) := (OTHERS=>'0');
signal dp_rst_buff,ctrl_rst_buff,sb_rst_buff,addr_gen_rst_buff, valid_in_buff, valid_out_buff: std_logic := '0';
signal dp_en_buff,buff,sb_en_buff,inputMem_buff,inputAddr_buff: std_logic := '0';
--Component Declarations
--Controller Declaration
COMPONENT master_ctrl
generic(width : positive := 8);
port(
	go, clk, rst : in std_logic := '0';
	row_length, col_length : in std_logic_vector(10 downto 0) := (others => '0');
	dp_rst, sb_rst, addr_gen_rst, dp_en, sb_en : out std_logic := '0';
	done, inputAddr, inputMem, valid_in: out std_logic := '0';
	bramout_we,bramout_en					: out std_logic := '0';
	timingCount :  OUT std_logic_vector(31 downto 0) := (others => '0')
);
END COMPONENT;
--Smart Buffer Declaration
COMPONENT smart_buff
port (
	clk, en, rst : in std_logic := '0';
	input : in std_logic_vector(31 downto 0) := (others => '0');
	output : out std_logic_vector(63 downto 0) := (others => '0')
);
END COMPONENT;
--Datapath Declaration
COMPONENT datapath
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
		valid_in:IN std_logic;
		valid_out:OUT std_logic;
		a_1	: OUT std_logic_vector(width-1 downto 0));
END COMPONENT;
--Address Generator Declaration
COMPONENT addr_gen
GENERIC(width: positive := 14);
PORT(
		rst		:	IN STD_LOGIC;
		count_en	:	IN STD_LOGIC;
		clk		:	IN STD_LOGIC;		
		count_out:	OUT STD_LOGIC_VECTOR(width-1 downto 0));
END COMPONENT;

--BRAM R Declaration
COMPONENT bramr
  PORT (
    clka : IN STD_LOGIC;
    ena : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(13 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    clkb : IN STD_LOGIC;
    enb : IN STD_LOGIC;
    addrb : IN STD_LOGIC_VECTOR(13 DOWNTO 0);
    doutb : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END COMPONENT;
--BRAM P Declaration
COMPONENT bramp
  PORT (
    clka : IN STD_LOGIC;
    ena : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(13 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    clkb : IN STD_LOGIC;
    enb : IN STD_LOGIC;
    addrb : IN STD_LOGIC_VECTOR(13 DOWNTO 0);
    doutb : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END COMPONENT;
--BRAM Q Declaration
COMPONENT bramq
  PORT (
    clka : IN STD_LOGIC;
    ena : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(13 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    clkb : IN STD_LOGIC;
    enb : IN STD_LOGIC;
    addrb : IN STD_LOGIC_VECTOR(13 DOWNTO 0);
    doutb : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END COMPONENT;
--BRAM Output Declaration
COMPONENT bramout
  PORT (
    clka : IN STD_LOGIC;
    ena : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(13 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    clkb : IN STD_LOGIC;
    enb : IN STD_LOGIC;
    addrb : IN STD_LOGIC_VECTOR(13 DOWNTO 0);
    doutb : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END COMPONENT;


begin
--Controller Port Map
MASTER: master_ctrl
PORT MAP(go=>go, 
			clk=>clk, 
			rst=>reset, 
			row_length=>std_logic_vector(to_unsigned(256,11)), 
			col_length=>std_logic_vector(to_unsigned(256,11)),
			dp_rst=>dp_rst_buff,
			sb_rst=>sb_rst_buff, 
			addr_gen_rst=>addr_gen_rst_buff,
			dp_en=>dp_en_buff,
			sb_en=>sb_en_buff,
			done=>done, 
			inputAddr=>inputAddr_buff,
			inputMem=>inputMem_buff,
			valid_in=>valid_in_buff,
			bramout_we=>bramout_we_buff,
			bramout_en=>bramout_wren_buff,
			timingCount => timingCount);
--3 Smart Buffer Port Map
R_BUFF: smart_buff 
PORT MAP(
	clk=>clk,
	en=>sb_en_buff, 
	rst=>sb_rst_buff, 
	input=>bramr_outbuff,
	output=>r_outbuff);
P_BUFF: smart_buff
PORT MAP(
	clk=>clk,
	en=>sb_en_buff, 
	rst=>sb_rst_buff, 
	input=>bramp_outbuff,
	output=>p_outbuff);
Q_BUFF: smart_buff
PORT MAP(
	clk=>clk,
	en=>sb_en_buff, 
	rst=>sb_rst_buff, 
	input=>bramq_outbuff,
	output=>q_outbuff);
--9 Datapath's Port Map
PATH1: datapath
PORT MAP(
		p_1=>p_outbuff(7 downto 0),
		p_2=>p_outbuff(15 downto 8),
		p_3=>p_outbuff(23 downto 16),
		q_1=>q_outbuff(7 downto 0),
		q_2=>q_outbuff(15 downto 8),
		q_3=>q_outbuff(23 downto 16),
		r_1=>r_outbuff(7 downto 0),
		r_2=>r_outbuff(15 downto 8),
		r_3=>r_outbuff(23 downto 16),
		en=>dp_en_buff,
		clk=>clk,
		rst=>dp_rst_buff,
		valid_in=>valid_in_buff,
		valid_out=>valid_out_buff,
		a_1=>a_1_buff(7 downto 0));
PATH2: datapath
PORT MAP(
		p_1=>p_outbuff(15 downto 8),
		p_2=>p_outbuff(23 downto 16),
		p_3=>p_outbuff(31 downto 24),
		q_1=>q_outbuff(15 downto 8),
		q_2=>q_outbuff(23 downto 16),
		q_3=>q_outbuff(31 downto 24),
		r_1=>r_outbuff(15 downto 8),
		r_2=>r_outbuff(23 downto 16),
		r_3=>r_outbuff(31 downto 24),
		en=>dp_en_buff,
		clk=>clk,
		rst=>dp_rst_buff,
		valid_in=>'0',
		a_1=>a_1_buff(15 downto 8));
PATH3: datapath
PORT MAP(
		p_1=>p_outbuff(23 downto 16),
		p_2=>p_outbuff(31 downto 24),
		p_3=>p_outbuff(39 downto 32),
		q_1=>q_outbuff(23 downto 16),
		q_2=>q_outbuff(31 downto 24),
		q_3=>q_outbuff(39 downto 32),
		r_1=>r_outbuff(23 downto 16),
		r_2=>r_outbuff(31 downto 24),
		r_3=>r_outbuff(39 downto 32),
		en=>dp_en_buff,
		clk=>clk,
		rst=>dp_rst_buff,
		valid_in=>'0',
		a_1=>a_1_buff(23 downto 16));
PATH4: datapath
PORT MAP(
		p_1=>p_outbuff(31 downto 24),
		p_2=>p_outbuff(39 downto 32),
		p_3=>p_outbuff(47 downto 40),
		q_1=>q_outbuff(31 downto 24),
		q_2=>q_outbuff(39 downto 32),
		q_3=>q_outbuff(47 downto 40),
		r_1=>r_outbuff(31 downto 24),
		r_2=>r_outbuff(39 downto 32),
		r_3=>r_outbuff(47 downto 40),
		en=>dp_en_buff,
		clk=>clk,
		rst=>dp_rst_buff,
		valid_in=>'0',
		a_1=>a_1_buff(31 downto 24));
--PATH5: datapath
--PORT MAP(
--		p_1=>p_outbuff(39 downto 32),
--		p_2=>p_outbuff(47 downto 40),
--		p_3=>p_outbuff(55 downto 48),
--		q_1=>q_outbuff(39 downto 32),
--		q_2=>q_outbuff(47 downto 40),
--		q_3=>q_outbuff(55 downto 48),
--		r_1=>r_outbuff(39 downto 32),
--		r_2=>r_outbuff(47 downto 40),
--		r_3=>r_outbuff(55 downto 48),
--		en=>dp_en_buff,
--		clk=>clk,
--		rst=>dp_rst_buff,
--		valid_in=>'0',
--		a_1=>a_1_buff(39 downto 32));
--PATH6: datapath
--PORT MAP(
--		p_1=>p_outbuff(47 downto 40),
--		p_2=>p_outbuff(55 downto 48),
--		p_3=>p_outbuff(63 downto 56),
--		q_1=>q_outbuff(47 downto 40),
--		q_2=>q_outbuff(55 downto 48),
--		q_3=>q_outbuff(63 downto 56),
--		r_1=>r_outbuff(47 downto 40),
--		r_2=>r_outbuff(55 downto 48),
--		r_3=>r_outbuff(63 downto 56),
--		en=>dp_en_buff,
--		clk=>clk,
--		rst=>dp_rst_buff,
--		valid_in=>'0',
--		a_1=>a_1_buff(47 downto 40));
--PATH7: datapath
--PORT MAP(
--		p_1=>p_outbuff(55 downto 48),
--		p_2=>p_outbuff(63 downto 56),
--		p_3=>p_outbuff(71 downto 64),
--		q_1=>q_outbuff(55 downto 48),
--		q_2=>q_outbuff(63 downto 56),
--		q_3=>q_outbuff(71 downto 64),
--		r_1=>r_outbuff(55 downto 48),
--		r_2=>r_outbuff(63 downto 56),
--		r_3=>r_outbuff(71 downto 64),
--		en=>dp_en_buff,
--		clk=>clk,
--		rst=>dp_rst_buff,
--		valid_in=>'0',
--		a_1=>a_1_buff(55 downto 48));
--PATH8: datapath
--PORT MAP(
--		p_1=>p_outbuff(63 downto 56),
--		p_2=>p_outbuff(71 downto 64),
--		p_3=>p_outbuff(79 downto 72),
--		q_1=>q_outbuff(63 downto 56),
--		q_2=>q_outbuff(71 downto 64),
--		q_3=>q_outbuff(79 downto 72),
--		r_1=>r_outbuff(63 downto 56),
--		r_2=>r_outbuff(71 downto 64),
--		r_3=>r_outbuff(79 downto 72),
--		en=>dp_en_buff,
--		clk=>clk,
--		rst=>dp_rst_buff,
--		valid_in=>'0',
--		a_1=>a_1_buff(63 downto 56));
--PATH9: datapath
--PORT MAP(
--		p_1=>p_outbuff(71 downto 64),
--		p_2=>p_outbuff(79 downto 72),
--		p_3=>p_outbuff(87 downto 80),
--		q_1=>q_outbuff(71 downto 64),
--		q_2=>q_outbuff(79 downto 72),
--		q_3=>q_outbuff(87 downto 80),
--		r_1=>r_outbuff(71 downto 64),
--		r_2=>r_outbuff(79 downto 72),
--		r_3=>r_outbuff(87 downto 80),
--		en=>dp_en_buff,
--		clk=>clk,
--		rst=>dp_rst_buff,
--		valid_in=>'0',
--		a_1=>a_1_buff(71 downto 64));	

--Input Address Generator Port Map
IN_GEN: addr_gen
PORT MAP(
		rst=>addr_gen_rst_buff,
		count_en=>inputAddr_buff,
		clk=>clk,		
		count_out=>countin_addr_buff);
--Output Address Generator Port Map
OUT_GEN: addr_gen
PORT MAP(
		rst=>addr_gen_rst_buff,
		count_en=>valid_out_buff,
		clk=>clk,		
		count_out=>countout_addr_buff);
--BRAM R Portmap
BRAM_R: bramr
PORT MAP(
	 clka=>'0',
	 ena=>'0',
	 wea(0)=>'0',
	 addra=>(others=>'0'),
	 dina=>(others=>'0'),
    clkb=>clk,    
    enb=>inputMem_buff,
    addrb=>countin_addr_buff,
    doutb=>bramr_outbuff);
--BRAM P Portmap
BRAM_P: bramp
PORT MAP(
	 clka=>'0',
	 ena=>'0',
	 wea(0)=>'0',
	 addra=>(others=>'0'),
	 dina=>(others=>'0'),
    clkb=>clk,    
    enb=>inputMem_buff,
    addrb=>countin_addr_buff,
    doutb=>bramp_outbuff);
--BRAM Q Portmap
BRAM_Q: bramq
PORT MAP(
    clka=>'0',
	 ena=>'0',
	 wea(0)=>'0',
	 addra=>(others=>'0'),
	 dina=>(others=>'0'),
    clkb=>clk,
    enb=>inputMem_buff,
    addrb=>countin_addr_buff,
    doutb=>bramq_outbuff);
--BRAM Output Portmap
BRAM_OUT: bramout
PORT MAP(
    clka=>clk,
    ena=>bramout_wren_buff,
    wea(0)=>bramout_we_buff,
    addra=>countout_addr_buff,
    dina=>a_1_buff,
    clkb=>clk,
    enb=>rd_en,
    addrb=>raddr_out,
    doutb=>rdata_out);

end Behavioral;

