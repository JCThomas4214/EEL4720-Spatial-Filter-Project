-- TestBench Template 

  LIBRARY ieee;
  USE ieee.std_logic_1164.ALL;
  USE ieee.numeric_std.ALL;

  ENTITY ctrl_tb IS  
  END ctrl_tb;

  ARCHITECTURE behavior OF ctrl_tb IS 

  -- Component Declaration
          COMPONENT ctrl
			 GENERIC(width : positive := 8);
          PORT(
                  en, rst, clk : in std_logic := '0';
						row_length : in std_logic_vector(10 downto 0);	
						pixel_count : in std_logic_vector(20 downto 0) := (others => '0');
						p_out, r_out, q_out : out std_logic_vector(width-1 downto 0) := (others => '0');
						dp_en, dp_rst : out std_logic := '0'
                  );
          END COMPONENT;

          SIGNAL en, rst, clk, dp_en, dp_rst :  std_logic;
          SIGNAL row_length :  std_logic_vector(10 downto 0);
			 SIGNAL pixel_count : std_logic_vector(20 downto 0);
			 SIGNAL p_out, q_out, r_out : std_logic_vector(7 downto 0);
          
			 constant clk_period : time := 10 ns;

  BEGIN

  -- Component Instantiation
          uut: ctrl PORT MAP(
                  en => en,
						rst => rst,
						clk => clk,
						row_length => row_length,
						pixel_count => pixel_count,
						p_out => p_out,
						q_out => q_out,
						r_out => r_out,
						dp_en => dp_en,
						dp_rst => dp_rst
          );

	-- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;

  --  Test Bench Statements
     tb : PROCESS
     BEGIN

        wait for 100 ns; 
		  rst <= '1';
		  wait for clk_period*10;
        -- Add user defined stimulus here		  
		  en <= '1';
		  row_length <= std_logic_vector(to_unsigned(256, 11));
		  pixel_count <= std_logic_vector(to_unsigned(256, 21));
		  wait for 10 ns;
		  rst <= '0';
		  wait for 30 ns;
		  
		  pixel_count <= std_logic_vector(to_unsigned(255, 21));
		  
		  wait for 40 ns;
		  
		  pixel_count <= std_logic_vector(to_unsigned(257, 21));
		  
		  wait for 40 ns;
		  
		  pixel_count <= std_logic_vector(to_unsigned(512, 21));
		  
		  wait for 40 ns;
		  
		  pixel_count <= std_logic_vector(to_unsigned(768, 21));
		  
		  wait for 40 ns;
		  
		  pixel_count <= std_logic_vector(to_unsigned(1024, 21));
		  
		  wait for 40 ns;
		  
		  pixel_count <= std_logic_vector(to_unsigned(1280, 21));
        wait; -- will wait forever
     END PROCESS tb;
  --  End Test Bench 

  END;
