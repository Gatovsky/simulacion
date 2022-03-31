ventas_anuales <- read.table("~/simulacion/RegresionLineal/ventaautos.txt", header = TRUE)
names(ventas_anuales)
pairs(ventas_anuales, pch = 19, col = 4)


## coeficientes de correlación (cuantifica el grado de relación lineal )
cor(ventas_anuales, method = c("pearson"))

## mínimos cuadrados y (independiente) ~ x (dependiente) 
regresion <- lm(Ventas ~ Experiencia, data = ventas_anuales)
regresion
summary(regresion)

# con los datos ateriores se determina que
# la ecuación de la recta de mínimos cuafdrados es y = 80 + 4x

#Graficación de la recta

plot(ventas_anuales$Experiencia, ventas_anuales$Ventas, xlab = "Experiencia (años)", ylab = "Ventas anuales ($1000)")
abline(regresion)
## la bondad de ajuste dada por el coeficiente de determinación R² es de  0.93 aprox. 
## lo que resulta favorable

#PREDICCIONES#
# se predicen ventas anuales respecto a los años de experiencia del vendedor
# 15, 16, 18 y 20 años

predicion.ventas_anuales <- data.frame(Experiencia = seq(13, 20))
predict(regresion, predicion.ventas_anuales)

#para un individuo de 14 años de experiencia se predicem $136,000 en ventas anuales

##INFERENCIA##
#Parámetros de confianza AL 98%
confint(regresion, level = 0.98)

## intervalos de confianza para la respuesta media y los intervalos de predicción para la respuesta
predicion.ventas_anuales <- data.frame(Experiencia = seq(0, 14))
predict(regresion, predicion.ventas_anuales)
plot(ventas_anuales$Experiencia, ventas_anuales$Ventas, xlab = "Experiencia (años)", ylab = "Ventas anuales ($1000)")
abline(regresion)

#intervalos de confianza de la respuesta media
# matriz[predicción, intervalo inferior, intervalo superior]
matriz <- predict(regresion, predicion.ventas_anuales, interval = 'confidence')
lines(predicion.ventas_anuales$Experiencia, matriz[, 2], lty = 2) #intervalo inferior
lines(predicion.ventas_anuales$Experiencia, matriz[, 3], lty = 2) #intervalo superior

#intervalos de predicción
matriz <- predict(regresion, predicion.ventas_anuales, interval = 'prediction')
lines(predicion.ventas_anuales$Experiencia, matriz[, 2], lty = 2, col = 'red')
lines(predicion.ventas_anuales$Experiencia, matriz[, 3], lty = 2, col = 'red')

#tabla de análisis de la varianza de los errores 

anova(regresion)

#residuos estandarizados frente a los valores ajustados
residuos <- rstandard(regresion)
ajuste.valor <- fitted(regresion)
plot(ajuste.valor, residuos, pch = 8, cex = 2, lwd = 2, bg = "red", col = 12)
