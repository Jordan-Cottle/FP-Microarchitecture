----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Jordan Cottle
-- 
-- Create Date: 04/02/2019 10:22:29 PM
-- Description: Contains conversion functions for Simulation project
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.math_real.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

package Math is
    function powOfTwo(exp: integer) 
        return real;
end Math;

package body Math is
    function powOfTwo(exp: integer) 
        return real is
    variable value: real := 1.0;
    begin
        if exp = 0 then
            return 1.0;
        end if;

        for i in 1 to abs(exp) loop
            value := value * 2.0;
            report "value is " & real'image(value);
        end loop;
    
        if exp > 0 then
            return value;
        else
            return 1.0 / value;
        end if;
    end powOfTwo;
end Math;