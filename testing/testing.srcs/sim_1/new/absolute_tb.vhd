----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/12/2019 02:21:02 PM
-- Design Name: 
-- Module Name: absolute_tb - Behavioral
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
use work.math.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity absolute_tb is
--  Port ( );
end absolute_tb;

architecture Behavioral of absolute_tb is
signal A: std_logic_vector(31 downto 0);
signal C: std_logic_vector(31 downto 0);
begin

A<="11111111111111111111111111111111";
C<= absolute(A);
end Behavioral;
