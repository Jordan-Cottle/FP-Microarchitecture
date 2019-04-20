from os import path

def isRoundingDifference(a,b):
    foundDiff = False
    for i in range(len(a)):
        if a[i] == b[i] and not foundDiff:
            continue
        foundDiff = True
        if foundDiff and a[i] == b[i]:
            return False
    
    return True


scriptPath = path.abspath(__file__)
scriptDirPath = path.split(scriptPath)[0]
configPath = path.split(scriptDirPath)[0]

resultsFile = open(f'{configPath}/OutputFiles/addResults.txt', 'r')
answerKey = open(f'{configPath}/OutputFiles/addAnswerKey.txt', 'r')
testResults = open(f'{configPath}/OutputFiles/fpAddResults.txt', 'w')

results = resultsFile.readlines()
answers = answerKey.readlines()

successCount = 0
failCount = 0
for i in range(1,len(results)+1):
    result = results[i-1][0:32]
    answer = answers[i-1][0:32]

    if result != answer:
        if isRoundingDifference(answer, result):
            print(f'{i}: Rounding error', file=testResults)
            successCount += 1
        else:
            print(f'{i}: \n{answer}\n{result}')
            print(f'{i}: Fail',file=testResults)
            failCount += 1
        #print('Failed on test', i+1)
    else:
        print(f'{i}: Success',file=testResults)
        successCount += 1
        #print('Success on test', i+1)

print(f'Success: {successCount}')
print(f'Fail: {failCount}')

resultsFile.close()
answerKey.close()
testResults.close()