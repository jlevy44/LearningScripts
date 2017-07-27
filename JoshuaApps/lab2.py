import numpy as np, matplotlib.pyplot as plt, math, openpyxl as xl

rs = 1e6
rl = 10e3
c = 97e-9
l = 2.61e-3
vin = 20
data = xl.load_workbook('2_6.xlsx').active.rows

exceldoc = np.vectorize(lambda x: float(str(x._value).strip('u\''))*1000)(data[1:])
f = exceldoc[:,0]
Vout = np.vectorize(lambda x: x*1e-3)(exceldoc[:,1])

f2= np.linspace(1000,1e5,1000)
Vout2 = np.vectorize(lambda x: 1e3*vin/rs/math.sqrt((1/rl)**2+(2*math.pi*x*c-1/(2*math.pi*x*l))**2))(f2)


print f,f2,Vout2,Vout

#plt.subplot(3,1,1)
plt.plot(f,Vout,'o', label='Vout Exp.')
plt.plot(f2,Vout2, label='Vout Theo.')
plt.xlabel('Frequency (Hz)')
plt.ylabel('Vout (mV)')
plt.xscale('log')
plt.yscale('log')
plt.title('Frequency vs Vout')
plt.legend(loc = 'upper left',prop = {'size':11})

plt.show()
