def is_true(i):

    if i==2:
        return True
    else:
        return False

print(is_true(2))

def lalala(i):
    return lambda y: i**2

print(lalala(5))

print('alpha' > 'beta')

d='hello'

for p in d: print(p)
print(d[-2:2])

def add(x,y):
    print x+y

add(2,6)

def make_scalar(c):
    return lambda n: c*(n)

tripleAdd=make_scalar(3)

print tripleAdd(2)