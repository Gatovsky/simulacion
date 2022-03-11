#cargamos el fichero
grasas <- read.table("~/Simulacion/EdadPesosGrasas.txt", header = TRUE)
names(grasas)

#se genera el diagrama de dispersión
pairs(grasas, pch = 19, col = 4)

#Grado de relación lineal
cor(grasas)

# especificamos la variable dependiente grasas y la variable dependiente edad y ~ x
regresion <- lm(grasas ~ edad, data = grasas)
summary(regresion)

#Gráfico de dispersión con recta de regresión lineal
plot(grasas$edad, grasas$grasas, xlab='Edad', ylab='Grasas', pch=19, col = 3)
abline(regresion, col=2, lwd=3)

#etiqueta con los valores de la regresión lineal
coef <- round(coef(lm(grasas ~ edad, data = grasas)), 2)
text(28, 400, paste("Y = ", coef[1], "+", coef[2], "x"))

#predicción de grasa en la sangre para individuos de 30 a 50 años
nuevas.edades <- data.frame(edad = seq(30, 50))
predict(regresion, nuevas.edades)

plot(predict(regresion, nuevas.edades), pch=19, col =6)


confint(regresion)
confint(regresion, level = 0.90)


nuevas.edades <- data.frame(edad = seq(20, 60))
# Grafico de dispersión y recta
plot(grasas$edad, grasas$grasas, xlab='Edad', ylab='Grasas', pch = 19, col=4)
abline(regresion, col = 2, lwd = 3)

# Intervalos de confianza de la respuesta media:
# ic es una matriz con tres columnas: la primera es la predicción, las otras dos son los extremos del intervalo
ic <- predict(regresion, nuevas.edades, interval = 'confidence')
lines(nuevas.edades$edad, ic[, 2], lty = 2)
lines(nuevas.edades$edad, ic[, 3], lty = 2)

# Intervalos de predicción
ic <- predict(regresion, nuevas.edades, interval = 'prediction')
lines(nuevas.edades$edad, ic[, 2], lty = 2, pch= 2,  col = 'red')
lines(nuevas.edades$edad, ic[, 3], lty = 2, pch= 2, col = 'red')
