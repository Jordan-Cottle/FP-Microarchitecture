import urllib.request, json 
from time import sleep

inputFile = open('C:\\Users\\Jordan\\Documents\\Projects\\FP-Microarchitecture\\Simulation\\Simulation.configuration\\InputFiles\\fpValues.txt', 'r')
outputFile = open('C:\\Users\\Jordan\\Documents\\Projects\\FP-Microarchitecture\\Simulation\\Simulation.configuration\\OutputFiles\\decValues.txt', 'r')

count = 1
for line in inputFile:
    with urllib.request.urlopen("https://www.h-schmidt.net/FloatConverter/binary-json.py?binary=" + line) as url:
        data = json.loads(url.read().decode())
        expected = float(data['decimalRepr'])
        result = float(outputFile.readline())

        if abs(result - expected) > abs(expected / 100000):
            print(f'{count}: expected {expected}, got {result}')
        else:
            print(f'{count}: success!')

    count += 1


inputFile.close()