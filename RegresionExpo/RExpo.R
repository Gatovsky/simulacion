# y = ax^b
library(ggplot2)

datosxy <- read.table("~/simulacion/Log_Exp/discotecas.txt", header = TRUE)
datosxy

# x <- c(1, 2, 3, 4 , 5, 6)
# y <- c(10, 40, 120, 300, 800, 500)

# datos <- data.frame(x, y)
# modelo <- lm(log(y) ~ x, data = datos)
?

# EXPONENCIAL #
modeloE <- lm(log(DECIBELES) ~ POTENCIA, data = datosxy)
summary(modeloE)

plot(datosxy$POTENCIA, datosxy$DECIBELES, pch=19, col = "dodgerblue", bg="red", main="Diagrama x, y")
grid(10, 10, lwd=2)

plot(datosxy$POTENCIA,log(datosxy$DECIBELES), pch=22, bg="orange", main = "log(y), X")
abline(reg=modeloE, col="blue", lwd=1)
grid(5,5,lwd=2)

plot(datosxy$POTENCIA, datosxy$DECIBELES, pch=21, bg="turquoise", main="Aproximación exponencial")
lines(datosxy$POTENCIA, exp(modeloE$fitted.values), col="firebrick", lwd = 2)
grid(10, 10, lwd=1)

plot(predict(modeloE), residuals(modeloE), pch=22, bg="dodgerblue", main="Gráfica de Residuos")
grid(10,10, lwd=1.5)
lines(predict(modeloE), residuals(modeloE), type="h", col="orange", lwd=1)
abline(h=0, col="firebrick", lty=3, lwd=2)

---------------------------------------------------------------------------------
  
# LOGARÍTMICA #
modeloL <- lm(DECIBELES ~ log(POTENCIA), data = datosxy)
summary(modeloL)

plot(datosxy$POTENCIA, datosxy$DECIBELES ,pch=19, col = "orange", main="Diagrama de dispersión X,Y")
grid(10,10,lwd=1)

plot(log(datosxy$POTENCIA), datosxy$DECIBELES, pch=19, col = "orange", bg="red", main="Diagrama Y, ln(X)", xlab = "ln(x)", ylab = "Y")
abline(reg=modeloL, col="dodgerblue", lwd=2)
grid(10,10,lwd=1)

plot(datosxy$POTENCIA, datosxy$DECIBELES, pch=19, col = "orange", bg="turquoise", main="Y = B1 + B2lnX")
lines(datosxy$POTENCIA, modeloL$fitted.values, col="firebrick", lwd = 2)
grid(10,10,lwd=1)

predict(modeloL)

----------------------------------------------------------------------------------------------------------------

# COMPARACIÓN #
  

plot(datosxy$POTENCIA, datosxy$DECIBELES, pch=19, col = "green", bg="turquoise") + title(main="COMPARACIÓN DE MODELOS", family = "Consolas")
lines(datosxy$POTENCIA, modeloL$fitted.values, col="dodgerblue", lwd = 2, lty=2)
lines(datosxy$POTENCIA, exp(modeloE$fitted.values), col="orange", lwd = 2, lty=2)
grid(10,10,lwd=1)
