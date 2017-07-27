import numpy as np
import matplotlib.pyplot as plt
import math

R = 1.*10e3
C = 1. * 10e-9

freq = np.array([10,20,50,100,200,500,1000,2000,5000,10000,20000])
measgain = np.array([-44.18404745,-38.08032834,-30.10185457,-24.06947185,
            -18.18534893,-10.54531415,-5.583512335,-2.328966385,-0.501975997,-0.283500026,-0.225315605])
measPhase = np.array([95,91,88,87,83,72,58,40,18,9,5])*1
f = np.logspace(1,5,50)
phi = np.vectorize(lambda x: math.degrees(math.atan2(1/(2*math.pi*x*1*10e-9),1*10e3)))(f)
Hf = np.vectorize(lambda x: R/math.sqrt(R**2 + (1/(2*math.pi*x*C))**2))(f)
Hfmeas = [0.006177285,0.012473364,0.03125412,0.062593092,0.12323457,0.296984848,0.525804602,0.764806695,0.943846132,0.967887762,0.974393144]

plt.subplot(3,1,1)
GainPlot = plt.plot(freq,measgain,'o', label='Measured Gain')
plt.xlabel('Frequency (Hz)')
plt.ylabel('Measured Gain (dB)')
plt.xscale('log')
plt.title('Frequency vs (Measured Gain, Phase Shift, Transfer Function)')
plt.legend(loc = 'upper left',prop = {'size':11})


plt.subplot(3,1,2)
plt.plot(freq,measPhase,'o', label='Measured Phase Shift')
plt.plot(f,phi,label='Predicted Phase Shift')
plt.xlabel('Frequency (Hz)')
plt.ylabel('|Phase Shift (degrees)|')
plt.xscale('log')
plt.legend(prop = {'size':11})


plt.subplot(3,1,3) #FIXME
plt.plot(f,Hf, label='Predicted Transfer Function')
plt.plot(freq,Hfmeas,'o', label='Measured Transfer Function')
plt.xlabel('Frequency (Hz)')
plt.ylabel('|Vout/Vin|')
plt.xscale('log')
plt.legend(loc = 'lower right',prop = {'size':11})




plt.show()