----------------------------------------------------------------------------------
-- Engineer: Jordan Cottle
-- 
-- Create Date: 04/09/2019 09:59:52 PM
-- Design Name: Mux2To1_32b_tb
-- Module Name: mux2To1_tb - Behavioral
-- Description: Tests proper functionality of Mux by reading 32 bit vectors from a file and muxing them
----------------------------------------------------------------------------------


library IEEE;
library Sim;
use Sim.components.Mux2To1_32b;
use Sim.constants.all;
use IEEE.STD_LOGIC_1164.ALL;
use std.textio.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mux2To1_32b_tb is
--  Port ( );
end mux2To1_32b_tb;

architecture Behavioral of mux2To1_32b_tb is
    signal a: std_logic_vector(31 downto 0);
    signal b: std_logic_vector(31 downto 0);
    signal control: std_logic := '0';
    signal result: std_logic_vector(31 downto 0);
    
    file inputFile: text;
begin
    UUT : Mux2To1_32b PORT MAP (a => a, b => b, control => control, result => result);
    process
        variable lineIn: line;
        variable str: string(1 to 32);
        variable vector: std_logic_vector(31 downto 0);
    begin
        file_open(inputFile, inputFolderPath & "fpValues.txt", read_mode);

        while not endfile(inputFile) loop
            --read first vector into a
            readline(inputFile, lineIn);
            read(lineIn, str);
            for i in 1 to 32 loop
                if str(i) = '1' then
                    vector(32-i) := '1';
                else
                    vector(32-i) := '0';
                end if;
            end loop;
            a <= vector;
            
            -- read second vector into b
            readline(inputFile, lineIn);
            read(lineIn, str);
            for i in 1 to 32 loop
                if str(i) = '1' then
                    vector(32-i) := '1';
                else
                    vector(32-i) := '0';
                end if;
            end loop;
            b <= vector;
            
            control <= '0';
            wait for 20ns;
            control <= '1';
            wait for 20ns;
        end loop;

        file_close(inputFile);
        wait;
    end process;
end Behavioral;
