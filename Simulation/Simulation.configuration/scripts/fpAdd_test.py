from os import path

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
for i in range(1,len(results)-1):
    result = results[i+1][0:32]
    answer = answers[i+1][0:32]

    if result != answer:
        if result[0:31] == answer[0:31]:
            pass
            print(f'{i}: Rounding error', file=testResults)
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

10000001011000000000110111011111
10000000110000000011010101101011
10000000111111111110011001010010