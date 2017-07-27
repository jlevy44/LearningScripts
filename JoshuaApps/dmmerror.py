import math

inputVal = float(input('Type in value: '))
inputRange = float(input('Range: '))

print (0.012e-2 * inputVal + 0.00004 * inputRange)

vin = 26.25
r1 = 470.62
r2 = 9.946
dVin = 0.00715
dR1 = 0.0964744
dR2 = 0.00519


def errCurrent (vin,r1,r2,dVin,dR1,dR2):
    return math.sqrt(dVin**2 + (vin/(r1+r2))**2*(dR1**2+dR2**2))/(r1+r2)

def errVa(vin,r1,r2,dVin,dR1,dR2):
    return math.sqrt((r2*dVin)**2+(vin/(r1+r2))**2*(r2**2*dR1**2+r1**2*dR2**2))/(r1+r2)

print errCurrent(vin,r1,r2,dVin,dR1,dR2)

print errVa(vin,r1,r2,dVin,dR1,dR2)
