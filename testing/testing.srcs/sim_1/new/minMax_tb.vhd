----------------------------------------------------------------------------------
-- Engineer: Jordan Cottle
-- 
-- Create Date: 04/24/2019 06:33:55 PM
-- Module Name: minMax_tb - Behavioral
-- Description: test bench for min and max functions 
-- 
-- Dependencies: Math.vhd
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library Sim;
use Sim.math;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity minMax_tb is
--  Port ( );
end minMax_tb;

architecture Behavioral of minMax_tb is
    signal a: std_logic_vector(7 downto 0);
    signal b: std_logic_vector(a'range);
    signal max: std_logic_vector(a'range);
    signal min: std_logic_vector(a'range);
    
    signal maxSansMsb: std_logic_vector(a'range);
    signal minSansMsb: std_logic_vector(a'range);
begin

    process
        variable count: integer:= 0;
        variable aVec: std_logic_vector(a'range);
        variable bVec: std_logic_vector(b'range);
        variable result: std_logic_vector(a'range);
    begin

        while count < 2 ** a'length loop
            aVec := std_logic_vector(to_unsigned(count, a'length));
            a <= aVec;
            for j in -2 to 2 loop
                bVec := std_logic_vector(to_unsigned(count + j, b'length));
                b <= bVec;
                result := math.max(aVec, bVec, '0');
                max <= result;
                result := math.min(aVec, bVec, '0');
                min <= result;
                result := math.max(aVec, bVec, '1');
                maxSansMsb <= result;
                result := math.min(aVec, bVec, '1');
                minSansMsb <= result;
                wait for 20ns;
            end loop;
            count := count + 1;
        end loop;

        wait;
    end process;


end Behavioral;
