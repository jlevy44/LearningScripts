import numpy as np, math

#p = np.vectorize(lambda x: np.floor(math.factorial(x)%(x+1) /x)*(x-1)+2)(np.arange(1,10001))
#p = lambda x: np.floor(math.factorial(x)%(x+1) /x)*(x-1)+2
#print p(10001)
primelist = []
i = 1
primeCount = 0
while i<2000000:#primeCount < 10002:
    if i == 2:
        primeCount+=1
        primelist.append(i)
    if i%2!=0:
        a = np.arange(1,math.ceil(float(i)/2),2)
        if np.all(i%a[1:] != 0):
            primeCount += 1
            primelist.append(i)
    #if i > 2000000:
    #    break
    i+=1
print sum(primelist)