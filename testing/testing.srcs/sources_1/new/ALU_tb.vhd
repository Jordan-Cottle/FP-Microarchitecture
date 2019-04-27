----------------------------------------------------------------------------------
-- Engineer: Jordan Cottle
-- 
-- Create Date: 04/26/2019 08:51:39 PM
-- Module Name: ALU_tb - Behavioral
-- Description: trest bench for proper alu operation
-- 
-- Dependencies: ALU.vhd, MAth.vhd
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library Sim;
use Sim.components.ALU;
use Sim.math.all;
use Sim.constants.all;

use std.textio.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU_tb is
--  Port ( );
end ALU_tb;

architecture Behavioral of ALU_tb is
    signal a,b, result: std_logic_vector(31 downto 0);
    signal op: std_logic_vector(3 downto 0);
    signal z, n, e: std_logic;
    
    signal aReal: real;
    signal bReal: real;
    signal resultReal: real;
    file inputFile: text;

begin
    UUT: ALU Port Map (opcode => op, 
        a => a, 
        b => b,
        result => result,
        z => z,
        n => n,
        e => e);
        
    process
        variable aVar, bVar : std_logic_vector(31 downto 0);
        variable opCode: std_logic_vector(3 downto 0);
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
            
            a <= aVar;
            b <= bVar;

            aReal <= fpToDec(aVar);
            bReal <= fpToDec(bVar);
            
            for i in 0 to 15 loop
                opCode := std_logic_vector(to_unsigned(i, 4));
                op <= opCode;
                wait for 1ps; -- prompt signal propogation to enable reading answer from result
                resultReal <= fpToDec(result);
                wait for 20ns;
            end loop;
        end loop;

        file_close(inputFile);
        wait;
    end process;
end Behavioral;
