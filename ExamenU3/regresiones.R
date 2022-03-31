library(ggplot2)

#x <- c(0, 0.05, 0.1, 0.15, 0.2, 0.25, 0.3, 0.35, 0.4, 0.45, 0.5)
#y <- c(1, 0.823, 0.508, 0.238, 0.066, -0.016, -0.042, -0.038, -0.025, -0.013, -0.004)
#velocidad <- data.frame(x, y)

velocidad <- read.table("examenU3.txt", header = TRUE)
names(velocidad)
pairs(velocidad, pch = 19, col = 4)



## LINEAL ##


regresion <- lm(velocidad$y ~ velocidad$t, data = velocidad)
regresion
summary(regresion)

plot(velocidad$t, velocidad$y, pch = 19, col = "orange", bg = "red")
abline(regresion, col = "dodgerblue", lwd = 2)
grid(10, 10, lwd = 1)



## LOGARÍTMICA ##


regresionL <- lm(velocidad$y ~ log(velocidad$t), data = velocidad)
summary(regresionL)

plot(velocidad$t, velocidad$y, pch = 19, col = "orange", main = "Diagrama de despersión t(segundos), y(metros)")
grid(10, 10, lwd = 1)

plot(log(velocidad$t), velocidad$y, pch = 19, col = "orange", bg = "red", main = "Diagrama log(t(segundos)), y(metros)")
abline(reg = regresionL, col = "dodgerblue", lwd = 2)
grid(10, 10, lwd = 1)

plot(velocidad$t, velocidad$y, pch = 19, col = "orange", bg = "turquoise", main = "Y = B1 + B2lnX")
lines(velocidad$t, regresionL$fitted.values, col = "firebrick", lwd = 2)
grid(10, 10, lwd = 1)

plot(predict(regresionL), residuals(regresionL), pch = 22, bg = "dodgerblue", main = "Gráfica de residuos")
grid(10, 10, lwd = 1)
lines(predict(regresionL), residuals(regresionL), type = "h", col ="orange", lwd = 1)
abline(h = 0, col = "firebrick", lty = 3, lwd = 2)




## EXPONENCIAL ##
regresionE <- lm(log(velocidad$y) ~ velocidad$t, data= velocidad)
summary(regresionE)

plot(velocidad$t, velocidad$y, pch = 19, col = "dodgerblue", bg = "red", main = "Diagrama t(segundos), y(mettros)")
grid(10, 10, lwd = 2)

plot(velocidad$t, log(velocidad$y), pch = 22, bg = "orange", main = "log(y(metros)), t(segundos)")
abline(reg = regresionE, col = "blue", lwd = 1)
grid(5, 5, lwd = 2)

plot(velocidad$t, velocidad$y, pch = 21, bg = "turquoise", main = "Aproximación exponencial")
lines(velocidad$t, log(regresionE$effects), col = "firebrick", lwd = 2)
grid(10, 10, lwd = 1)

plot(predict(regresionE), residuals(regresionE), pch = 22, bg = "dodgerblue", main = "Gráfica de residuos")
grid(10, 10, lwd = 1)
lines(predict(regresionE), residuals(regresionE), type = "h", col ="orange", lwd = 1)
abline(h = 0, col = "firebrick", lty = 3, lwd = 2)



## CUADRÁTICA ##

regresionC <- lm(velocidad$y ~ velocidad$t + I(velocidad$t^2), data = velocidad)
summary(regresionC)

plot(velocidad$y ~ velocidad$t + I(velocidad$t^2), pch = 22, bg = "orange", main = "Cuadrática")
abline(reg = regresionC, col = "blue", lwd = 1)
grid(5, 5, lwd = 2)

plot(velocidad$t, velocidad$y, pch = 21, bg = "turquoise", main = "Aproximación cuadrática")
lines(velocidad$t, regresionC$fitted.values, col = "firebrick", lwd = 2)
grid(10, 10, lwd = 1)

plot(predict(regresionC), residuals(regresionC), pch = 22, bg = "dodgerblue", main = "Gráfica de residuos")
grid(10, 10, lwd = 1)
lines(predict(regresionC), residuals(regresionC), type = "h", col ="orange", lwd = 1)
abline(h = 0, col = "firebrick", lty = 3, lwd = 2)




#### COMPARACIÓN ###


plot(velocidad$t, velocidad$y, pch = 19, col = "orange", bg = "turquoise") +
  title("COMPARACIÓN DE MODELOS")
lines(velocidad$t, regresion$fitted.values, col = "red", lwd = 2, lty =2)
lines(velocidad$t, regresionL$fitted.values, col = "dodgerblue", lwd = 2, lty = 2)
#lines(velocidad$t, col = "orange", lwd = 2, lty = 2)
lines(velocidad, col = "orange", lwd = 2, lty = 2)
lines(velocidad$t, regresionC$fitted.values, col = "green", lwd = 2, lty = 2)
grid(10, 10, lwd = 1)

