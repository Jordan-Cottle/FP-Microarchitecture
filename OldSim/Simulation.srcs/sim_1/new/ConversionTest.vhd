----------------------------------------------------------------------------------
-- Engineer: Jordan Cottle
-- 
-- Create Date: 04/02/2019 11:23:30 PM
-- Module Name: ConversionTest - Behavioral
-- Project Name: 
-- Description: Tests functions in Conversion package
----------------------------------------------------------------------------------


library IEEE;
library Sim;

use Sim.Math.all;
use Sim.Constants.all;
use IEEE.STD_LOGIC_1164.ALL;
use std.textio.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ConversionTest is
--  Port ( );
end ConversionTest;

architecture Behavioral of ConversionTest is

    signal value: string(1 to 32);
    signal dec: real;
    file inputFile: text;
    file outputFile: text;
begin

    process
        variable lineIn: line;
        variable lineOut: line;
        variable str: string(1 to 32);
        variable decimal: real;
        variable count: integer := 0;
        variable vector: std_logic_vector(31 downto 0);
    begin
        file_open(inputFile, inputFolderPath & "fpValues.txt", read_mode);
        file_open(outputFile, outputFolderPath & "decValues.txt", write_mode);

        while not endfile(inputFile) loop
            readline(inputFile, lineIn);
            read(lineIn, str);
            value <= str;
            report "line read is " & str;
            -- pull bits from line into vector
            for i in 1 to 32 loop
                if str(i) = '1' then
                    vector(32-i) := '1';
                else
                    vector(32-i) := '0';
                end if;
            end loop;

            decimal := fpToDec(vector);
            dec <= decimal;
            
            write(lineOut, real'image(decimal));
            writeline(outputFile, lineOut);
            count := count + 1;
            wait for 20ns;
        end loop;

        file_close(inputFile);
        file_close(outputFile);
        wait;
    end process;
end Behavioral;