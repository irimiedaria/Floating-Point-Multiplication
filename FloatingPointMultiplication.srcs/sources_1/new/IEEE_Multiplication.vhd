----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/03/2023 04:40:52 PM
-- Design Name: 
-- Module Name: IEEE_Multiplication - Behavioral
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

entity IEEE_Multiplication is
    port(
        input1, input2 : in STD_LOGIC_VECTOR(31 downto 0);
        load : in STD_LOGIC;
        clk : in STD_LOGIC;
        output : out STD_LOGIC_VECTOR(31 downto 0);
        done : out STD_LOGIC
    );
end IEEE_Multiplication;

architecture Behavioral of IEEE_Multiplication is

    signal signInput1, signInput2, signOutput : STD_LOGIC;
    signal exponentInput1, exponentInput2, exponentOutput : STD_LOGIC_VECTOR(7 downto 0);
    signal mantissaInput1, mantissaInput2, mantissaOutput : STD_LOGIC_VECTOR(22 downto 0);

    --Formatul unui numar normalizat in virgula flotanta: 1.xxxxx... * 2^exponent
    --"1" inainte de punct este implicit si nu este stocat in reprezentarea IEEE 754
    --semnalul de mai jos extinde mantisa input1 adaugand inca un bit care reprezinta "1" implicit
    signal mantissaInput1_WITHONE : STD_LOGIC_VECTOR(47 downto 0);
    --pt overflow 
    signal mantissaInput2_WITHONE : STD_LOGIC_VECTOR(23 downto 0);

    signal multiplicationResult : STD_LOGIC_VECTOR(47 downto 0);

begin

    --desfac numar de 32 biti,in semn,mantisa si exponent
    signInput1 <= input1(31);
    exponentInput1 <= input1(30 downto 23);
    mantissaInput1 <= input1(22 downto 0);

    signInput2 <= input2(31);
    exponentInput2 <= input2(30 downto 23);
    mantissaInput2 <= input2(22 downto 0);

    --calculez semnul
    signOutput <= signInput1 xor signInput2;

    --ajustez mantisele in conformitate cu reprezentarea in virgula mobila a numerelor IEEE 754
    mantissaInput1_WITHONE(47 downto 24) <= (others => '0'); 
    --se seteaza primii 24 de biti de mantisa
    --adauga o serie de 0 uri la partea sa fractionara pt a pregati locul pt mantisa extinsa
    mantissaInput1_WITHONE(23 downto 0) <= '1' & mantissaInput1;
    --se pune 1 inainte de partea fractionara 1.xxxxx
    mantissaInput2_WITHONE <= '1' & mantissaInput2;

MUL: entity WORK.Multiplicator generic map (24) port map (mantissaInput1_WITHONE, mantissaInput2_WITHONE, load, clk, multiplicationResult, done);
	
	--calculez exponentul
	exponentOutput <= (((exponentInput1 - 127) + (exponentInput2 - 127)) + multiplicationResult(47) + 127);
	-- include o ajustare suplimentara bazata pe cel mai semnificativ bit al rezultatului inmultirii
	
	--rotunjez mantisa
	with multiplicationResult(47) select mantissaOutput <=
		multiplicationResult(45 downto 23) when '0', --indica ca rez < 0.5
		multiplicationResult(46 downto 24) when OTHERS; -- rez > 0.5
	
	--rezultatul final
	output <= x"00000000" when (input1 = x"00000000" or input2 = x"00000000") else signOutput & exponentOutput & mantissaOutput;

end Behavioral;
