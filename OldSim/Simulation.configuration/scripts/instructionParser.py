from os import path
from fpConverter import decToFp

scriptPath = path.abspath(__file__)
scriptDirPath = path.split(scriptPath)[0]
configPath = path.split(scriptDirPath)[0]

n = '2'
programName = "pipe"
singleCycle = False
outputName = f"{programName}Program"
inputFileName = f"{programName}input{n}.txt"
outputFileName = f"{programName}program{n}.txt"
inputFile = open(f'{configPath}/Programs/{inputFileName}', 'r')


instructions = inputFile.readlines()
inputFile.close()

cleanedFile = []
commentStart = ";"
# convert immediate values
for line in instructions:
    endLine = line.find(commentStart) # remove inline comments
    if endLine != -1:
        items = line[:endLine].split()
    else:
        items = line.split()

    if len(items) >0: #ignore blank lines
        cleanedFile.append(items)

endProgram = cleanedFile.index(["HALT"])
print(cleanedFile)

initialMemoryAddresses = int(cleanedFile[endProgram+1][0])
print(f'Initial Memory addresses = {initialMemoryAddresses}')

hasStartingMemoryState = initialMemoryAddresses != 0

convertedImmediateValues = []
print("Instructions:")
#loop through valid instructions, convert immediate values and set on new line
for i in range(endProgram+1):
    line = cleanedFile[i]
    newLine = []
    nextLine = []
    print(line)
    for item in line:
        if item.find('#') != -1:
            print(item[1:])
            fp = decToFp(float(item[1:]))
            line.remove(item)
            nextLine = [fp]
        else: # ignore rest
            newLine.append(item)
    convertedImmediateValues.append(newLine)
    convertedImmediateValues.append(nextLine)

opCodes = {
    "SET": "10000",
    "LOAD": "10001",
    "STORE": "10010",
    "MOVE": "10011",
    "ADD": "00000",
    "SUB": "00001",
    "NEG": "00010",
    "MUL": "00011",
    "DIV": "00100",
    "FLOOR": "00101",
    "CEIL": "00110",
    "ROUND": "00111",
    "ABS": "01000",
    "MIN": "01001",
    "MAX": "01010",
    "POW": "01011",
    "EEXP": "01100",
    "SQRT": "01101",
    "UB": "11010",
    "BZ": "11000",
    "BN": "11001",
    "PASS": "11111",
    "HALT": "10101"
    }
# ops that need Rd padded out
needsPadding = {opCodes["STORE"], opCodes["BZ"], opCodes["BN"]}

branchLabels = {}
allButLabelDesintations = []
print("Converted Immediate Values:")
# loop through instructions + IVs, convert opcodes and registers to binary, note label locations
for i, line in enumerate(convertedImmediateValues):
    if singleCycle:
        offset = 6*initialMemoryAddresses
    else:
        offset = 14*initialMemoryAddresses
    newLine = []
    print(line)
    for item in line:
        if item[-1] == ':': # log branch labels
            branchLabels[item[:-1]] = i + offset
            #print(branchLabels[item[:-1]])
        elif item in opCodes:
            code = opCodes[item]
            newLine.append(code)

            # handle Store opcode by inserting blank for register destination
            if code in needsPadding:
                newLine.append("0000")
            elif item == "HALT":
                newLine.append(bin(i + offset)[2:].zfill(32-5))
        # convert register names
        elif item[0] == 'R': 
            address = bin(int(item[1:]))[2:].zfill(4)
            newLine.append(address)
        else: # is label reference or immediate value, skip
            newLine.append(item)
    allButLabelDesintations.append(newLine)

for label, index in branchLabels.items():
    print(label, index)

almostDone = []
print("Almost done: ")
for line in allButLabelDesintations:
    newLine = []
    #print(line)
    
    for item in line:
        if item in branchLabels:
            length = sum([len(s) for s in newLine])
            newLine.append(bin(branchLabels[item])[2:].zfill(32-length))
        else:
            newLine.append(item)
    print(newLine)
    almostDone.append(''.join(newLine))

instructionFile = []
# add zeroes to the end of lines less than 32 bits
for line in almostDone:
    if len(line) < 32:
        instructionFile.append(line + "0"*(32-len(line)))
    else:
        instructionFile.append(line)

for line in instructionFile:
    print(line)

#parse initial memory state and insert instrutions for simulation to use
memoryStateInstructions = []
for line in cleanedFile[endProgram+1:]:
    memoryStateInstructions.extend(line)

initialMem = []
# set up instructions to load in initial memory state
setR14 =    opCodes["SET"] + "1110"
setR15 =    opCodes["SET"] + "1111"
storeR14R15= opCodes["STORE"] + "0000" + "1110" + "1111"
noop = opCodes["PASS"] + "0" * (32 - len(opCodes["PASS"]))

# extend instructions to 32 bits
setR14 = setR14 + '0' * (32 - len(setR14))
setR15 = setR15 + '0' * (32 - len(setR15))
storeR14R15 = storeR14R15 + '0' * (32 - len(storeR14R15))

if int(memoryStateInstructions[0]) != 0: # parse memory for initial state
    for line in memoryStateInstructions[1:]:
        address, value = line.split("><")
        address = decToFp(float(address[1:]))
        value = decToFp(float(value[:-1]))

        initialMem.append(setR14)      # set address in r0
        initialMem.append(address)    # add in immediate value (address)
        initialMem.append(setR15)      # set value (in fp format) into R1
        initialMem.append(value)      # add in immediate value (fp)
        for _ in range (4): # store is dependant on Set instructions
            if not singleCycle:
                initialMem.append(noop)
                initialMem.append('0'*32)
        initialMem.append(storeR14R15)  # store fp value in R1 into memorey address in R0
        initialMem.append('0'*32)

finalFile = initialMem + instructionFile

with open(f'{configPath}/InputFiles/{outputFileName}', 'w') as outputFile:
    for line in finalFile:
        print(line, file=outputFile)
