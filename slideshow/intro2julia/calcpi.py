import math
import time


def mygcd(a, b):
    while (b != 0):
        tmp = b
        b = a % b
        a = tmp
    return a


def calcpi(N):
    cnt = 0
    for a in range(1, N + 1):
        for b in range(1, N + 1):
            if mygcd(a, b) == 1:
                cnt += 1
    prob = cnt / N / N
    return math.sqrt(6 / prob)


print(calcpi(10000))
