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
    file results: text;
    signal instruction: string(1 to 13);
    signal result: string(1 to 17);

begin

    process
        variable lineIn: line;
        variable lineOut: line;

        variable operation: string(1 to 3) := "ADD";
        variable Rd: string(1 to 2) := "R1";
        variable Ri: string(1 to 2) := "R2";
        variable Rj: string(1 to 2) := "R3";

        variable seperator: character;
        variable sep: string(1 to 2) := ", ";
        
        variable count: integer := 0;
    begin
        file_open(instructions, inputFolderPath & "instructions.txt", read_mode);
        file_open(results, outputFolderPath & "output.txt", write_mode);

        while not endfile(instructions) loop
            readline(instructions, lineIn);
            read(lineIn, operation); -- get operation
            read(lineIn, seperator); -- read space
            read(lineIn, Rd); -- get destination register
            read(lineIn, seperator); -- read space
            read(lineIn, seperator); -- read comma
            read(lineIn, Ri); -- get first source register
            read(lineIn, seperator);
            read(lineIn, Rj); -- get second source register

            instruction <= operation & " " & Rd & ", " & Ri & " " & Rj;
            
            write(lineOut, count);
            write(lineOut, string'(": "));
            write(lineOut, operation);
            write(lineOut, ' ');
            write(lineOut, Rd);
            write(lineOut, string'(", "));
            write(lineOut, Ri);
            write(lineOut, ' ');
            write(lineOut, Rj);
            writeline(results, lineOut);
            if count < 10 then -- pad signal to match expected size of string
                result <= "0" & integer'image(count) & ": " & operation & " " & Rd & ", " & Ri & " " & Rj;
            else
                result <= integer'image(count) & ": " & operation & " " & Rd & ", " & Ri & " " & Rj;
            end if;
            count := count + 1;
            wait for 20ns;
        end loop;

        file_close(instructions);
        file_close(results);

        wait;
    end process;
    
end Behavioral;
