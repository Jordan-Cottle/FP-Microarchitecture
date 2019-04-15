import random as r

bitVectors = []
for _ in range (5000):
    binaryString = [str(r.randint(0,1)) for _ in range(32)]
    bitVectors.append(''.join(binaryString))

bitVectors.sort()
for bitVector in bitVectors:
    print(bitVector)