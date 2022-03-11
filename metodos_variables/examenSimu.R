#cargamos el fichero
años <- read.table("/home/elpsycongroo/Simulacion/exmanexy.txt", header = TRUE)
names(años)

#se genera el diagrama de dispersión
pairs(años, pch = 19, col = 4)

#Grado de relación lineal
cor(años)

# especificamos la variable dependiente grasas y la variable dependiente edad y ~ x
regresion <- lm(años ~ ventas, data = años)
summary(regresion)

#Gráfico de dispersión con recta de regresión lineal
plot(años$ventas, años$ventas, xlab='ventas', ylab='años', pch=19, col = 3)
abline(regresion, col=2, lwd=3)

#etiqueta con los valores de la regresión lineal
coef <- round(coef(lm(años ~ ventas, data = años)), 2)
text(28, 400, paste("Y = ", coef[1], "+", coef[2], "x"))

#predicción de grasa en la sangre para individuos de 30 a 50 años
nuevas.ventas <- data.frame(ventas = seq(20, 30))
predict(regresion, nuevas.ventas)

plot(predict(regresion, nuevas.ventas), pch=19, col =6)


confint(regresion)
confint(regresion, level = 0.90)


nuevas.ventas <- data.frame(ventas = seq(20, 30))
# Grafico de dispersión y recta
plot(años$ventas, años$años, xlab='ventas', ylab='años', pch = 19, col=4)
abline(regresion, col = 2, lwd = 3)

# Intervalos de confianza de la respuesta media:
# ic es una matriz con tres columnas: la primera es la predicción, las otras dos son los extremos del intervalo
ic <- predict(regresion, nuevas.ventas, interval = 'confidence')
lines(nuevas.ventas$ventas, ic[, 2], lty = 2)
lines(nuevas.ventas$ventas, ic[, 3], lty = 2)

# Intervalos de predicción
ic <- predict(regresion, nuevas.ventas, interval = 'prediction')
lines(nuevas.ventas$ventas, ic[, 2], lty = 2, pch= 2,  col = 'red')
lines(nuevas.ventas$ventas, ic[, 3], lty = 2, pch= 2, col = 'red')
