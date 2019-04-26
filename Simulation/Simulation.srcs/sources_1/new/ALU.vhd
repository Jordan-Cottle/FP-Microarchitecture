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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
    Port ( OpCode : in STD_LOGIC_VECTOR (3 downto 0);
           a : in STD_LOGIC_VECTOR (31 downto 0);
           b : in STD_LOGIC_VECTOR (31 downto 0);
           result : out STD_LOGIC_VECTOR (31 downto 0);
           z : out STD_LOGIC;
           n : out STD_LOGIC);
end ALU;

architecture Behavioral of ALU is

begin
    with opcode select result <=
        a when "1111",
        fpAdd(a,b) when "0000",
        fpSub(a,b) when "0001",
        neg(a) when "0010",
        mul(a,b) when "0011",
        div(a,b) when "0100",
        floor(a) when "0101",
        ceil(a) when "0110",
        round(a) when "0111",
        absolute(a) when "1000",
        min(a,b, '0') when "1001",
        max(a,b, '0') when "1010",
        power(a,b) when "1011",
        expo(a) when "1100",
        sqrt(a) when "1101",
        a when others;

end Behavioral;
