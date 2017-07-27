import matplotlib.pyplot as plt
import numpy as np,math, openpyxl as xl
#2.11 roll-off point calculation
from scipy.optimize import fsolve,curve_fit
R1 = 10.39e3
R2 = 979.
Vin = [8.,4.,2.,1.,0.7,0.5]
#transfer = lambda f: np.absolute((r- 1j*r**2*2*np.pi*f*C)/(R*(1+(r*2*np.pi*f*C)**2 - 1j*r**2*2*np.pi*f*C)))
V = []
IloadR1 = []
IloadR2 = []
for vin in Vin:
    V.append(np.linspace(0,vin,100))

    IloadR1.append(np.poly1d(np.polyfit([0,vin],[vin/R1,0],1)))
    IloadR2.append(np.poly1d(np.polyfit([0,vin],[vin/R2,0],1)))
for i in range(len(V)):
    a=1
    #IloadR1.append(np.vectorize(lambda v: (Vin[i]-v)/R1)(V[i]))
    #IloadR2.append(np.vectorize(lambda v: (Vin[i]-v)/R2)(V[i]))
data = xl.load_workbook('/Users/JoshuaLevy/Desktop/lab3/Diode2.xlsx').active.rows
exceldoc = np.vectorize(lambda x: float(str(x._value).strip('u\''))*1000)(data[50:])
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
for i in range(len(IloadR1)):
    print '%f,%f,%f'%(Vin[i],fsolve(lambda v:IloadR1[i](v)-diodecurve(v),10)[0], diodecurve(fsolve(lambda v:IloadR1[i](v)-diodecurve(v),10))[0]*1e3)
for i in range(len(IloadR2)):
    print '%f,%f,%f'%(Vin[i],fsolve(lambda v:IloadR2[i](v)-diodecurve(v),10)[0], diodecurve(fsolve(lambda v:IloadR2[i](v)-diodecurve(v),10))[0]*1e3)

#2.11
f = np.array([10,20,50,100,200,500,1e3,1.5e3,3e3,10e3,30e3,100e3,300e3,1e6])
V_pp = np.array([3.2,3.2,3.2,3.2,3.2,3.12,2.64,2.2,1.36,.448,.144,.031,.013,.013]) #in volts
plt.loglog(f,V_pp,'ko',label = 'Vout Experimental')
plt.loglog(f,transfer_relative(f) * 10.,'r', label = 'Vout Calculated')
plt.xlabel(r'$f$ (Hz)',{'size' : 16})
plt.ylabel(r'$V_{out}$ (V)',{'size' : 16})
plt.title('Vout vs Frequency')
plt.legend()
plt.show()
