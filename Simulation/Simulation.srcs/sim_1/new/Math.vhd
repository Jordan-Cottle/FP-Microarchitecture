----------------------------------------------------------------------------------
-- Engineer: Group Effort
-- 
-- Create Date: 04/02/2019 10:22:29 PM
-- Description: Contains math operations and conversions as functions for Simulation project
----------------------------------------------------------------------------------


library IEEE;
library Sim;
use Sim.constants.all;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.math_real.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

package Math is
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
    function realToUnsigned(r: real; bitLength: integer)
        return unsigned;
    function realFractionToStdLogicVector(r: real; bitLength: integer)
        return std_logic_vector;
    function mul (a, b: std_logic_vector (31 downto 0))
        return std_logic_vector;
    function power(A, B: std_logic_vector(31 downto 0))
        return real;
end Math;

package body Math is
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
    
    -- All because ints are too small :'(
    function realToUnsigned(r: real; bitLength: integer)
    return unsigned is
        variable num: real;
        variable remainder: real;
        variable i: integer;
        variable u: unsigned(bitLength-1 downto 0):= (others => '0');
    begin
        num := trunc(r);
        if num < 0.0 then
            num := -num;
        end if;
        i := 0;
        while(i < u'length and num > 0.0) loop
            num := num / 2.0;
            remainder := num - trunc(num);
            num := trunc(num);
            if remainder > 0.0 then
                u(i) := '1';
            else
                u(i) := '0';
            end if;
            i := i + 1;
        end loop;
        
        return u;
    end realToUnsigned;
    
    function realFractionToStdLogicVector(r: real; bitLength: integer)
    return std_logic_vector is
        variable fracVector: std_logic_vector(bitLength-1 downto 0):= (others => '0');
        variable i: integer;
        variable d: real:= r;
    begin
        if d < 0.0 then
            d := -d;
        end if;
        d := d - trunc(d);
        
        i := fracVector'length-1;
        while not (d = 0.0) and i >= 0 loop
            if d*2.0 >= 1.0 then
                fracVector(i) := '1';
                d := (d * 2.0) - 1.0;
            else
                fracVector(i) := '0';
                d := d * 2.0;
            end if;
            i := i - 1;
        end loop;
        return fracVector;
    end realFractionToStdLogicVector;
        

    function FpToDec (Fp: std_logic_vector(31 downto 0))
        return real is
    -- ieee fp format components
    alias sign is Fp(31); -- 1 bit for sign
    alias exponent is Fp(30 downto 23); -- 8 bit exponent
    alias mantissa is Fp(22 downto 0); -- 23 bits for mantissa (1.~23bits~)
    
    
    -- decimal values of components
    variable pow: integer;
    variable sum: real;
    begin
        pow := to_integer(unsigned(exponent))- 127;

        if exponent = "00000000" then
            -- skip implied mantissa bit
            sum := 0.0;
        elsif pow > 127 then
            if sign = '1' then
                return minValue * 2.0; -- less than minValue
            else
                return maxValue * 2.0; -- greater than maxValue
            end if;
        else 
            -- compute implied mantissa bit
            sum := 2.0**pow;
            pow := pow-1;
        end if;

        -- calculate listed mantissa bits
        for i in mantissa'range loop
            if mantissa(i) = '1' then
                sum := sum + 2.0**pow;
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

        variable fp: std_logic_vector(31 downto 0) := "00000000000000000000000000000000"; -- initalize to 0

        -- ieee fp format components
        alias sign is fp(31); -- 1 bit for sign
        alias exponent is fp(30 downto 23); -- 8 bit exponent
        alias mantissa is fp(22 downto 0); -- 24 bits for mantissa (1.~23bits~)

        variable intVector: std_logic_vector(127 downto 0);  -- max fp value is a 128 bit int
        variable fracVector: std_logic_vector(153 downto 0); -- 128 bits + 3 for rounding + 23 for mantissa

        variable int: integer;
        variable fraction: real;
        variable d: real;
        variable i: integer;
        variable bitIndex: integer;
        variable firstIntIndex: integer;
        variable firstFracIndex: integer;
        variable shiftAmount: integer;
        variable denormalized: boolean := false;
    begin
    if dec = 0.0 then
        return fp;
    elsif dec > maxValue then
        return std_logic_vector'("01111111100000000000000000000000");
    elsif dec < minValue then
        return std_logic_vector'("11111111100000000000000000000000");
    end if;
    
    d := dec;
    
    -- calculate sign bit
    if d < 0.0 then
        sign := '1';
        d := d * (-1.0);
    else
        sign := '0';
    end if;
    
    -- calculate binary bits
    intVector := std_logic_vector(realToUnsigned(d, intVector'length));
    fracVector := realFractionToStdLogicVector(d, fracVector'length);

    -- calculate exponent
    i := intVector'length-1;
    while(i >= 0 and intVector(i) = '0') loop
        i := i - 1;
    end loop;
    firstIntIndex := i;
    
    i := fracVector'length-1;
    while(i >= 0 and fracVector(i) = '0') loop -- don't include grs bits or extra mantissa
        i := i - 1;
    end loop;
    firstFracIndex:= i;


    if not (firstIntIndex = -1) then
        shiftAmount := firstIntIndex;
    else
        shiftAmount := firstFracIndex-fracVector'length;
    end if;
    
    if shiftAmount <= -127 then
        denormalized := true;
    end if;

    if denormalized then
        exponent := "00000000";
    else
        exponent := std_logic_vector(to_unsigned(127 + shiftAmount, 8));
    end if;
    
    -- calculate mantissa bits
    if shiftAmount >= 0 then
        bitIndex := firstIntIndex-1; -- skip assumed 1
    elsif denormalized then
        bitIndex := 27;
    else
        bitIndex := firstFracIndex-1; -- skipped assumed 1
    end if;
    
    i := 22;
    if shiftAmount > 0 then
        while i >= 0 and bitIndex >= 0 loop
            mantissa(i) := intVector(bitIndex);
            i := i - 1;
            bitIndex := bitIndex-1;
        end loop;
   end if;
   
   if i >= 0 and bitIndex = -1 then -- ran out of integer bits, move bitIndex to beginning of fracVector
            bitIndex := fracVector'length-1;
    end if; 
   
   -- load fraction bits into mantissa
   while i >= 0 and bitIndex >= 0 loop
       mantissa(i) := fracVector(bitIndex);
       i := i - 1;
       bitIndex := bitIndex-1;
   end loop;
    return fp;

    end DecToFp;
    
    function mul (a, b: std_logic_vector (31 downto 0))
    return std_logic_vector is
        variable count: integer := 0;
        begin
        return a;
        end mul;
        
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
end Math;    
