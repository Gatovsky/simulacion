library(Rlab)
#Aleatorias Discretas#

#funcion de densidad binomial: valor puntual
x <- dbinom(x=1:20, size=51, prob=1/16)
hist(x, ylab="P(20)", xlab=" éxitos", col="dodgerblue2", 
     border="black", main=("Densidad acumulada"))

#bernoulli
x <- seq(0,1, by=1)
y <- dbern(x, 0.5)
plot(y, type ="o")
plot(dbern(0, 0.5))

#uniforme de densidad

plotunif <- function(x, min = 0, max = 1, lwd = 1, col = 1, ...) {
  
  # Rejilla de valores del eje X
  if (missing(x)) {
    x <- seq(min - 0.5, max + 0.5, 0.01)
  }
  
  if(max < min) {
    stop("'min' must be lower than 'max'")
  }
  
  plot(x, dunif(x, min = min, max = max),
       xlim = c(min - 0.25, max + 0.25), type = "l",
       lty = 0, ylab = "f(x)", ...) 
  segments(min, 1/(max - min), max, 1/(max - min), col = col, lwd = lwd)
  segments(min - 2, 0, min, 0, lwd = lwd, col = col)
  segments(max, 0, max + 2, 0, lwd = lwd, col = col)
  points(min, 1/(max - min), pch = 19, col = col)
  points(max, 1/(max - min), pch = 19, col = col)
  segments(min, 0, min, 1/(max - min), lty = 2, col = col, lwd = lwd)
  segments(max, 0, max, 1/(max - min), lty = 2, col = col, lwd = lwd)
  points(0, min, pch = 21, col = col, bg = "white")
  points(max, min, pch = 21, col = col, bg = "white")
}

plotunif(min = 10, max = 20, lwd = 2, col = 4, main = "Densidad Uniforme")




#Aleatorias Continuas#

#beta
pbeta(0.9, 4, 2, lower.tail = F) #Probabilidad 

curve(pbeta(x, shape1=4, shape2=2), lwd=3, las=1,
      ylab='Densidad', col="blue")
abline(v = qbeta(0.9, 4, 2), col="red")

#expo
pexp(3, rate = 0.2) # visita 3 minutos
# 1 - pexp(3, rate = 0.2, lower.tail = FALSE) # Equivalente

pexp(10, rate = 0.2, lower.tail = FALSE)  #visita 10 minutos


exp_area <- function(rate = 1, lb, ub, acolor = "lightgray", ...) {
  x <- seq(0, 12/rate, 0.01) 
  
  if (missing(lb)) {
    lb <- min(x)
  }
  if (missing(ub)) {
    ub <- max(x)
  }
  
  x2 <- seq(lb, ub, length = 100)    
  plot(x, dexp(x, rate = rate), type = "n", ylab = "")
  
  y <- dexp(x2, rate = rate)
  polygon(c(lb, x2, ub), c(0, y, 0), col = acolor)
  lines(x, dexp(x, rate = rate), type = "l", ...)
}

exp_area(rate = 0.5, lb = 0.5, ub = 5, rgb(0, 0, 1, alpha = 0.5))
text(1, 0.10, "45.12%", srt = 90, col = "white", cex = 1.1)


exp_area(rate = 0.2 ,ub = 3, acolor = rgb(0, 0, 1, alpha = 0.5))
text(1, 0.090, "45.12%", srt = 90, col = "white", cex = 1.1)


exp_area(rate = 0.2, lb = 10, acolor = rgb(0, 0, 1, alpha = 0.5))
arrows(8, 0.1, 11, 0.015, length = 0.1, lwd = 2)
text(8, 0.12, "13.53%", cex = 1.2)

