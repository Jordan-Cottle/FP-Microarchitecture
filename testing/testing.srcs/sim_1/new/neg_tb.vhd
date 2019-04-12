----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/12/2019 02:46:37 PM
-- Design Name: 
-- Module Name: neg_tb - Behavioral
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
use work.math.neg;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity neg_tb is
--  Port ( );
end neg_tb;

architecture Behavioral of neg_tb is
signal A: std_logic_vector(31 downto 0);
signal C: std_logic_vector(31 downto 0);
begin

A<="11111111111111111111111111111111";
C<= neg(A);

end Behavioral;
