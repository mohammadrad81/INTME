----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    02:01:00 01/18/2023 
-- Design Name: 
-- Module Name:    computer - Behavioral 
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

entity computer is
port(
clk: in std_logic;
reset: in std_logic;
see_address: out std_logic_vector(7 downto 0);
see_r: out std_logic;
see_w: out std_logic;
see_data_to_memory: out std_logic_vector(15 downto 0);
see_data_to_processor: out std_logic_vector(15 downto 0);
see_PC: out std_logic_vector(7 downto 0);
see_AC: out std_logic_vector(15 downto 0);
see_MDR: out std_logic_vector(15 downto 0);
see_MAR: out std_logic_vector(7 downto 0);
see_IR: out std_logic_vector(15 downto 0);
see_opcode: out std_logic_vector(7 downto 0);
see_state: out std_logic_vector(3 downto 0)
);
end computer;

architecture Behavioral of computer is
signal r: std_logic;
signal w: std_logic;
signal mem_address: std_logic_vector(7 downto 0);
signal mem_input: std_logic_vector(15 downto 0);
signal mem_output: std_logic_vector(15 downto 0);
component memory is
port(
address: in std_logic_vector(7 downto 0);
input: in std_logic_vector(15 downto 0);
ram_clk: in std_logic;
w: in std_logic;
r: in std_logic;
output: out std_logic_vector(15 downto 0)
);
end component;

component processor is 
port(
reset: in std_logic;
clk: in std_logic;
address: out std_logic_vector(7 downto 0);
data_in: in std_logic_vector(15 downto 0);
data_out: out std_logic_vector(15 downto 0);
w: out std_logic;
r: out std_logic;

see_PC: out std_logic_vector(7 downto 0);
see_AC: out std_logic_vector(15 downto 0);
see_MDR: out std_logic_vector(15 downto 0);
see_MAR: out std_logic_vector(7 downto 0);
see_IR: out std_logic_vector(15 downto 0);
see_opcode: out std_logic_vector(7 downto 0);
see_state: out std_logic_vector(3 downto 0)
);
end component;

begin

main_memory: memory port map(address => mem_address, input => mem_input, ram_clk => clk, r => r, w => w, output => mem_output);
proc: processor port map(reset => reset, clk => clk, address => mem_address, data_in => mem_output, data_out => mem_input, r => r, w => w, see_PC => see_PC, see_AC => see_AC, see_MAR => see_MAR, see_MDR => see_MDR, see_IR => see_IR, see_opcode => see_opcode, see_state => see_state);
see_address <= mem_address;
see_r <= r;
see_w <= w;
see_data_to_memory <= mem_input;
see_data_to_processor <= mem_output;
end Behavioral;

