----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/19/2019 05:36:35 PM
-- Design Name: 
-- Module Name: expo_tb - Behavioral
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
library Sim;
use Sim.math.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity expo_tb is
--  Port ( );
end expo_tb;

architecture Behavioral of expo_tb is
signal A: std_logic_vector(31 downto 0);
signal C: std_logic_vector(a'range);

begin

      A <= "01000000000000000000000000000000";
      C <= expo(A); 

end Behavioral;
