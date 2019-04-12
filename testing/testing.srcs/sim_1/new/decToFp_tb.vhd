----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/12/2019 04:59:51 PM
-- Design Name: 
-- Module Name: decToFp_tb - Behavioral
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
library Sim;
use Sim.math.all;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.math_real.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity decToFp_tb is
--  Port ( );
end decToFp_tb;

architecture Behavioral of decToFp_tb is
signal vector: std_logic_vector(31 downto 0);
signal a: real;
signal result: std_logic_vector(31 downto 0);
begin

    process
    begin
        vector <= "01000000010000000000000000000000";
        a <= fpToDec(vector);
        result <= decToFp(a);
        
        wait for 20ns;
        
        a<= 0.1;
        result <= decToFp(a);
        wait;
    end process;
        

end Behavioral;
