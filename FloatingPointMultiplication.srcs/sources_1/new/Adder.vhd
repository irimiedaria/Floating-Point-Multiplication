----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/04/2023 12:27:46 PM
-- Design Name: 
-- Module Name: Adder - Behavioral
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

entity Adder is
generic(n : natural);
port(
	input1 : in STD_LOGIC_VECTOR(2*n-1 downto 0);
	input2: in STD_LOGIC_VECTOR(2*n-1 downto 0);
	add : in STD_LOGIC;
	output : out STD_LOGIC_VECTOR(2*n-1 downto 0)
	);
end Adder;

architecture Behavioral of Adder is

begin
    output <= (input1 + input2) when add = '1' else input2;

end Behavioral;
