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
use Sim.math.all;
use Sim.constants.all;

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
    signal aReal: real;
    signal result: std_logic_vector(31 downto 0);
    signal resultReal: real;
    file inputFile: text;
begin

    process
        variable aVar : std_logic_vector(31 downto 0);
        variable resultVar: std_logic_vector(31 downto 0);
        variable lineIn: line;
        variable lineOut: line;
        variable str: string(1 to 32);
    begin
        file_open(inputFile, inputFolderPath & "fpValues.txt", read_mode);

        while not endfile(inputFile) loop
            -- read a
            readline(inputFile, lineIn);
            read(lineIn, str);
            -- pull bits from line into vector
            for index in 1 to 32 loop
                if str(index) = '1' then
                    aVar(32-index) := '1';
                else
                    aVar(32-index) := '0';
                end if;
            end loop;
            
            for i in 0 to 3 loop
                aVar := shift(aVar, i, '0', '1');
                resultVar := round(aVar);
                a <= aVar;
                result <= resultVar;
                aReal <= fpToDec(aVar);
                resultReal <= fpToDec(resultVar);
                wait for 20ns;
            end loop;
        end loop;

        file_close(inputFile);
    end process;
end Behavioral;
