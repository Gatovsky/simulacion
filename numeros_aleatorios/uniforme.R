library(dplyr, ggplot)
library(purrr)

inv_ej <- function(n = 1000){
  sims_unif <- runif(n)
  sims_x <- case_when(
    sims_unif < 0.2 ~ 1,
    sims_unif < 0.35 ~ 2,
    sims_unif < 0.6 ~ 3,
    TRUE ~ 4
  )
}
sims <- inv_ej()
100 * prop.table(table(sims))


ggplot(tibble(x = c(-2 , 2)), aes(x)) +
  geom_hline(yintercept = 0, color = "gray") +
  geom_vline(xintercept = 0, color = "gray") +
  stat_function(fun = qnorm, aes(color = "fq")) +
  stat_function(fun = dnorm, aes(color = "fdp")) +
  stat_function(fun = pnorm, aes(color = "fda")) +
  coord_fixed()

simulacion_exponencial <- function(){
  u <- runif(1)
  x <- -log(u)
}

simulacion_exp_beta <- function(beta, n = 1000){
  -beta * log(runif(n))
}
simulacion_exponencial2 <- simulacion_exp_beta(2)
mean(simulacion_exponencial2)
ggplot() +
  geom_histogram(aes(x = simulacion_exponencial2, y = ..density..), binwidth = 0.7, fill=I("dodgerblue2"), col=I("black"))



#funcion de densidad binomial: valor puntual
x <- dbinom(x=1:20, size=51, prob=1/16)
hist(x, ylab="P(20)", xlab=" éxitos", col="dodgerblue2",
     border="black", main=("Densidad acumulada"))

#bernoulli
x <- seq(0,1, by=1)
y <- dbern(x, 0.5)
plot(y, type ="o")
plot(dbern(0, 0.5))




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
pbeta(0.9, 4, 2, lower.tail = F) #Probabilidad

curve(pbeta(x, shape1=4, shape2=2), lwd=3, las=1,
      ylab='Densidad', col="blue")
abline(v = qbeta(0.9, 4, 2), col="red")




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

exp_area(rate = 0.2, lb = 10, acolor = rgb(0, 0, 1, alpha = 0.5))
arrows(8, 0.1, 11, 0.015, length = 0.1, lwd = 2)
text(8, 0.12, "13.53%", cex = 1.2)




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

plot(predict(regresion, nuevas.edades), pch=19, col = 6)



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

