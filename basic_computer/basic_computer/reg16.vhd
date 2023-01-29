----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:55:14 01/04/2023 
-- Design Name: 
-- Module Name:    reg16 - Behavioral 
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
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity reg16 is
port	(
	d: in std_logic_vector(15 downto 0);
	clk: in std_logic;
	load: in std_logic;
	clr: in std_logic;
	inc: in std_logic;
	q: out std_logic_vector(15 downto 0)
);
end reg16;

architecture Behavioral of reg16 is
signal val: std_logic_vector(15 downto 0);

begin
	process(clk, clr)
	begin
		if clr = '1' then
			val <= "0000000000000000";
			q <= val;
		elsif rising_edge(clk) then
			if load = '1' then
				val <= d;
				q <= val;
			elsif inc = '1' then
				val <= val + 1;
				q <= val;
			end if;
		end if;
	end process;
end Behavioral;