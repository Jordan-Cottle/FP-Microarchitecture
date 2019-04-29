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
    function toString(vector: std_logic_vector)
        return string;
    function stringToVector(str: string)
        return std_logic_vector;
end CONVERSIONS;

package body CONVERSIONS is
    function toString(vector: std_logic_vector)
        return string is
    
        variable str: string(vector'range);
    begin
        for i in vector'range loop
            if vector(i) = '1' then
                str(i) := '1';
            elsif vector(i) = '0' then
                str(i) := '0';
            else
                str(i) := 'E';
            end if;
        end loop;
    
        return str;
    end toString;
    
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
end CONVERSIONS;