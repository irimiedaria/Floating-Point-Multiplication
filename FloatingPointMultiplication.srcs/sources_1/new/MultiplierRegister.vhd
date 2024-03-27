----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/04/2023 12:23:09 PM
-- Design Name: 
-- Module Name: MultiplierRegister - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MultiplierRegister is
generic(n : natural);
port(
	input : in STD_LOGIC_VECTOR(n-1 downto 0);
	write : in STD_LOGIC;
	shift_right : in STD_LOGIC;
	clk : in STD_LOGIC;
	output : out STD_LOGIC_VECTOR(n-1 downto 0)
	);
end MultiplierRegister;

architecture Behavioral of MultiplierRegister is

signal content : STD_LOGIC_VECTOR(n-1 downto 0);

begin

process (clk)
		begin
			if(rising_edge(clk)) then
				if (write = '1') then
					content <= input;
				elsif (shift_right = '1') then
					content <= '0' & content(n-1 downto 1);
				end if;
			end if;
		end process;
	
	output <= content;

end Behavioral;
