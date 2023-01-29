----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:08:30 01/04/2023 
-- Design Name: 
-- Module Name:    processor - Behavioral 
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
use ieee.numeric_std.all;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity processor is
port(
reset: in std_logic;
clk: in std_logic;
address: out std_logic_vector(7 downto 0);
data_in: in std_logic_vector(15 downto 0);
data_out: out std_logic_vector(15 downto 0);
w: out std_logic;
r: out std_logic;
see_state: out std_logic_vector(3 downto 0);
see_PC: out std_logic_vector(7 downto 0);
see_AC: out std_logic_vector(15 downto 0);
see_MDR: out std_logic_vector(15 downto 0);
see_MAR: out std_logic_vector(7 downto 0);
see_IR: out std_logic_vector(15 downto 0);
see_opcode: out std_logic_vector(7 downto 0)
);


end processor;

architecture Behavioral of processor is

type fsm is (start, fetch_0, fetch_1, fetch_2, load_data_0, load_data_1, load_data_2, decode, add, store, load_0, load_1, load_2, jump, jneg, halt);
--encodings :-0000---0001-----0010-----0011-----0100---------0101---------0110---------0111----1000--1001--1010---1011----1100----1101--1110--1111
signal state: fsm;
signal IR: std_logic_vector(15 downto 0);
signal MDR: std_logic_vector(15 downto 0);
signal MAR: std_logic_vector(7 downto 0);
signal AC: std_logic_vector(15 downto 0);
signal PC: std_logic_vector(7 downto 0);
signal opcode: std_logic_vector(7 downto 0);
signal alu_out: std_logic_vector(15 downto 0);
component alu is
port(
a: in std_logic_vector(15 downto 0);
b: in std_logic_vector(15 downto 0);
c: out std_logic_vector(15 downto 0)
);
end component;
begin
	process(clk, reset)
	begin
		if reset = '1' then
			state <= start;
			see_state <= "0000";
		elsif rising_edge(clk) then
			case state is 
			when start =>
				PC <= (others => '0');
				AC <= (others => '0');
				IR <= (others => '0');
				MAR <= (others => '0');
				MDR <= (others => '0');
				opcode <= (others => '0');
				r <= '0';
				w <= '0';
				state <= fetch_0;
				see_state <= "0001";
			when fetch_0 =>
				r <= '1';
				w <= '0';
				MAR <= PC;
				PC <= std_logic_vector(unsigned(PC) + 1);
				state <= fetch_1;
				see_state <= "0010";
			when fetch_1 =>
				r <= '0';
				w <= '0';
				state <= fetch_2;
				see_state <= "0011";
			when fetch_2 =>
				IR <= data_in;
				r <= '0';
				w <= '0';
				state <= load_data_0;
				see_state <= "0100";
			when load_data_0 =>
				opcode <= IR(15 downto 8);
				MAR <= IR(7 downto 0);
				r <= '1';
				w <= '0';
				state <= load_data_1;
				see_state <= "0101";
			when load_data_1 =>
				state <= load_data_2;
				r <= '0';
				w <= '0';
				see_state <= "0110";
			when load_data_2 =>
				MDR <= data_in;
				r <= '0';
				w <= '0';
				state <= decode;
				see_state <= "0111";
			when decode =>
				if opcode = "00000000" then
					state <= add;
					see_state <= "1000";
				elsif opcode = "00000001" then
					state <= store;
					see_state <= "1001";
				elsif opcode = "00000010" then
					state <= load_0;
					see_state <= "1010";
				elsif opcode = "00000011" then
					state <= jump;
					see_state <= "1101";
				elsif opcode = "00000100" then
					state <= jneg;
					see_state <= "1110";
				elsif opcode = "00000101" then
					state <= halt;
					see_state <= "1111";
				end if;
			when add =>
				r <= '0';
				w <= '0';
				AC <= alu_out;
				state <= fetch_0;
				see_state <= "0001";
			when store =>
				r <= '0';
				w <= '1';
				state <= fetch_0;
				see_state <= "0001";
			when load_0 =>
				r <= '1';
				w <= '0';
				state <= load_1;
				see_state <= "1011";
			when load_1 =>
				r <= '0';
				w <= '0';
				state <= load_2;
				see_state <= "1100";
			when load_2 =>
				AC <= data_in;
				state <= fetch_0;
				see_state <= "0001";
			when jump =>
				r <= '0';
				w <= '0';
				PC <= MAR;
				state <= fetch_0;
				see_state <= "0001";
			when jneg =>
				r <= '0';
				w <= '0';
				if AC(15) = '1' then
					PC <= MAR;
				end if;
				state <= fetch_0;
				see_state <= "0001";
			when halt =>
				r <= '0';
				w <= '0';
				state <= halt;
				see_state <= "1111";
			when others =>
				r <= '0';
				w <= '0';
				state <= start;
				see_state <= "0000";
			end case;
		end if;
	end process;
address <= MAR;
data_out <= AC;
arithmetic_logic_unit: alu port map (a => MDR, b => AC, c => alu_out);
see_PC <= PC;
see_AC <= AC;
see_MAR <= MAR;
see_MDR <= MDR;
see_IR <= IR;
see_opcode <= opcode;
end Behavioral;

