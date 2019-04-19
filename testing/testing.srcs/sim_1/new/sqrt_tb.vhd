----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/19/2019 06:45:25 PM
-- Design Name: 
-- Module Name: sqrt_tb - Behavioral
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

entity sqrt_tb is
--  Port ( );
end sqrt_tb;

architecture Behavioral of sqrt_tb is
signal A: std_logic_vector(31 downto 0);
signal C: real;
begin
           A <= "01000010100000000000000000000000";
           C <= sqrt(A); 

end Behavioral;
