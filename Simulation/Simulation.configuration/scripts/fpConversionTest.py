from os import path

scriptPath = path.abspath(__file__)
scriptDirPath = path.split(scriptPath)[0]
configPath = path.split(scriptDirPath)[0]

fpFile = open(f'{configPath}/InputFiles/fpValues.txt', 'r')
vectorFile = open(f'{configPath}/OutputFiles/fpVectors.txt', 'r')
resultsFile = open(f'{configPath}/OutputFiles/fpConversionTestResults.txt', 'w')

count = 1
errorCount = 0
for line in fpFile:
    result = vectorFile.readline()

    if line != result:
        if line[1:9] == '11111111' and result[1:9] == '11111111':
            print(f'{count}: success!', file=resultsFile)
        else:
            print(f'{count}: expected {line}, got {result}', file=resultsFile)
            errorCount += 1
    else:
        print(f'{count}: success!',file=resultsFile)
        pass
    count += 1

print(f'{errorCount} errors found!', file=resultsFile)

fpFile.close()
vectorFile.close()
resultsFile.close()