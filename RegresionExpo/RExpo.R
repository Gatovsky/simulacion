# y = ax^b
library(ggplot2)

x <- c(1, 2, 3, 4 , 5, 6)
y <- c(10, 40, 120, 300, 800, 500)

datos <- data.frame(x, y)
modelo <- lm(log(y) ~ x, data = datos)
summary(modelo)

plot(x,y, pch=19, col = "dodgerblue", bg="red", main="Diagrama x, y")
grid(10, 10, lwd=2)

plot(x,log(y), pch=22, bg="orange", main = "log(y), X")
abline(reg=modelo, col="blue", lwd=1)
grid(5,5,lwd=2)

plot(x,y, pch=21, bg="turquoise", main="Aproximación exponencial")
lines(x, exp(modelo$fitted.values), col="firebrick", lwd = 2)
grid(10, 10, lwd=1)

plot(predict(modelo), residuals(modelo), pch=22, bg="dodgerblue", main="Gráfica de Residuos")
grid(10,10, lwd=1.5)
lines(predict(modelo), residuals(modelo), type="h", col="orange", lwd=1)
abline(h=0, col="firebrick", lty=3, lwd=2)

