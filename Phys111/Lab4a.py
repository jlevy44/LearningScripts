import matplotlib.pyplot as plt
import numpy as np,math, openpyxl as xl
#2.11 roll-off point calculation
from scipy.optimize import fsolve,curve_fit

Voff = [0.2,0.4,0.8]
R = 10.37*1e3
Loadlines = []
for voff in Voff:
    Loadlines.append([[voff,0],[0,voff/R]])
#Loadlines = np.vectorize(lambda v: np.array([[0,v/R],[v,0]]))(Voff)

data = np.array(xl.load_workbook('/Users/JoshuaLevy/Desktop/ClassesFall2016/111A/lab4/JFETTrns2.xlsx').active.rows)
a=1
print data[1:,0:2]
print np.vectorize(lambda x: (str(x._value)))(data[1:,0:2])

exceldoc = np.sort(np.vectorize(lambda x: float(str(x._value).strip('u\''))*1000)(data[1:,0:2]),axis=0)
def func(x, a, c, d):
    return a*np.exp(c*x)+d
V = exceldoc[:,0]
I = exceldoc[:,1]

#diodecurve = lambda x: 2.7e-8*(np.exp(19.246*x)-1)
a=1


print V, I
plt.plot(np.vectorize(lambda x: x*1e-3)(V),np.vectorize(lambda x: x*1e-3)(I), label = 'New JFET Gate Transfer Characteristic Curve',marker = '*')
for line in Loadlines:
    print line
    #plt.plot(line[0],line[1],label = 'Loadline of %f'%line[0][0])
    #plt.plot([line[0][0]+0.05,0],[0,(line[0][0]+0.05)/R],'--',color='k')
    #plt.plot([line[0][0]-0.05,0],[0,(line[0][0]-0.05)/R],'--',color = 'k')
plt.xlabel('VGS (V)')
plt.ylabel('Current Is (A)')
plt.title('New JFET Gate Transfer Characteristic Curve')
plt.legend(loc = 'upper left',prop = {'size':15})
plt.show()
