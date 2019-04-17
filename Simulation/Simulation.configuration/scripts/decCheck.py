from urllib import request
from json import loads
from os import path

scriptPath = path.abspath(__file__)
scriptDirPath = path.split(scriptPath)[0]
configPath = path.split(scriptDirPath)[0]

inputFile = open(f'{configPath}\\InputFiles\\fpValues.txt', 'r')
outputFile = open(f'{configPath}\\OutputFiles\\decValues.txt', 'r')
resultsFile = open(f'{configPath}\\OutputFiles\\decimalConversionTestResults.txt', 'w', buffering=1)

count = 1
errorCount = 0
for line in inputFile:
    with request.urlopen("https://www.h-schmidt.net/FloatConverter/binary-json.py?binary=" + line) as url:
        data = loads(url.read().decode())
        expected = float(data['decimalRepr'])
        result = float(outputFile.readline())

        if abs(result - expected) > abs(expected / 100000):
            print(f'{count}: expected {expected}, got {result}', file=resultsFile)
            errorCount += 1
        else:
            print(f'{count}: success!', file=resultsFile)
    count += 1

print(f'{errorCount} errors found!', file=resultsFile)

inputFile.close()
outputFile.close()
resultsFile.close()