----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Jordan Cottle
-- 
-- Create Date: 04/02/2019 10:22:29 PM
-- Module Name: Conversions - Behavioral
-- Project Name: 
-- Description: Contains conversion functions for Simulation project
----------------------------------------------------------------------------------


library IEEE;
library Sim;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.math_real.all;
use Sim.Math.all;
use std.textio.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

package CONVERSIONS is
    function stringToVector(str: string)
        return std_logic_vector;
    function vectorToString(vector: std_logic_vector)
        return string;
    function opCodeToString(opCode: std_logic_vector(4 downto 0))
        return string;
    function registerIndexToString(reg: std_logic_vector(3 downto 0))
        return string;
end CONVERSIONS;

package body CONVERSIONS is
    function stringToVector(str: string)
    return std_logic_vector is
        variable result: std_logic_vector(str'range);
    begin
        for i in str'range loop
            if str(i) = '1' then
                result(i) := '1';
            else
                result(i) := '0';
            end if;
        end loop;
        
        return result;
    end stringToVector;
    
    function vectorToString(vector: std_logic_vector)
    return string is
        variable result: string(vector'range);
    begin
        for i in vector'range loop
            if vector(i) = '1' then
                result(i) := '1';
            else
                result(i) := '0';
            end if;
        end loop;
        
        return result;
    end vectorToString;
    
    function opCodeToString(opCode: std_logic_vector(4 downto 0))
    return string is

    begin
        case opCode is
            when "00000" => -- add
                return string'("ADD");
                
            when "00001" => --sub
                return string'("SUB");
                
            when "00010" => --neg
                return string'("NEG");
                
            when "00011" => --mul
                return string'("MUL");
                
            when "00100" => --div
                return string'("DIV");
                
            when "00101" => --floor
                return string'("FLOOR");
                
            when "00110" => --ceil
                return string'("CEIL");
                
            when "00111" => --round
                return string'("ROUND");
                
            when "01000" => --abs
                return string'("ABS");
                
            when "01001" => --min
                return string'("MIN");
                
            when "01010" => --max
                return string'("MAX");
                
            when "01011" => --pow
                return string'("POW");
                
            when "01100" => --exp
                return string'("EXP");
                
            when "01101" => --sqrt
                return string'("SQRT");
                
            when "10000" => --set
                return string'("SET");
                
            when "10001" => --load
                return string'("LOAD");
                
            when "10010" => --store
                return string'("STORE");
                    
            when "10011" => --move
                return string'("MOVE");
                        
            when "11010" => --u_branch
                return string'("UB");
                
            when "11000" => --z_branch
                return string'("ZB");
                
            when "11001" => --n_branch
                return string'("NB");
                
            when "11111" => --nop
                return string'("PASS");
                
            when "10101" => --halt
                return string'("HALT");
            
            when others => -- do a noop
                return string'("NOOP");                           
            end case;
    end opCodeToString;
    
    function registerIndexToString(reg: std_logic_vector(3 downto 0))
    return string is
        variable result: string:= "R";
    begin
        result:= result & integer'image(to_integer(unsigned(reg)));
        return result;
    end registerIndexToString;
end CONVERSIONS;