from fractions import gcd
import random, datetime
import numpy as np
from collections import defaultdict
#N = 600851475143
for N in [15, 21, 35, 18, 600851475143]:
    (y1,y2) = (1,1)
    a = 1
    while a == 1 or a == -1  or a == N:
        r = ''
        x=1

        while r == '':
            random.seed(datetime.datetime.now())
            x = random.randint(1,N-1)
            fa = np.vectorize(lambda a: (x**a)%N)(np.arange(36))
            print fa
            if fa != None:
                faDict = {k:[] for k in set(fa)}#dict.fromkeys(list(fa),[])

                for i in range(len(fa)):
                    faDict[fa[i]].append(i)

                for key in faDict.keys():
                    if len(faDict[key]) > 1:
                        r = faDict[key][1] - faDict[key][0]
                        print(r)
                        break

        y1 = x**(r/2) + 1
        y2 = x**(r/2) - 1

        print(y1,y2)

        PQ = [gcd(y1,N), gcd(y2,N)]

        print(np.max(PQ))
        a = np.max(PQ)
    print 'output of %d='%N + str(a)
    b = raw_input('')

"""
for N in [81, 15, 21, 35, 18, 600851475143]:
    x = np.array(np.arange(1,N))

    a = x[N%x == 0] #x[np.array(np.vectorize(lambda y: N%y == 0)(x)),0]
    print a
    N2 = [0,max(a)]
    i = 1
    while N2[i] != N2[i-1]:
        #a = a[a != 1]
        #a = a[a != N2[-1]]
        a = a[np.all([np.max(a)%a == 0, np.vectorize(lambda x: x!=1)(a)])]#a[np.all([N2[-1]%a == 0, a != 1])]#, a != N2[-2]])]

        N2.append(max(a))
        i+=1

    print N2[-1]
"""