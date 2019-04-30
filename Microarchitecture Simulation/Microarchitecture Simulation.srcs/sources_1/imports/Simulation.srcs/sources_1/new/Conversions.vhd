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
        variable result: string;
    begin
        case opCode is
            when "00000" => -- add
                result := "ADD";
                
            when "00001" => --sub
                result := "SUB";
                
            when "00010" => --neg
                result := "NEG";
                
            when "00011" => --mul
                result := "MUL";
                
            when "00100" => --div
                result := "DIV";
                
            when "00101" => --floor
                result := "FLOOR";
                
            when "00110" => --ceil
                result := "CEIL";
                
            when "00111" => --round
                result := "ROUND";
                
            when "01000" => --abs
                result := "ABS";
                
            when "01001" => --min
                result := "MIN";
                
            when "01010" => --max
                result := "MAX";
                
            when "01011" => --pow
                result := "POW";
                
            when "01100" => --exp
                result := "EXP";
                
            when "01101" => --sqrt
                result := "SQRT";
                
            when "10000" => --set
                result := "SET";
                
            when "10001" => --load
                result := "LOAD";
                
            when "10010" => --store
                result := "STORE";
                    
            when "10011" => --move
                result := "MOVE";
                        
            when "11010" => --u_branch
                result := "UB";
                
            when "11000" => --z_branch
                result := "ZB";
                
            when "11001" => --n_branch
                result := "NB";
                
            when "11111" => --nop
                result := "PASS";
                
            when "10101" => --halt
                result := "HALT";
            
            when others => -- do a noop
                result := "NOOP";                           
            end case;
        return result;
    end opCodeToString;
    
    function registerIndexToString(reg: std_logic_vector(3 downto 0))
    return string is
        variable result: string:= "R";
    begin
        result:= result & integer'image(to_integer(unsigned(reg)));
        return result;
    end registerIndexToString;
end CONVERSIONS;