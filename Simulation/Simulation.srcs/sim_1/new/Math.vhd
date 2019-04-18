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
    function fpAdd(a, b: std_logic_vector(31 downto 0))
        return std_logic_vector;
    function bitAdd(a,b: std_logic_vector)
                return std_logic_vector;
    function bitDiff(a, b: std_logic_vector)
        return std_logic_vector;
    function shift(vector: std_logic_vector; count: integer; shiftLeft, normalized: std_logic)
                return std_logic_vector;
    function twosCompliment(vector: std_logic_vector)
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
    function fpAdd(a,b: std_logic_vector(31 downto 0))
    return std_logic_vector is
        alias aSign is a(31); -- 1 bit for sign
        alias aExponent is a(30 downto 23); -- 8 bit exponent
        alias aMantissa is a(22 downto 0); -- 23 bits for mantissa (1.~23bits~)

        alias bSign is b(31); -- 1 bit for sign
        alias bExponent is b(30 downto 23); -- 8 bit exponent
        alias bMantissa is b(22 downto 0); -- 23 bits for mantissa (1.~23bits~)

        variable i: integer;
        variable aIsGreater: std_logic;
        variable exponentsSame: std_logic;
        variable exponentDiff: std_logic_vector(7 downto 0);
        variable finalExponent: std_logic_vector(7 downto 0);
        variable stableMantissa: std_logic_vector(23 downto 0); -- include implied 1
        variable shiftedMantissa: std_logic_vector(23 downto 0); -- include potential implied 1 (in case of 0 shift)
        variable additionResult: std_logic_vector(24 downto 0);

        variable result: std_logic_vector(31 downto 0);
        alias resultSign is result(31); -- 1 bit for sign
        alias resultExponent is result(30 downto 23); -- 8 bit exponent
        alias resultMantissa is result(22 downto 0); -- 23 bits for mantissa (1.~23bits~)

    begin
        -- find minimum exponent
            -- locate first difference in exponents
        i := aExponent'left;
        while i >= aExponent'right and ((aExponent(i) xnor bExponent(i)) ='1') loop
            i := i - 1;
        end loop;
        report "i is " & integer'image(i);

        -- TODO use this!!
        if i = aExponent'right -1 then
            exponentsSame := '1';
            report "exponents are the same!";
        else
            report "Exponents are not the same!";
            exponentsSame := '0';
            aIsGreater := aExponent(i);
        end if;
        
        -- TODO remove this, actually calculate
        aIsGreater := '0';
        
        -- Refactor into largerVector vs smallerVector logic (use exponent to determine larger/smaller) get flag for same exponent

            -- figure out if a has a greater exponent than b
        

        -- compute difference in exponent and sign bit
        if aIsGreater = '1' then
            finalExponent := aExponent;
            exponentDiff := bitDiff(aExponent, bExponent);
            resultSign := aSign;
        else
            finalExponent := bExponent;
            exponentDiff := bitDiff(bExponent, aExponent);
            resultSign := bSign;
        end if;

        -- compute mantissas to use for addition
        if aIsGreater='1' then
            -- calculate b shiftd to a
            if bExponent = "00000000" then -- denormalized value
                shiftedMantissa(22 downto 0) := shift(bMantissa, to_integer(unsigned(exponentDiff)), '0', '0');
            else
                shiftedMantissa(22 downto 0) := shift(bMantissa, to_integer(unsigned(exponentDiff)), '0', '1');
            end if;
            
            -- add in implied bit
            if aExponent = "00000000" then -- denormalized value
                stableMantissa(23) := '0';
                stableMantissa(22 downto 0):= aMantissa;
            else
                stableMantissa(23) := '1';
                stableMantissa(22 downto 0) := aMantissa;
            end if;
        else
            -- calculate a shifted to b
            if aExponent = "00000000" then -- denormalized value
                shiftedMantissa(22 downto 0) := shift(aMantissa, to_integer(unsigned(exponentDiff)), '0', '0');
            else
                shiftedMantissa(22 downto 0) := shift(aMantissa, to_integer(unsigned(exponentDiff)), '0', '1');
            end if;
            
            -- add in implied bit
            if bExponent = "00000000" then -- denormalized value
                stableMantissa(23) := '0';
                stableMantissa(22 downto 0):= bMantissa;
            else
                stableMantissa(23) := '1';
                stableMantissa(22 downto 0) := bMantissa;
            end if;
        end if;
        
        if exponentsSame = '1' then
            shiftedMantissa(23) := '1';
        else
            shiftedMantissa(23) := '0';
        end if;

        -- perform mantissa addition
        if aSign = bSign then
            additionResult := bitAdd(stableMantissa, shiftedMantissa);
        else
            -- TODO two's comliment negative mantissa before adding
        end if;
        
        
        
        -- normalize value
        if additionResult(24) = '1' then -- shift right by one
            report "Shifting right";
            additionResult := shift(additionResult, 1, '0', '0');
            resultMantissa := additionResult(22 downto 0);
            resultExponent := bitAdd(finalExponent, "00000001")(7 downto 0);
        elsif additionResult(23) = '0' then
            while additionResult(23) = '0' loop -- shift left until one is found in 
                report "Shifting left";
                additionResult := shift(additionResult, 1, '1', '0');
                finalExponent := bitDiff(finalExponent, "00000001");
            end loop;
            resultExponent := finalExponent;
            resultMantissa := additionResult(22 downto 0);
        else
            report "Did not shift";
            resultMantissa := additionResult(22 downto 0);
            resultExponent := finalExponent;
        end if;

        return result;
    end fpAdd;
    
    -- performs two's compliment operation on a std_logic_vector
    function twosCompliment(vector: std_logic_vector)
        return std_logic_vector is
        
        variable oneFound: std_logic := '0';
        variable i: integer := vector'right;
        variable result: std_logic_vector(vector'range);
    begin
        while i <= vector'left loop
            if oneFound = '0' then
                result(i) := vector(i);
                if vector(i) = '1' then
                    oneFound := '1';
                end if;
            else
                result(i) := not vector(i);
            end if;
            i:= i + 1;
        end loop;
        
        if result = vector then -- vector was max negative value, postive value falls out of range
            -- return max positive value instead
            return not result;
         else
            return result;
         end if;
    end twosCompliment;

    -- add std_logic_vectors (treated as unsigned) binary values together
    function bitAdd(a,b: std_logic_vector)
        return std_logic_vector is
        
        variable result: std_logic_vector(a'left+1 downto a'right) := (others=>'0');
        variable carry: std_logic := '0';
        variable i: integer := 0;
    begin
        while i <= a'left loop
            result(i) := carry xor a(i) xor b(i);
            carry := (a(i) and b(i)) or (a(i) and carry) or (b(i) and carry);
            i := i+1;
        end loop;

        result(result'left) := carry;

        return result;
    end bitAdd;
    
    function shift(vector: std_logic_vector; count: integer; shiftLeft, normalized: std_logic)
        return std_logic_vector is
        
        variable result: std_logic_vector(vector'range):= (others => '0');
        variable sourceIndex: integer;
        variable destinationIndex: integer;
    begin
        if count = 0 then
            return vector;
        end if;
        if shiftLeft = '1' then
            sourceIndex := vector'right;
            destinationIndex := sourceIndex + count;
            while destinationIndex <= vector'left loop
                result(destinationIndex) := vector(sourceIndex);
                destinationIndex := destinationIndex + 1;
                sourceIndex := sourceIndex + 1;
            end loop;
        else
            sourceIndex := vector'left;
            destinationIndex := sourceIndex - count;
            if normalized = '1' then
                result(destinationIndex+1) := '1';
            end if;
            
            while destinationIndex >= vector'right loop
                result(destinationIndex) := vector(sourceIndex);
                destinationIndex := destinationIndex - 1;
                sourceIndex := sourceIndex - 1;
            end loop;
        end if;
        return result;
    end shift;

    -- computes difference of two std_logic_vector (treated as unsigned values) unsigned values, send first parameter as larger value, and second as smaller value
    function bitDiff(a, b: std_logic_vector)
        return std_logic_vector is

        variable i: integer:= a'right;
        variable carryIndex: integer;
        variable big: std_logic_vector(a'range) := a;
        variable small: std_logic_vector(b'range) := b;
        variable result: std_logic_vector(a'range):= (others => '0');
    begin
        while i <= a'left loop
            if big(i) = '1' and small(i)='1' then -- 1,1
                result(i) := '0';
                report "result(i) is " & std_logic'image(result(i));
            elsif big(i) = '0' and small(i) = '0' then
                result(i) := '0';
            elsif big(i) = '1' and small(i) = '0' then  -- 1,0
                result(i) := '1';
                report "result(i) is " & std_logic'image(result(i));
            elsif big(i) = '0' and small(i) = '1' then  -- 0,1
                result(i) := '1';
                -- carry in values from big i + 1
                carryIndex := i+1;
                    -- find 1 in big to carry from, toggling bits as we go
                while big(carryIndex) = '0' loop
                    if small(carryIndex) = '1' then
                        small(carryIndex) := '0'; -- 'subtract
                    else
                        big(carryIndex) := '1';
                    end if;
                    carryIndex := carryIndex + 1;
                end loop;
                -- big(carryIndex) = '1'
                big(carryIndex) := '0';
            end if;
            i := i+1;
        end loop;

        return result;
    end bitDiff;

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
