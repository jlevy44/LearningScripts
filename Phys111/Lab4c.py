import matplotlib.pyplot as plt
import numpy as np,math, openpyxl as xl
#2.11 roll-off point calculation
from scipy.optimize import fsolve,curve_fit
import math

print np.dot(np.array([-600*2,3000,3*-5400])*math.e**(-90),np.array([4,-4,1])/math.sqrt(33))


Voff = -10.
R = [560]#[3300,9700,97,703,407]
Loadlines = []
for r in R:
    Loadlines.append([[-10,0],[10./r,0],r])
#Loadlines = np.vectorize(lambda v: np.array([[0,v/R],[v,0]]))(Voff)

data = np.array(xl.load_workbook('/Users/JoshuaLevy/Desktop/ClassesFall2016/111A/lab4/JFETTrns2.xlsx').active.rows)
a=1
print data[1:,0:2]
print np.vectorize(lambda x: (str(x._value)))(data[1:,0:2])

exceldoc = np.sort(np.vectorize(lambda x: float(str(x._value).strip('u\'')))(data[1:,0:2]),axis=0)
def func(x, a, c, d):
    return a*np.exp(c*x)+d
V = exceldoc[:,0]
I = exceldoc[:,1]

#diodecurve = lambda x: 2.7e-8*(np.exp(19.246*x)-1)
a=1


print V, I
plt.plot(np.vectorize(lambda x: x)(V),np.vectorize(lambda x: x)(I), label = 'JFET Gate Transfer Characteristic Curve',marker = '*')
for line in Loadlines:
    print line
    plt.plot(line[0],line[1],label = 'Loadline for R = %.0f Ohms'%line[2])
    #plt.plot([line[0][0]+0.05,0],[0,(line[0][0]+0.05)/R],'--',color='k')
    #plt.plot([line[0][0]-0.05,0],[0,(line[0][0]-0.05)/R],'--',color = 'k')
plt.xlabel('VGS (V)')
plt.ylabel('Current Id (A)')
plt.title('JFET Gate Transfer Characteristic Curve Load Line Analysis')
plt.legend(loc = 'upper left',prop = {'size':12})
plt.show()
