import matplotlib.pyplot as plt
import numpy as np
#2.11 roll-off point calculation
from scipy.optimize import fsolve
r = 1.e6
C_S = 11.5e-12
C_BNC = 162.e-12
C = C_S + C_BNC
R = 2.e6
#transfer = lambda f: np.absolute((r- 1j*r**2*2*np.pi*f*C)/(R*(1+(r*2*np.pi*f*C)**2 - 1j*r**2*2*np.pi*f*C)))
transfer_relative = lambda f: np.absolute(r/(R*(r*1j*2*np.pi*f*C+1) + r))
f_rolloff = lambda f: transfer_relative(f) - 1/np.sqrt(2)/3.125
f_rolloffFinal = fsolve(f_rolloff, 1.0e3 )
print f_rolloffFinal

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
