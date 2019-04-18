----------------------------------------------------------------------------------
-- Engineer: Jordan Cottle
-- 
-- Create Date: 04/17/2019 02:58:20 PM
-- Module Name: bitDiff_tb - Behavioral: 
-- Description: Test the 8 bit subtraction function
-- 
-- Dependencies: Math.vhd
----------------------------------------------------------------------------------


library IEEE;
library Sim;
use Sim.math.bitDiff;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity bitDiff_tb is
--  Port ( );
end bitDiff_tb;

architecture Behavioral of bitDiff_tb is
    signal a: std_logic_vector(3 downto 0);
    signal b: std_logic_vector(3 downto 0);
    signal result: std_logic_vector(a'range);
begin
    process
        variable count: integer:= 0;
        variable i: integer;
        variable big: std_logic_vector(a'range);
        variable small: std_logic_vector(b'range);
        variable aSubB: std_logic_vector(a'range);
    begin
        while count < 2 ** a'length loop
            big := std_logic_vector(to_unsigned(count, a'length));
            i := 0;
            while i <= count loop
                small := std_logic_vector(to_unsigned(i, b'length));
                aSubB := bitDiff(big,small);
                a <= big;
                b <= small;
                result <= aSubB;
                i:= i+1;
                wait for 20ns;
            end loop;
            count:= count + 1;
        end loop;
        wait;
    end process;

end Behavioral;
