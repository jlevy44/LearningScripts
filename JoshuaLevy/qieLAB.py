import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import multiprocessing as mp
import subprocess
import time


#runCommand = lambda x: subprocess.call(x, shell=True)

def runCommand(x):
    subprocess.call(x, shell=True)

def times100(x):
    return sum(range(x*1000))
x = 1001
array = range(1,x)

#print array

#print start
def mapped(x):
    if __name__ == '__main__':
        p = mp.Pool(x)
        #p.map(runCommand,["python hundred.py %d"%num for num in array])
        start = time.clock()
        array2 = p.map(times100,array)
        end = time.clock()
        t1 = end-start
        print start, end
        #print array2
        #p.close()
        #p.join()
        return t1


#print time.clock()
#print start
#array3 = np.arange(1,x)
#print array3
#start = time.clock()
#array4 = np.vectorize(lambda x: times100(x))(array3)
#t2 = time.clock()-start
#start = time.clock()
#array5 = [times100(num) for num in array]
#t3 = time.clock()-start

#print array2, t1
#print array4,t2
#print array5, t3

#print t1#,t2,t3
#print array2
#print array4
#print array5
start = time.clock()
#array2 = map(times100,array)
t1 = time.clock()-start
#print mp.cpu_count()
#print map(mapped,range(1,mp.cpu_count()+1)+[None])
#print t1