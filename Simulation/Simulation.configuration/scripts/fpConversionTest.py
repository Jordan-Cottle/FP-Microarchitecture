fpFile = open('C:\\Users\\Jordan\\Documents\\Projects\\FP-Microarchitecture\\Simulation\\Simulation.configuration\\InputFiles\\fpValues.txt', 'r')
vectorFile = open('C:\\Users\\Jordan\\Documents\\Projects\\FP-Microarchitecture\\Simulation\\Simulation.configuration\\OutputFiles\\fpVectors.txt', 'r')

count = 1
for line in fpFile:
    result = vectorFile.readline()

    if line != result:
        if line[1:9] == '11111111':
            print(f'{count}:infinity case')
        else:
            print(f'{count}: expected {line}, got {result}')
    else:
        #print(f'{count}: success!')
        pass
    count += 1


fpFile.close()
vectorFile.close()