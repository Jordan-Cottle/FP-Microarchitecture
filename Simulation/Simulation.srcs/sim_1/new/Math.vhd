----------------------------------------------------------------------------------
-- Engineer: Group Effort
-- 
-- Create Date: 04/02/2019 10:22:29 PM
-- Description: Contains conversion functions for Simulation project
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.math_real.all;

library Sim;
use Sim.constants.all;

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
    function shift(vector: std_logic_vector; count: integer; shiftLeft, stickyBit: std_logic)
        return std_logic_vector;
    function twosCompliment(vector: std_logic_vector)
        return std_logic_vector;
    function fpSub(a, b: std_logic_vector(31 downto 0))
        return std_logic_vector;
    function round(a: std_logic_vector(31 downto 0))
        return std_logic_vector;
    function min(a,b: std_logic_vector; ignoreMSB: std_logic)
        return std_logic_vector;
    function max(a,b: std_logic_vector; ignoreMSB: std_logic)
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
    function div (a, b: std_logic_vector (31 downto 0))
        return std_logic_vector;
    function power(A, B: std_logic_vector(31 downto 0))
        return std_logic_vector;
    function expo(A: std_logic_vector(31 downto 0))
        return std_logic_vector;
    function sqrt(A: std_logic_vector(31 downto 0))
        return std_logic_vector;
    function floor(a, b: std_logic_vector (31 downto 0))
        return real;
    function ceil(a, b: std_logic_vector (31 downto 0))
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

        variable greater: std_logic_vector(31 downto 0);
        alias greaterSign is greater(31); -- 1 bit for sign
        alias greaterExponent is greater(30 downto 23); -- 8 bit exponent
        alias greaterMantissa is greater(22 downto 0); -- 23 bits for mantissa (1.~23bits~)

        variable smaller: std_logic_vector(31 downto 0);
        alias smallerSign is smaller(31); -- 1 bit for sign
        alias smallerExponent is smaller(30 downto 23); -- 8 bit exponent
        alias smallerMantissa is smaller(22 downto 0); -- 23 bits for mantissa (1.~23bits~)
        
        variable i: integer;
        variable exponentDiff: std_logic_vector(7 downto 0) := (others => '0');
        variable finalExponent: std_logic_vector(7 downto 0) := (others => '0');
        variable stableMantissa: std_logic_vector(26 downto 0) := (others => '0'); -- include implied 1 -- + 3 grs bits to match size of shifted mantissa
        variable shiftedMantissa: std_logic_vector(26 downto 0) := (others => '0'); -- include potential implied 1 (in case of 0 shift)  include grs bits
        variable additionResult: std_logic_vector(27 downto 0) := (others => '0');

        alias G is additionResult(2);
        alias R is additionResult(1);
        alias S is additionResult(0);
        alias LSB is additionResult(3);
        
        -- fix for bug in bitAdd function, send literal "00000001" fails to work properly
        variable one: std_logic_vector(7 downto 0) := "00000001";
        variable mantiOne: std_logic_vector(26 downto 3) := "000000000000000000000001";

        variable result: std_logic_vector(31 downto 0) := (others => '0');
        alias resultSign is result(31); -- 1 bit for sign
        alias resultExponent is result(30 downto 23); -- 8 bit exponent
        alias resultMantissa is result(22 downto 0); -- 23 bits for mantissa (1.~23bits~)

    begin
        -- find greater value ignoring sign bit
        greater := max(a, b, '1');
        smaller := min(a, b, '1');
        
        -- compute difference in exponent and sign bit
        finalExponent := greaterExponent;
        exponentDiff := bitDiff(greaterExponent, smallerExponent);
        -- use -126 instead of -127 for exponent of "00000000"
        if smallerExponent = "00000000" and not(greaterExponent = "00000000") then
            exponentDiff := bitDiff(finalExponent, one);
        end if;
        resultSign := greaterSign;
        
        -- If infinity is involved in the calculation, the result is also infinity
        if finalExponent = "11111111" then
            if exponentDiff = zero(8) and not(aSign = bSign) then -- + inifnity - infinity = 0
                return zero(32);
            elsif resultSign = '0' then
                return "01111111100000000000000000000000";
            else
                return "11111111100000000000000000000000";
            end if;
        end if;

        
        shiftedMantissa(25 downto 3):= smallerMantissa;
        stableMantissa(25 downto 3) := greaterMantissa;

        -- set implied bits
        if smallerExponent = "00000000" then
            shiftedMantissa(26):= '0';
        else
            shiftedMantissa(26) := '1';
        end if;

        if greaterExponent = "00000000" then
            stableMantissa(26) := '0';
        else
            stableMantissa(26) := '1';
        end if;

        -- align mantissas
        shiftedMantissa := shift(shiftedMantissa, to_integer(unsigned(exponentDiff)), '0', '1'); -- shift right

        if shiftedMantissa = "000000000000000000000000000" then -- avoids issue with 2's complimenting all zeros and adding that to another mantissa
            return greater;
        end if;
        
        
        if greaterSign = smallerSign then
            additionResult := bitAdd(stableMantissa, shiftedMantissa);
        else
            additionResult(27) := '0';
            additionResult(26 downto 0) := bitDiff(stableMantissa,shiftedMantissa);
        end if; 
        
        -- normalize value
        -- locate first one
        i := 27;
        while additionResult(i) = '0' loop
            i := i - 1;
        end loop;
        
        if i = 27 then -- shift right by one
            additionResult := shift(additionResult, 1, '0', '1');
            finalExponent := bitAdd(finalExponent, one)(7 downto 0); -- ignore extra bit returned
        elsif 26-i < to_integer(unsigned(finalExponent)) then
            additionResult := shift(additionResult, 26-i, '1', '0');
            finalExponent := bitDiff(finalExponent, std_logic_vector(to_unsigned(26-i, 8)));
        elsif i = 26 and finalExponent = "00000000" then
            finalExponent := "00000001";
        elsif not (finalExponent = zero(8)) then -- shift would set exponent into negative
            additionResult := shift(additionResult, to_integer(unsigned(finalExponent)) - 1, '1', '0');
            finalExponent := "00000000";   
        end if;
        
        if G='0' and R='0' and S='0' then
            --report "No rounding necessary";
        elsif G = '0' then
            --report "Round down";
            -- do nothing to 'truncate' and round down
        else -- G = '1'
            if R = '1' or S = '1' then  -- GRS = "110", "101", "111"
                --report "Round up!";
                additionResult(27 downto 3) := bitAdd(additionResult(26 downto 3), mantiOne);
            elsif LSB = '1' then -- GRS = "100"
                --report "Tie, round up!";
                additionResult(27 downto 3) := bitAdd(additionResult(26 downto 3), mantiOne);
            -- else, truncate to round down
            end if;
        end if;
        
        -- renormalize value

        resultMantissa := additionResult(25 downto 3);
        resultExponent := finalExponent;
        
        if resultExponent = "11111111" then -- clean up infinity case
            resultMantissa:= (others => '0');
        end if;
        
        return result;
    end fpAdd;
    
    function normalize(exponent: std_logic_vector(7 downto 0); mantissa: std_logic_vector(27 downto 0))
    return std_logic_vector is
    
    variable exp: std_logic_vector(7 downto 0);
    variable man: std_logic_vector(27 downto 0);
    variable i: integer;
    begin
        exp := exponent;
        man := mantissa;
    
        i := mantissa'left;
        while man(i) = '0' loop
            i := i - 1;
        end loop;
        -- normalize again
        if i = 27 then -- shift right by one
            man := shift(man, 1, '0', '1');
            exp := bitAdd(exp, one(8))(7 downto 0); -- ignore extra bit returned
        elsif 26-i < to_integer(unsigned(exp)) then
            man := shift(man, 26-i, '1', '0');
            exp := bitDiff(exp, std_logic_vector(to_unsigned(26-i, 8)));
        elsif i = 26 and exp = zero(8) then
            exp := one(8);
        else -- shift would set exponent into negative
            exp := zero(8);           
        end if;
    end normalize;
    
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
        variable i: integer := a'right;
    begin
        result := (others => '0');
        while i <= a'left loop
            result(i) := carry xor a(i) xor b(i);
            carry := (a(i) and b(i)) or (a(i) and carry) or (b(i) and carry);
            i := i+1;
        end loop;
        result(result'left) := carry;
        return result;
    end bitAdd;
    
    function shift(vector: std_logic_vector; count: integer; shiftLeft, stickyBit: std_logic)
        return std_logic_vector is
        
        variable result: std_logic_vector(vector'range):= (others => '0');
        variable sourceIndex: integer;
        variable destinationIndex: integer;
        variable sticky: std_logic := '0';
    begin
        if count = 0 then
            return vector;
        elsif count >= vector'length then
            return result; -- all 0 vector
        end if;
        if shiftLeft = '1' then
            sourceIndex := vector'right;
            destinationIndex := sourceIndex + count;

            while destinationIndex <= vector'left loop
                result(destinationIndex) := vector(sourceIndex);
                destinationIndex := destinationIndex + 1;
                sourceIndex := sourceIndex + 1;
            end loop;

            if stickyBit = '1' then
                while sourceIndex <= vector'left loop
                    sticky := sticky or vector(sourceIndex);
                    sourceIndex := sourceIndex + 1;
                end loop;
                result(destinationIndex-1) := sticky or result(destinationIndex-1);
            end if;
        else
            sourceIndex := vector'left;
            destinationIndex := sourceIndex - count;
            
            while destinationIndex >= vector'right loop
                result(destinationIndex) := vector(sourceIndex);
                destinationIndex := destinationIndex - 1;
                sourceIndex := sourceIndex - 1;
            end loop;

            if stickyBit = '1' then
                while sourceIndex >= vector'right loop
                    sticky := sticky or vector(sourceIndex);
                    sourceIndex := sourceIndex - 1;
                end loop;
                result(destinationIndex+1) := sticky or result(destinationIndex+1);
            end if;
        end if;
        return result;
    end shift;

    -- computes difference of two std_logic_vector (treated as unsigned values) unsigned values, send first parameter as larger value, and second as smaller value
    function bitDiff(a, b: std_logic_vector)
        return std_logic_vector is

        variable zero: std_logic_vector(a'range):= (others => '0');
        variable i: integer:= a'right;
        variable carryIndex: integer;
        variable big: std_logic_vector(a'range) := a;
        variable small: std_logic_vector(b'range) := b;
        variable result: std_logic_vector(a'range):= (others => '0');
    begin
        if a = zero then -- cannot subtract from unsigned 0
            return a;
        end if;
        while i <= a'left loop
            if big(i) = '1' and small(i)='1' then -- 1,1
                result(i) := '0';
            elsif big(i) = '0' and small(i) = '0' then
                result(i) := '0';
            elsif big(i) = '1' and small(i) = '0' then  -- 1,0
                result(i) := '1';
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

    function fpSub(a, b: std_logic_vector(31 downto 0))
        return std_logic_vector is
        variable bNeg: std_logic_vector(31 downto 0);
    begin
        bNeg(31) := not b(31);
        bNeg(30 downto 0) := b(30 downto 0);
        return fpadd(a, bNeg);
    end fpSub;

    function round(a: std_logic_vector(31 downto 0))
    return std_logic_vector is
        variable offset : std_logic_vector(7 downto 0);
        variable bias: std_logic_vector(7 downto 0):= "01111111";
        variable half: std_logic;
        variable sticky: std_logic;
        variable i: integer;
        variable fracIndex: integer;
        variable exponent:std_logic_vector(7 downto 0);
        variable result: std_logic_vector(a'range);
        variable mantissa: std_logic_vector(23 downto 0); -- 24 bits (1).(23 bits)
        variable mantissaAdd: std_logic_vector(24 downto 0) := (others => '0'); -- extra bit from addition carryout
        variable upVector: std_logic_vector(mantissa'range):= (others => '0'); -- vector to add by one
    begin
        result := a;
        exponent := a(30 downto 23);
        mantissa(23) := '1'; -- denormalized values all round to 0, assume leading bit is 1
        mantissa(22 downto 0) := a(22 downto 0);
        if exponent(exponent'left) = '1' or exponent = bias then -- exponent >= bias
            offset := bitDiff(exponent, bias);
            fracIndex := 22 - to_integer(unsigned(offset));
            if fracIndex < 0 then -- a has no fractional bits (large number)
                return a;
            end if;
        else -- mantissa is all fractional bits
            offset := bitDiff(bias, exponent);
            fracIndex:= 22 + to_integer(unsigned(offset));

            if fracIndex > mantissa'left then
                result(30 downto 0) := (others => '0');
                return result; -- value is between -.5 and .5 (excluding endpoints) and rounds to 0
            end if;
        end if;

        half := mantissa(fracIndex); 
        
        if not(fracIndex = mantissa'left) then       
            upVector(fracIndex+1):= '1';
        end if;

        sticky := '0';
        i := fracIndex-1;
        while i >= 0 and sticky = '0' loop
            sticky := sticky or mantissa(i);
            i := i - 1;
        end loop;
        
        -- all information from original mantissa is aquired, clear fractional bits
        mantissa(fracIndex downto 0):= (others => '0');
        
        if fracIndex = mantissa'left then -- implied mantissa msb is first fraction bit (therefore half = '1')
            if sticky = '1' then -- round up
                -- manually add one into addition carry out position, since upVector is too small to hold it
                mantissaAdd(mantissaAdd'left) := '1';
                mantissaAdd(mantissa'range) := mantissa;
            else -- round down
                result(22 downto 0) := mantissa(22 downto 0);
                return result;
            end if;
        elsif (half and sticky) = '1' then -- round up
            mantissaAdd := bitAdd(mantissa, upVector);
        elsif half = '1' then-- round to even
            if mantissa(fracIndex+1) = '1' then
                mantissaAdd := bitAdd(mantissa, upVector);
            end if;
        else -- round down 
            result(22 downto 0) := mantissa(22 downto 0);
            return result;
        end if;

        -- rounded up, may need to renormalize
        if mantissaAdd(mantissaAdd'left) = '1' then -- renormalize
            exponent := bitAdd(exponent, one(exponent'length))(7 downto 0); -- exponent overflow case skipped by exiting early above (for exponents that leave no fractional bits in mantissa)
            mantissaAdd := shift(mantissaAdd, 1, '0', '0');
            result(30 downto 23) := exponent;
        end if;

        result(22 downto 0) := mantissaAdd(22 downto 0);
        return result;
    end round;

    function min(a,b: std_logic_vector; ignoreMSB: std_logic)
    return std_logic_vector is
        variable i: integer:= a'left;
    begin
        if ignoreMSB = '1' then
            i := i-1;
        end if;
        while i >= a'right and a(i) = b(i) loop
            i:= i-1;
        end loop;
        
        if i = -1 then
            return a;
        end if;

        if a(i) = '0' then
            return a;
        else
            return b;
        end if;
    end min;

    function max(a,b: std_logic_vector; ignoreMSB: std_logic)
    return std_logic_vector is
        variable i: integer:= a'left;
    begin
        if ignoreMSB = '1' then
            i := i-1;
        end if;
        while i >= a'right and a(i) = b(i) loop
            i:= i-1;
        end loop;
        
        if i = -1 then
            return a;
        end if;

        if a(i) = '1' then
            return a;
        else
            return b;
        end if;
    end max;

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

    function power(A,B: std_logic_vector(31 downto 0))
            return std_logic_vector is 
            variable C: std_logic_vector(a'range);
            variable A_real: real;
            variable B_real: real;
        begin
               A_real := FptoDec(A);
               B_real := FptoDec(B);
               C := DectoFp( A_real ** B_real);
               return C;
        end power;
    
    function mul (a, b: std_logic_vector (31 downto 0))
    return std_logic_vector is
            variable c: real;
            variable a_real: real;
            variable b_real: real;
        begin
            a_real := FptoDec(a);
            b_real := FptoDec(b);
            c := a_real * b_real;
        return DectoFp(c);
     end mul;
     
    function div (a, b: std_logic_vector (31 downto 0))
    return std_logic_vector is
        variable c: real;
        variable a_real: real;
        variable b_real: real;
        begin
        a_real := FptoDec(a);
        b_real := FptoDec(b);
        c := a_real / b_real;
        return DectoFp(c);
     end div;
        
    function expo(A: std_logic_vector(31 downto 0))
            return std_logic_vector is 
            variable C: std_logic_vector(a'range);
    function expo(A,B: std_logic_vector(31 downto 0))
     
    function floor (a, b: std_logic_vector (31 downto 0))
    return real is
        variable c: real;
        begin
        return c;
    end floor;
    
    function ceil (a, b: std_logic_vector (31 downto 0))
    return real is
        variable c: real;
        begin
        return c;
    end ceil;
    
    function power(A,B: std_logic_vector(31 downto 0))
            return real is 
            variable C: real;
            variable A_real: real;
            variable Euler_num: real;
    begin
            A_real := FptoDec(A);
            Euler_num := 2.718281828459;
            C := DecToFp(Euler_num ** A_real);
            return C;
    end expo;        
            
function sqrt(A: std_logic_vector(31 downto 0))
                return std_logic_vector is
                variable A_real: real;
                variable C: std_logic_vector(a'range);
        begin
                A_real := FptoDec(A);
                C := DecToFp(A_real ** 0.5);
                return C;
        end sqrt;            
end Math;    