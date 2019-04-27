---------------------------------------------------------------------------------- 
-- Engineer: Jordan Cottle
-- 
-- Create Date: 04/26/2019 06:45:28 PM
-- Design Name: ALU
-- Module Name: ALU - Behavioral
-- Project Name: FP-Microarchitecture
-- Description: Alu for the floating pointcoprocessor
-- 
-- Dependencies: Math.vhd
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library Sim;
use Sim.math.all;
use Sim.constants.all;

use IEEE.math_real.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
    Port ( opCode : in STD_LOGIC_VECTOR (3 downto 0);
           a : in STD_LOGIC_VECTOR (31 downto 0);
           b : in STD_LOGIC_VECTOR (31 downto 0);
           result : out STD_LOGIC_VECTOR (31 downto 0);
           z : out STD_LOGIC; -- zero
           n : out STD_LOGIC; -- negative
           e : out std_logic); -- error
end ALU;

architecture Behavioral of ALU is

begin
    process(opCode, a, b)
        variable answer: std_logic_vector(31 downto 0);
    begin
        z <= '0';
        n <= '0'; 
        e <= '0';
        case opcode is
            when "1111" =>
                answer:= a;
            when "0000" =>
                answer:= fpAdd(a,b);
            when "0001" =>
                answer:= fpSub(a,b);
            when "0010" =>
                answer:= neg(a);
            when "0011" =>
                answer:= mul(a,b);
            when "0100" =>
                if b = zero(32) then
                    answer:= "01111111101010101010101010101010"; -- NAN
                    e <= '1';
                else
                    answer:= div(a,b);
                end if;
            when "0101" =>
                answer:= floor(a);
            when "0110" =>
                answer:= ceil(a);
            when "0111" =>
                answer:= round(a);
            when "1000" =>
                answer:= absolute(a);
            when "1001" =>
                answer:= min(a,b,'0');
            when "1010" =>
                answer:= max(a,b,'0');
            when "1011" =>
                if fpToDec(a) < 0.0 and trunc(fpToDec(b)) /= fpToDec(b) then -- base < 0 and exponent != integer
                    answer := "01111111101010101010101010101010"; -- nan 
                    e <= '1';
                else
                    answer:= power(a,b);
                end if; 
            when "1100" =>
                answer:= expo(a);
            when "1101" =>
                if a(31) = '1' then
                    answer:= "01111111101010101010101010101010"; -- NAN
                    e <= '1';
                else
                    answer:= sqrt(a);
                end if;
            when others =>
                answer:= b;
        end case;
        
        result <= answer;

        n <= answer(31);
        if answer = "10000000000000000000000000000000" or answer = zero(32) then
            z <= '1';
        else
            z <= '0';
        end if;
    end process;

end Behavioral;
