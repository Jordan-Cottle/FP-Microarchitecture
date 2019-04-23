----------------------------------------------------------------------------------
-- Engineer: Jordan Cottle
-- 
-- Create Date: 04/17/2019 03:59:25 PM
-- Module Name: shift_tb - Behavioral
-- Description: Tests behavior of shift function
-- 
-- Dependencies: Math.vhd
----------------------------------------------------------------------------------


library IEEE;
library Sim;
use IEEE.STD_LOGIC_1164.ALL;
use Sim.math.shift;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity shift_tb is
--  Port ( );
end shift_tb;

architecture Behavioral of shift_tb is

signal baseVector: std_logic_vector(22 downto 0) := std_logic_vector'("10000000000100000000001");
signal leftNormalResult : std_logic_vector(baseVector'range);
signal rightNormalResult: std_logic_vector(baseVector'range);
signal leftStickyResult : std_logic_vector(baseVector'range);
signal rightStickyResult: std_logic_vector(baseVector'range);

signal step: integer;
begin

process
    
    variable shiftedVector: std_logic_vector(baseVector'range);
    variable count: integer;
begin

    count := 0;
    
    while count < baseVector'length loop
        step <= count;
        shiftedVector := shift(baseVector, count, '1', '0');
        leftNormalResult <= shiftedVector;
        
        shiftedVector := shift(baseVector, count, '0', '0');
        rightNormalResult <= shiftedVector;

        shiftedVector := shift(baseVector, count, '1', '1');
        leftStickyResult <= shiftedVector;
        
        shiftedVector := shift(baseVector, count, '0', '1');
        rightStickyResult <= shiftedVector;
        wait for 20ns;
        
        count := count + 1;
    end loop;
    
    wait;
end process;

end Behavioral;
