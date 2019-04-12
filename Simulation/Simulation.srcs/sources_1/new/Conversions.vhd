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
    function DecToFp(Dec: real) 
        return std_logic_vector;
    
    function FpToDec (Fp: std_logic_vector)
        return real;

    function toString(vector: std_logic_vector)
        return string;
end CONVERSIONS;

package body CONVERSIONS is
    function FpToDec (Fp: std_logic_vector) -- expects full 32 bit binary fp vector
        return real is
    -- ieee fp format components
    alias sign is Fp(31); -- 1 bit for sign
    alias exponent is Fp(30 downto 23); -- 8 bit exponent
    alias mantissa is Fp(22 downto 0); -- 24 bits for mantissa (1.~23bits~)

    -- decimal values of components
    variable pow: integer;
    variable sum: real := 0.0;
    begin
        pow := to_integer(unsigned(exponent))- 127;

        -- calculate implied leading 1
        sum := sum + powOfTwo(pow);
        pow := pow-1;

        -- calculate listed mantissa bits
        for i in mantissa'range loop
            report "sum is " & real'image(sum);
            report "pow is " & integer'image(pow);
            if mantissa(i) = '1' then
                sum := sum + powOfTwo(pow);
            end if;
            pow := pow - 1;
        end loop;

        if sign = '1' then
            return sum * (-1.0);
        else
            return sum;
        end if;
    end FpToDec;

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
    
    function DecToFp(Dec: real)
        return std_logic_vector is
    begin

    end DecToFp;
end CONVERSIONS;