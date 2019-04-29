----------------------------------------------------------------------------------
-- Engineer: Jordan Cottle
-- 
-- Create Date: 03/07/2019 05:59:48 PM
-- Design Name: File Reader
-- Module Name: FileReader - Behavioral
-- Project Name: FP-Microarchitecture Simulation
-- Description: Reads and parses a file containing instructions to drive the simulation
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
library Sim;

use Sim.Constants.all;
use Sim.conversions.all;
use IEEE.STD_LOGIC_1164.ALL;
use std.textio.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FileReader is
--  Port ( );
end FileReader;

architecture Behavioral of FileReader is

    file instructions: text;
    signal instruction: std_logic_vector(31 downto 0);
begin

    process
        variable lineIn: line;
        variable vectorString: string(32 downto 1);
        variable vector: std_logic_vector(31 downto 0);

    begin
        file_open(instructions, inputFolderPath & "program1.txt", read_mode);

        while not endfile(instructions) loop
            readline(instructions, lineIn);
            read(lineIn, vectorString); -- get operation
            
            vector := stringToVector(vectorString);

            instruction <= vector;            
            wait for 20ns;
        end loop;

        file_close(instructions);
        wait;
    end process;
    
end Behavioral;
