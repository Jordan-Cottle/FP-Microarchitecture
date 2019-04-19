import random as r
from os import path

scriptPath = path.abspath(__file__)
scriptDirPath = path.split(scriptPath)[0]
configPath = path.split(scriptDirPath)[0]

fpFile = open(f'{configPath}/InputFiles/fpValues.txt', 'r')


bitVectors = []
for _ in range (25000):
    binaryString = [str(r.randint(0,1)) for _ in range(32)]
    bitVectors.append(''.join(binaryString))

#bitVectors.sort()
for bitVector in bitVectors:
    print(bitVector, file =fpFile)

fpFile.close()