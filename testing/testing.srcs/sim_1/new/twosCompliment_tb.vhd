----------------------------------------------------------------------------------
-- Engineer: Jordan Cottle
-- 
-- Create Date: 04/18/2019 12:04:20 AM
-- Module Name: twosCompliment_tb - Behavioral
-- Description: two's compliment test bench
-- 
-- Dependencies: Math.vhd
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library Sim;
use Sim.math.twosCompliment;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity twosCompliment_tb is
--  Port ( );
end twosCompliment_tb;

architecture Behavioral of twosCompliment_tb is
    signal a: std_logic_vector(3 downto 0);
    signal b: std_logic_vector(15 downto 0);
    
    signal aComp: std_logic_vector(a'range);
    signal bComp: std_logic_vector(b'range);
    
    signal aInt: integer;
    signal bInt: integer;
    
    signal aCompInt: integer;
    signal bCompInt: integer;
begin
    process
        variable count: integer:= 0;
        variable aVec: std_logic_vector(a'range);
        variable bVec: std_logic_vector(b'range);
        variable aCompVec: std_logic_vector(a'range);
        variable bCompVec: std_logic_vector(b'range);
    begin
        while count < 2 ** b'length -1 loop
            aVec := std_logic_vector(to_unsigned(count, a'length));
            a <= aVec;
            aInt <= to_integer(signed(aVec));
            aCompVec := twosCompliment(aVec);
            aComp <= aCompVec;
            aCompInt <= to_integer(signed(aCompVec));
            
            bVec := std_logic_vector(to_unsigned(count, b'length));
            b <= bVec;
            bInt <= to_integer(signed(bVec));
            bCompVec := twosCompliment(bVec);
            bComp <= bCompVec;
            bCompInt <= to_integer(signed(bCompVec));
            
            
            wait for 20ns;
            count:= count + 1;
        end loop;
        wait;
    end process;
end Behavioral;
