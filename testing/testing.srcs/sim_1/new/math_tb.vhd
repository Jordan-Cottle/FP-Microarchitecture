----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/12/2019 02:14:46 PM
-- Design Name: 
-- Module Name: math_tb - Behavioral
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
use work.math.all;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity math_tb is
--  Port ( );
end math_tb;

architecture Behavioral of math_tb is
signal exponent: integer;
signal result: real;
signal a: std_logic_vector(31 downto 0);
signal b: std_logic_vector(31 downto 0);

signal apb: std_logic_vector(31 downto 0);
begin

exponent <= 4;
result <= powOfTwo(exponent);

a<= "00000000000000000000000000000000";
b<= "11111111111111111111111111111111";

apb <= add(a,b);


end Behavioral;
