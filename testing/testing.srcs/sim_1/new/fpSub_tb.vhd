----------------------------------------------------------------------------------
-- Engineer: Jordan Cottle
-- 
-- Create Date: 04/24/2019 06:07:46 PM
-- Module Name: fpSub_tb - Behavioral
-- Description: test bench for fpSub function
-- 
-- Dependencies: Math.vhd
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library Sim;
use Sim.math.all;
use Sim.constants.all;

use IEEE.math_real.all;
use std.textio.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fpSub_tb is
--  Port ( );
end fpSub_tb;

architecture Behavioral of fpSub_tb is
    signal a : std_logic_vector(31 downto 0);
    signal b : std_logic_vector(31 downto 0);
    signal result: std_logic_vector(31 downto 0);
    file inputFile: text;
    file resultsOutputFile: text;
    file expectedResultsFile: text;
begin

    process
        variable aVar : std_logic_vector(31 downto 0);
        variable bVar : std_logic_vector(31 downto 0);
        variable resultVar: std_logic_vector(31 downto 0);
        variable lineIn: line;
        variable lineOut: line;
        variable str: string(1 to 32);

        variable aReal: real;
        variable bReal: real;
        variable resultReal: real;
        variable answerVec: std_logic_vector(31 downto 0);
    begin
        file_open(inputFile, inputFolderPath & "fpValues.txt", read_mode);
        file_open(resultsOutputFile, outputFolderPath & "subResults.txt", write_mode);
        file_open(expectedResultsFile, outputFolderPath & "subAnswerKey.txt", write_mode);

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

            -- read b
            readline(inputFile, lineIn);
            read(lineIn, str);
            -- pull bits from line into vector
            for index in 1 to 32 loop
                if str(index) = '1' then
                    bVar(32-index) := '1';
                else
                    bVar(32-index) := '0';
                end if;
            end loop;
            
            resultVar := fpSub(aVar, bVar);

            a <= aVar;
            b <= bVar;
            result <= resultVar;
            
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

            aReal := fpToDec(aVar);
            bReal := fpToDec(bVar);
            resultReal:= aReal - bReal;
            answerVec:= decToFp(resultReal);


            -- write fp vector into str for writing into output file
            for i in str'range loop
                if answerVec(32-i) = '1' then
                    str(i) := '1';
                else
                    str(i) := '0';
                end if;
            end loop;

            write(lineOut, str);
            writeLine(expectedResultsFile, lineOut);

            wait for 20ns;
        end loop;

        file_close(inputFile);
        file_close(resultsOutputFile);
        file_close(expectedResultsFile);
        wait;
    end process;
end Behavioral;
