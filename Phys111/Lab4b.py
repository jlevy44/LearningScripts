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

data_sat = np.array(xl.load_workbook('/Users/JoshuaLevy/Desktop/ClassesFall2016/111A/lab4/JFETOut2sat.xlsx').active.rows)
data_lin = np.array(xl.load_workbook('/Users/JoshuaLevy/Desktop/ClassesFall2016/111A/lab4/JFETOut2lin.xlsx').active.rows)
a=1
#print data[1:,0:2]
exceldoc_sat = np.vectorize(lambda x: float(str(x._value).strip('u\'')))(data_sat[2:,:])
exceldoc_lin = np.vectorize(lambda x: float(str(x._value).strip('u\'')))(data_lin[2:,:])


Vds_sat = exceldoc_sat[0:,0]
Vds_lin = exceldoc_lin[0:,0]
Vgs_sat = np.vectorize(lambda x: float(str(x._value).strip('u\'')))(data_sat[1,1:])
Vgs_lin = np.vectorize(lambda x: float(str(x._value).strip('u\'')))(data_lin[1,1:])
i_sat = exceldoc_sat[0:,1:]
i_lin = exceldoc_lin[0:,1:]
a=1

#diodecurve = lambda x: 2.7e-8*(np.exp(19.246*x)-1)
a=1


#plt.plot(np.vectorize(lambda x: x*1e-3)(V),np.vectorize(lambda x: x*1e-3)(I), label = 'JFET Gate Transfer Characteristic Curve',marker = '*')
for i in range(len(Vgs_sat)):
    print np.shape(Vds_sat),np.shape(i_sat[0:,i])
    plt.plot(Vds_sat,i_sat[0:,i],label= 'VGS = %f'%Vgs_sat[i])
for line in Loadlines:
    print line
    #plt.plot(line[0],line[1],label = 'Loadline of %f'%line[0][0])
    #plt.plot([line[0][0]+0.05,0],[0,(line[0][0]+0.05)/R],'--',color='k')
    #plt.plot([line[0][0]-0.05,0],[0,(line[0][0]-0.05)/R],'--',color = 'k')
plt.xlabel('Vds (V)')
plt.ylabel('Current I (A)')
plt.title('JFET Output Characteristic Curve Saturated Regime')
plt.legend(loc = 'center right',prop = {'size':15})
plt.show()

for i in range(len(Vgs_lin)):
    plt.plot(Vds_lin,i_lin[0:,i],label= 'VGS = %f'%Vgs_lin[i])
for line in Loadlines:
    print line
    #plt.plot(line[0],line[1],label = 'Loadline of %f'%line[0][0])
    #plt.plot([line[0][0]+0.05,0],[0,(line[0][0]+0.05)/R],'--',color='k')
    #plt.plot([line[0][0]-0.05,0],[0,(line[0][0]-0.05)/R],'--',color = 'k')
plt.xlabel('Vds (V)')
plt.ylabel('Current I (A)')
plt.title('JFET Output Characteristic Curve Linear Regime')
plt.legend(loc = 'upper left',prop = {'size':15})
plt.show()
