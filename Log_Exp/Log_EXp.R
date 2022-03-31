# Comparación de regresión exponencial y logarítmica
# con la finalidad de ver cual modelo se adapta mejor


x <- c(1, 2, 3, 4 , 5, 6)
y <- c(10, 40, 120, 300, 800, 500)

datos <- data.frame(x, y)

# EXPONENCIAL #

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


# LOGARÍTMICA #

regresionL <- lm(y ~ log(x), data = datos)
summary(regresionL)

plot(x,y,pch=19, col = "orange", main="Diagrama de dispersión X,Y")
grid(10,10,lwd=1)

plot(log(x), y, pch=19, col = "orange", bg="red", main="Diagrama Y, ln(X)", xlab = "ln(x)", ylab = "Y")
abline(reg=regresionL, col="dodgerblue", lwd=2)
grid(10,10,lwd=1)

plot(x,y, pch=19, col = "orange", bg="turquoise", main="Y = B1 + B2lnX")
lines(x, regresionL$fitted.values, col="firebrick", lwd = 2)
grid(10,10,lwd=1)


