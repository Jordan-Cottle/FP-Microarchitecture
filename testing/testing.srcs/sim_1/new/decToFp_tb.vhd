----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/12/2019 04:59:51 PM
-- Design Name: 
-- Module Name: decToFp_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
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
    signal fracVector: std_logic_vector(127 downto 0);
    signal floatVector : std_logic_vector(31 downto 0);
    signal result: std_logic_vector(31 downto 0);
    file inputFile: text;
    file outputFile: text;
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
        file_open(outputFile, outputFolderPath & "decValues.txt", write_mode);

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
