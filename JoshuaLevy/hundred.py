import numpy as np
import sys
#print -np.sum(np.arange(1,101)**2) + np.sum(np.arange(1,101))**2
#print -np.sum(np.arange(1,11)**2) + np.sum(np.arange(1,11))**2

#print np.arange(1,11)**2

inp = sys.argv[1]
#print inp

try:
    print int(inp)*100
except:
    print 'Error, not integer'