import math
#Moc dau cua x
x0=0
#Gia tri x tai moc dau
y0=1
#moc cuoi cua doan can tinh
xn=1
h=0.1
yn=0
#So buoc
n=10

def f(x,y):
	return x*y**3 - y

def k(x,y):
	return (h*f(x,y))

#So do RK4
def RK4(x0,y0,xn,h):
    for i in range(n):
        k1 = k(x0,y0)
        k2 = k(x0+(0.5)*h,y0+(0.5)*k1)
        k3 = k(x0+(0.5)*h,y0+(0.5)*k2)
        k4 = k(x0+h,y0+k3)
        yn = y0+(k1+2*k2+2*k3+k4)/6
        print('%.4f\t%.4f\t%.4f'% (x0,y0,k1) )
        print('%.4f\t%.4f\t%.4f'% (x0+(0.5)*h,y0+(0.5)*k1,k2) )
        print('%.4f\t%.4f\t%.4f'% (x0+(0.5)*h,y0+(0.5)*k2,k3) )
        print('%.4f\t%.4f\t%.4f'% (x0+h,y0+k3,k4) )
        print('y',i+1,'=',yn)
        print('-------------------------')
        y0 = yn
        x0 = x0+h


print('\n--------BANG GIA TRI--------')
print('-------------------------')    
print('x0\ty0\thf(xn,yn)')
print('-------------------------')
print(RK4(x0,y0,xn,h))






