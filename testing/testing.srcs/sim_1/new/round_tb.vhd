----------------------------------------------------------------------------------
-- Engineer: Jordan Cottle
-- 
-- Create Date: 04/25/2019 05:16:25 PM
-- Module Name: round_tb - Behavioral
-- Description: Test bench for floating point round function
-- 
-- Dependencies: Math.vhd
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library Sim;
use Sim.math.round;
use Sim.math.fpToDec;
use Sim.math.decToFp;
use sim.constants.all;

use std.textio.all;
use IEEE.math_real.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity round_tb is
--  Port ( );
end round_tb;

architecture Behavioral of round_tb is
    signal a : std_logic_vector(31 downto 0);
    signal aReal : real;
    signal result: std_logic_vector(31 downto 0);
    signal realResult: real;
begin

    process
        variable aR: real;
        variable aVar : std_logic_vector(31 downto 0);
        variable resultVar: std_logic_vector(31 downto 0);
    begin
        aR := -8.5;
        while aR <= 10.0 loop
            aVar := decToFp(aR);
            resultVar := round(aVar);

            a <= aVar;
            aReal <= fpToDec(aVar);
            result <= resultVar;
            realResult <= fpToDec(resultVar);
            
            aR := aR + 0.03125; -- 1/32
            wait for 20ns;
        end loop;
        wait;
    end process;
end Behavioral;
