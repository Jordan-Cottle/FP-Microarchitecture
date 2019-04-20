import random as r
from os import path

scriptPath = path.abspath(__file__)
scriptDirPath = path.split(scriptPath)[0]
configPath = path.split(scriptDirPath)[0]

fpFile = open(f'{configPath}/InputFiles/fpValues.txt', 'w')

lastExponent = 127
bitVectors = []
for i in range (100000):
    sign = str(r.randint(0,1))
    exponent = ''.join((str(r.randint(0,1)) for _ in range(8)))
    lastExponent = exponent
    mantissa = ''.join((str(r.randint(0,1)) for _ in range(23)))

    binaryString = ''.join([sign,exponent,mantissa])
    bitVectors.append(binaryString)

#bitVectors.sort()
for bitVector in bitVectors:
    print(bitVector, file =fpFile)

fpFile.close()