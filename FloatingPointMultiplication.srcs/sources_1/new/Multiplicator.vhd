----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/04/2023 12:29:11 PM
-- Design Name: 
-- Module Name: Multiplicator - Behavioral
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

entity Multiplicator is
generic(n : natural);	
port(
	multiplicand : in STD_LOGIC_VECTOR(2*n-1 downto 0);
	multiplier : in STD_LOGIC_VECTOR(n-1 downto 0);
	load : in STD_LOGIC;
	clk : in STD_LOGIC;
	product : out STD_LOGIC_VECTOR(2*n-1 downto 0);
	done : out STD_LOGIC
	);
end Multiplicator;

architecture Behavioral of Multiplicator is

signal multiplicand_reg, adder_output, product_output : STD_LOGIC_VECTOR(2*n-1 downto 0);
signal multiplier_reg : STD_LOGIC_VECTOR(n-1 downto 0);
signal multiplicand_write_signal, shift_left_signal, multiplier_write_signal, shift_right_signal, product_write_signal, add_signal, reset : STD_LOGIC;

begin

MultiplicandReg: entity WORK.MultiplicandRegister generic map (n) port map (multiplicand, multiplicand_write_signal, shift_left_signal, clk, multiplicand_reg);
MultiplierReg: entity WORK.MultiplierRegister generic map (n) port map (multiplier, multiplier_write_signal, shift_right_signal, clk, multiplier_reg);
ProductReg: entity WORK.ProductRegister generic map (n) port map (adder_output, product_write_signal, reset, clk, product_output);
Addr: entity WORK.Adder generic map (n) port map (multiplicand_reg, product_output, add_signal, adder_output);
	
	product <= product_output; 
	
	add_signal <= multiplier_reg(0); --LSB
	
	process (load, multiplier_reg)
		begin
				if(load = '1') then -- se initializeaza o noua operatie de inmultire
					multiplicand_write_signal <= '1';   -- se incarca multiplicand si multiplier
					shift_left_signal <= '0';
					multiplier_write_signal <= '1';
					shift_right_signal <= '0';
					product_write_signal <= '0';
					done <= '0';
					reset <= '1';
				else -- in timpul operatiei de inmultire
					reset <= '0';
					multiplicand_write_signal <= '0';
					shift_left_signal <= '1';
					multiplier_write_signal <= '0';
					shift_right_signal <= '1';
					if (multiplier_reg = 0) then   -- daca e 0, rezultatul e 0
						product_write_signal <= '0';
						done <= '1';
					else
						product_write_signal <= '1';  -- se scrie produsul
						done <= '0';
					end if;
				end if;
		end process;

end Behavioral;
