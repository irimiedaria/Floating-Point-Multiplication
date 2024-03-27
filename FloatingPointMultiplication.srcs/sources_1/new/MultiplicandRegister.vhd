----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/04/2023 12:20:59 PM
-- Design Name: 
-- Module Name: MultiplicandRegister - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MultiplicandRegister is
generic(n : natural);
port(
	input : in STD_LOGIC_VECTOR(2*n-1 downto 0);
	write : in STD_LOGIC;
	shift_left : in STD_LOGIC;
	clk : in STD_LOGIC;
	output : out STD_LOGIC_VECTOR(2*n-1 downto 0)
	);
end MultiplicandRegister;

architecture Behavioral of MultiplicandRegister is

signal content : STD_LOGIC_VECTOR(2*n-1 downto 0);

begin

process (clk)
		begin
			if(rising_edge(clk)) then
				if (write = '1') then
					content <= input;
				elsif (shift_left = '1') then
					content <= content(2*n-2 downto 0) & '0';
				end if;
			end if;
		end process;
	
	output <= content;

end Behavioral;
