import random as rand

maxValue = 1000000
numbers = []
for _ in range(5000):
    numbers.append(rand.uniform(-maxValue, maxValue))

numbers.sort()
for number in numbers:
    print(f'{number:.08f}')
