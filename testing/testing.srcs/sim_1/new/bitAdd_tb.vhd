----------------------------------------------------------------------------------
-- Engineer: Jordan Cottle
-- 
-- Create Date: 04/17/2019 06:27:05 PM 
-- Module Name: bitAdd_tb - Behavioral
-- Description: test binary addition function
-- 
-- Dependencies: Math.vhd
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library Sim;
use Sim.math.bitAdd;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity bitAdd_tb is
--  Port ( );
end bitAdd_tb;

architecture Behavioral of bitAdd_tb is
    signal a: integer;
    signal b: integer;
    signal result: integer;
    signal binA: std_logic_vector(7 downto 0);
    signal binB: std_logic_vector(7 downto 0);
    signal binResult: std_logic_vector(binA'left+1 downto binA'right);
begin
    process
        variable count: integer:= 0;
        variable i: integer;
        variable APB: std_logic_vector(binResult'range);
        variable aVec: std_logic_vector(binA'range);
        variable bVec: std_logic_vector(binB'range);
    begin
        while count < 2 ** binA'length -1 loop
            a <= count;
            aVec := std_logic_vector(to_unsigned(count, binA'length));
            binA <= aVec;
            i:= 2 ** binA'length-1;
            while i >= 0 loop
                b <= i;
                bVec := std_logic_vector(to_unsigned(i, binB'length));
                binB <= bVec;
                APB := bitAdd(aVec, bVec);
                binResult <= APB;
                result <= to_integer(unsigned(APB));
                i:= i-1;
                wait for 20ns;
            end loop;
            count:= count + 1;
        end loop;
        wait;
    end process;
end Behavioral;
