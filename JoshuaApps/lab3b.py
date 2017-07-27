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

data = xl.load_workbook('/Users/JoshuaLevy/Desktop/lab3/Diode2.xlsx').active.rows
exceldoc = np.vectorize(lambda x: float(str(x._value).strip('u\''))*1000)(data[1:])
def func(x, a, c, d):
    return a*np.exp(c*x)+d
V = exceldoc[:,0]
I = exceldoc[:,1]
#popt = curve_fit(func,V,I,p0 = [6e-9,1.2,0.001],maxfev = 10000)
#print popt
#diodecurve = np.poly1d(np.polyfit(V,I,7))
#diodecurve = lambda x: popt[0][0]*np.exp(popt[0][1]*x)+popt[0][2]
#diodecurve = lambda x: 6e-9*np.exp(18.652*x)
diodecurve = lambda x: 2.7e-8*(np.exp(19.246*x)-1)
a=1
#for i in range(len(IloadR1)):
#    print '%f,%f,%f'%(Vin[i],fsolve(lambda v:IloadR1[i](v)-diodecurve(v),10)[0], diodecurve(fsolve(lambda v:IloadR1[i](v)-diodecurve(v),10))[0]*1e3)
#for i in range(len(IloadR2)):
#    print '%f,%f,%f'%(Vin[i],fsolve(lambda v:IloadR2[i](v)-diodecurve(v),10)[0], diodecurve(fsolve(lambda v:IloadR2[i](v)-diodecurve(v),10))[0]*1e3)

#2.11
#f = np.array([10,20,50,100,200,500,1e3,1.5e3,3e3,10e3,30e3,100e3,300e3,1e6])
#V_pp = np.array([3.2,3.2,3.2,3.2,3.2,3.12,2.64,2.2,1.36,.448,.144,.031,.013,.013]) #in volts
#plt.loglog(f,V_pp,'ko',label = 'Vout Experimental')
#plt.loglog(f,transfer_relative(f) * 10.,'r', label = 'Vout Calculated')
#plt.xlabel(r'$f$ (Hz)',{'size' : 16})
#plt.ylabel(r'$V_{out}$ (V)',{'size' : 16})
#plt.title('Vout vs Frequency')
print V, I
plt.plot(np.vectorize(lambda x: x*1e-3)(V),np.vectorize(lambda x: x*1e-3)(I), label = 'Diode Characteristic Curve')
for line in Loadlines:
    print line
    plt.plot(line[0],line[1],label = 'Loadline of %f'%line[0][0])
    plt.plot([line[0][0]+0.05,0],[0,(line[0][0]+0.05)/R],'--',color='k')
    plt.plot([line[0][0]-0.05,0],[0,(line[0][0]-0.05)/R],'--',color = 'k')
plt.legend(loc = 'upper left',prop = {'size':11})
plt.show()
