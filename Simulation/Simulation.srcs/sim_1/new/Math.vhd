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
use IEEE.NUMERIC_STD.ALL;

package Math is
    function powOfTwo(exp: integer) 
        return real;
    function add(a, b: std_logic_vector(31 downto 0))
        return std_logic_vector;
    function absolute(A: std_logic_vector(31 downto 0))
        return std_logic_vector;
    function neg(A: std_logic_vector(31 downto 0))
        return std_logic_vector;
    function FpToDec (Fp: std_logic_vector(31 downto 0))
        return real;
    function DecToFp(Dec: real)
        return std_logic_vector;
    function power(A, B: std_logic_vector(31 downto 0))
        return real;
    function expo(A: std_logic_vector(31 downto 0))
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
    
    function add(a,b: std_logic_vector(31 downto 0))
    return std_logic_vector is
        variable count: integer := 0;
    begin
        return a;
    end add;

    function absolute(A:std_logic_vector(31 downto 0))
        return std_logic_vector is
        variable C: std_logic_vector(31 downto 0);
    begin
        C(31):= '0';
        C(30 downto 0) := a(30 downto 0);
            return C;    
    end absolute;
    
     function neg(A: std_logic_vector(31 downto 0))
        return std_logic_vector is 
        variable C: std_logic_vector(31 downto 0);
    begin
        C(31):= not A(31);
        C(30 downto 0) := a(30 downto 0);
        return C;   
    end neg;

    function FpToDec (Fp: std_logic_vector(31 downto 0))
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
    function DecToFp(Dec: real)
        return std_logic_vector is

        variable fp: std_logic_vector(31 downto 0);

        -- ieee fp format components
        alias sign is fp(31); -- 1 bit for sign
        alias exponent is fp(30 downto 23); -- 8 bit exponent
        alias mantissa is fp(22 downto 0); -- 24 bits for mantissa (1.~23bits~)

        variable int: std_logic_vector(31 downto 0);
        variable frac:std_logic_vector(34 downto 0); -- at most 3
    begin
    
    if dec = 0.0 then
        return "00000000000000000000000000000000";
    end if;

    if Dec < 0.0 then
        sign := '1';
    else
        sign := '0';
    end if;


        
    end DecToFp;


function power(A,B: std_logic_vector(31 downto 0))
        return real is 
        variable C: real;
        variable A_real: real;
        variable B_real: real;
    begin
           A_real := FptoDec(A);
           B_real := FptoDec(B);
           C := A_real ** B_real;
           return C;
    end power;
    
function expo(A: std_logic_vector(31 downto 0))
            return real is
            variable C: real;
            variable A_real: real;
            variable Euler_num: real;
    begin
            A_real := FptoDec(A);
            Euler_num := 2.718281828459;
            C := Euler_num ** A_real;
            return C;
    end expo;        
            
end Math;    