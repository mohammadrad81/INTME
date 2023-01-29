--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   00:08:59 01/19/2023
-- Design Name:   
-- Module Name:   C:/Users/moham/Desktop/3/code/basic_computer/computer_tb.vhd
-- Project Name:  basic_computer
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: computer
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
 
ENTITY computer_tb IS
END computer_tb;
 
ARCHITECTURE behavior OF computer_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT computer
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         see_address : OUT  std_logic_vector(7 downto 0);
         see_r : OUT  std_logic;
         see_w : OUT  std_logic;
         see_data_to_memory : OUT  std_logic_vector(15 downto 0);
         see_data_to_processor : OUT  std_logic_vector(15 downto 0);
         see_PC : OUT  std_logic_vector(7 downto 0);
         see_AC : OUT  std_logic_vector(15 downto 0);
         see_MDR : OUT  std_logic_vector(15 downto 0);
         see_MAR : OUT  std_logic_vector(7 downto 0);
         see_IR : OUT  std_logic_vector(15 downto 0);
         see_opcode : OUT  std_logic_vector(7 downto 0);
         see_state : OUT  std_logic_vector(3 downto 0)
        );
		  
    END COMPONENT;
	 
   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';

 	--Outputs
   signal see_address : std_logic_vector(7 downto 0);
   signal see_r : std_logic;
   signal see_w : std_logic;
   signal see_data_to_memory : std_logic_vector(15 downto 0);
   signal see_data_to_processor : std_logic_vector(15 downto 0);
   signal see_PC : std_logic_vector(7 downto 0);
   signal see_AC : std_logic_vector(15 downto 0);
   signal see_MDR : std_logic_vector(15 downto 0);
   signal see_MAR : std_logic_vector(7 downto 0);
   signal see_IR : std_logic_vector(15 downto 0);
   signal see_opcode : std_logic_vector(7 downto 0);
   signal see_state : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: computer PORT MAP (
          clk => clk,
          reset => reset,
          see_address => see_address,
          see_r => see_r,
          see_w => see_w,
          see_data_to_memory => see_data_to_memory,
          see_data_to_processor => see_data_to_processor,
          see_PC => see_PC,
          see_AC => see_AC,
          see_MDR => see_MDR,
          see_MAR => see_MAR,
          see_IR => see_IR,
          see_opcode => see_opcode,
          see_state => see_state
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
		reset <= '1';
      wait for 100 ns;	
		reset <= '0';
      wait for clk_period*10;

      -- insert stimulus here 

      wait for clk_period * 4000;
   end process;

END;
