from urllib import request
from json import loads
import random

def countOnes(binaryString):
    return sum(map(int, list(binaryString)))

def divideByTwo(num, showWork = False):
    bits = []
    num = int(abs(num))

    while num >= 1:
        if showWork:
            print(f'{num:<3} | {num%2}')
        bits.append(num % 2)
        num //= 2

    if len(bits) == 0:
        return '0'
    # flip order of bits, and convert to string
    return ''.join([str(bit) for bit in bits[::-1]])

def mulByTwo(decimal, maxBitLength = 64, showWork = False):
    bits = []
    while decimal != 0 and len(bits) < maxBitLength:
        if showWork:
            print(f'{decimal:.04f}*2 = {decimal*2:.04f}')
        decimal *= 2
        if decimal >= 1:
            decimal -= 1
            bits.append('1')
        else:
            bits.append('0')

    return ''.join(bits)


def twosCompliment(binaryNum):
    compliment = []

    copy = True
    for bit in binaryNum[::-1]:
        if copy == True and bit == '1':
            copy = False
            compliment.append('1')
        elif copy:
            compliment.append(bit)
        elif bit == '1':
            compliment.append('0')
        else:
            compliment.append('1')
    
    return ''.join(compliment[::-1])

def toBinary(integer, maxBitLength = 0):
     # get binary at minimum bit length from divide by two method
    bits = divideByTwo(integer)

    if integer < 0:
        bits = twosCompliment(bits)
    if(maxBitLength == 0):  # return minimum number of bits for number
        return  bits
    elif len(bits) > maxBitLength:
        return bits[(len(bits)-1) - maxBitLength:] # return maxBitLength number of bits, starting from lsb

    # 0 extend to desired bit length
    while len(bits) < maxBitLength:
        bits = '0' + bits
    
    return bits

def decToFp(decimal, breakUp = False):
    if decimal == 0:
        return "0"*32
    signBit = '1' if decimal < 0 else '0'

    integer = toBinary(abs(int(decimal)))
    fraction = mulByTwo(abs(decimal)%1, 25)

    binary = f"{integer}.{fraction}"

    # find decimal position
    decPos = binary.index('.')

    #calculate exponent for scientific notation
    expo = decPos - 1
    if(abs(decimal) < 1): # count until 1 is found
        expo -= 1
        while(binary[decPos +1]!='1'):
            decPos += 1
            expo -= 1
    
    #remove decimal point from binary string
    binary = binary.replace('.', '')
    

    exponent = toBinary(127 + expo, 8) # set bias 

    #find leading 1
    index = 0
    while(binary[index] == '0'):
        index += 1
    binary = binary[index:]
    
    #drop leading 1
    mantissa = binary[1:]
    
    if len(mantissa) < 23:
        mantissa += '0' * (23-len(mantissa))
    elif len(mantissa) > 23:
        extraBits = mantissa[23:]
        g = r = s = 0
        # compute grs
        if len(extraBits) >= 3:
            g = extraBits[0]
            r = extraBits[1]
            if sum(list(map(int, extraBits[2:]))) > 0: #at least one bit in sticky extra bits
                s = '1'
            else:
                s = '0'
        elif len(extraBits) == 2:
            g = extraBits[0]
            r = extraBits[1]
            s = '0'
        else:
            g = mantissa[23]
            r = '0'
            s = '0'
        
        if g =='0': # truncate
            mantissa = mantissa[0:23]
        elif s == '1' or r == '1': #round up
            mantissa = bin(int(mantissa[0:23],2) + 1)[2:]
        else: # grs = 100, round to even
            if mantissa[22] == '1':
                mantissa = bin(int(mantissa[0:23],2) + 1)[2:]
            else:
                mantissa = mantissa[0:23]

        if len(mantissa) < 23:
            mantissa = '0' * (23-len(mantissa)) + mantissa
        elif len(mantissa) > 23: # rounding up added an extra bit, shift right and add to exponent
            exponent = bin(int(exponent) + 1)[2:]
            mantissa = mantissa[1:24]
            

    if breakUp:
        return f'{signBit}|{exponent[0:4]} {exponent[4:8]}|{mantissa[0:4]} {mantissa[4:8]} {mantissa[8:12]} {mantissa[12:16]} {mantissa[16:20]} {mantissa[20:23]}'
    else:
        return f'{signBit}{exponent}{mantissa}'

def binToDec(binary, pow=7, showWork = False):
    sum = 0
    for digit in binary:
        if digit == '1':
            sum += 2**pow

            if showWork:
                if pow >= 0:
                    print(2**pow)
                else:
                    print(f'1/2^{abs(pow)}')
            
        pow -= 1
    
    return sum

def toHex(binary):
    hexDigits = '0123456789ABCDEF'
    start = 0
    hex = []
    while start < len(binary):
        byte = binary[start:start+4]
        dec = binToDec(byte)
        hex.append(hexDigits[dec])
        start+=4
    
    return ''.join(hex)

if __name__ == "__main__":
    errorCount = 0
    count = 0

    for _ in range(500):
        num = random.random() * 10000 - 5000
        print(num)
        with request.urlopen(f"https://www.h-schmidt.net/FloatConverter/binary-json.py?decimal={num}") as url:
            data = loads(url.read().decode())
            expected = data['binaryRepr']
            result = decToFp(num)
            if expected != result:
                print("Error")
                print(f'Expected: {expected}')
                print(f'Received: {result}')
        num += 0.015625
