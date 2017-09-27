vec = 1:9
vec2 = runif(9,min=0,max=10)
plotTwo <- function(x,y){
  

plot(x,y)
lines(x,y)
pdf('plottwo.pdf')
plot(x,y)
lines(x,y)

dev.off()
return(c(x,y))
}
plotTwo(vec,vec2)

sampleforloop <- function(iV){
  for(i in 1:length(iV)){
    iV[i] = i
  }
  return(iV)
}
vec3 = sampleforloop(vec)
vec4 = sampleforloop(vec2) - runif(9,min=0,max=10)

plotTwo(vec3,vec4)