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
    file inputFile: text;
    file resultsOutputFile: text;
begin

    process
        variable aVar : std_logic_vector(31 downto 0);
        variable bVar : std_logic_vector(31 downto 0);
        variable resultVar: std_logic_vector(31 downto 0);
        variable lineIn: line;
        variable lineOut: line;
        variable str: string(1 to 32);

        variable resultReal: real;
        variable answerVec: std_logic_vector(31 downto 0);
    begin
        file_open(inputFile, inputFolderPath & "fpValues.txt", read_mode);
        file_open(resultsOutputFile, outputFolderPath & "roundResults.txt", write_mode);

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
            
            resultVar := round(aVar);

            a <= aVar;
            aReal <= fpToDec(aVar);
            result <= resultVar;
            realResult <= fpToDec(resultVar);
            
            -- write fp vector into str for writing into output file
            for i in str'range loop
                if resultVar(32-i) = '1' then
                    str(i) := '1';
                else
                    str(i) := '0';
                end if;
            end loop;
            
            write(lineOut, str);
            writeLine(resultsOutputFile, lineOut);

            wait for 20ns;
        end loop;

        file_close(inputFile);
        file_close(resultsOutputFile);
        wait;
    end process;
end Behavioral;
