----------------------------------------------------------------------------------
-- Engineer: Jordan Cottle
-- 
-- Create Date: 04/12/2019 04:59:51 PM
-- Design Name: decToFp_tb
-- Module Name: decToFp_tb - Behavioral
-- Description: Test bench for converting fp to decimal values and back
----------------------------------------------------------------------------------


library IEEE;
library Sim;
use Sim.math.all;
use Sim.constants.all;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.math_real.all;
use std.textio.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity decToFp_tb is
--  Port ( );
end decToFp_tb;

architecture Behavioral of decToFp_tb is
    signal dec: real;
    signal fracVector: std_logic_vector(153 downto 0);
    signal floatVector : std_logic_vector(31 downto 0);
    signal result: std_logic_vector(31 downto 0);
    file inputFile: text;
    file realOutputFile: text;
    file vectorOutputFile: text;
begin

    process
        variable lineIn: line;
        variable lineOut: line;
        variable str: string(1 to 32);
        variable decimal: real;
        variable fp: std_logic_vector(31 downto 0);
        variable count: integer := 0;
        variable vector: std_logic_vector(31 downto 0);
    begin
        file_open(inputFile, inputFolderPath & "fpValues.txt", read_mode);
        file_open(realOutputFile, outputFolderPath & "decValues.txt", write_mode);
        file_open(vectorOutputFile, outputFolderPath & "fpVectors.txt", write_mode);

        while not endfile(inputFile) loop
            readline(inputFile, lineIn);
            read(lineIn, str);
  
            -- pull bits from line into vector
            for index in 1 to 32 loop
                if str(index) = '1' then
                    vector(32-index) := '1';
                else
                    vector(32-index) := '0';
                end if;
            end loop;
            floatVector <= vector;
            
            decimal := fpToDec(vector);
            dec <= decimal;
            fracVector<= realFractionToStdLogicVector(decimal, fracVector'length);
            
            fp := decTofp(decimal);
            result <= fp;
            
            -- write fp vector into str for writing into output file
            for i in str'range loop
                if fp(32-i) = '1' then
                    str(i) := '1';
                else
                    str(i) := '0';
                end if;
            end loop;
            
            write(lineOut, str);
            writeLine(vectorOutputFile, lineOut);
            
            if decimal > maxValue then
                write(lineOut, string'("inf"));
            elsif decimal < minValue then 
                write(lineOut, string'("-inf"));
            else
                write(lineOut, real'image(decimal));
            end if;
            writeline(realOutputFile, lineOut);
            count := count + 1;
            wait for 20ns;
        end loop;

        file_close(inputFile);
        file_close(realOutputFile);
        file_close(vectorOutputFile);
        wait;
    end process;
end Behavioral;
