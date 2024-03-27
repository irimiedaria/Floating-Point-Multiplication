----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/04/2023 12:25:56 PM
-- Design Name: 
-- Module Name: ProductRegister - Behavioral
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

entity ProductRegister is
generic(n : natural);
port(
	input : in STD_LOGIC_VECTOR(2*n-1 downto 0);
	write : in STD_LOGIC;	 
	reset : in STD_LOGIC;
	clk : in STD_LOGIC;
	output : out STD_LOGIC_VECTOR(2*n-1 downto 0)
	);
end ProductRegister;

architecture Behavioral of ProductRegister is

signal content : STD_LOGIC_VECTOR(2*n-1 downto 0);

begin

process (clk, reset)
		begin		   
			if(reset = '1') then
				content <= (others => '0');
			elsif(rising_edge(clk)) then
				if (write = '1') then
					content <= input;
				end if;
			end if;
		end process;
	
	output <= content;

end Behavioral;
