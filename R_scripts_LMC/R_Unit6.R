z = qnorm(.98)
x = seq(-3,3,length=1000)
y = dnorm(x,mean=0,sd = 1)
plot(x,y,xlab='Z-score',ylab='Probability',type='l',lwd=1)
for (i in seq(z,3.,length=100)) {
  print(i)
  lines(c(i,i),c(0,dnorm(i,mean=0,sd=1)),lwd=5)
}
z = (44.5 - 47.18)/1.40
plot(x,y,xlab='Z-score',ylab='Probability',type='l',lwd=1)
for (i in seq(-3,z,length=100)) {
  lines(c(i,i),c(0,dnorm(i,mean=0,sd=1)),lwd=5)
}


