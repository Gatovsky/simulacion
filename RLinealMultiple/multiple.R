"Un estudio quiere generar un modelo que permita predecir la esperanza de vida 
media de los habitantes de una ciudad en función de diferentes variables. 
Se dispone de información sobre: habitantes, analfabetismo, ingresos, esperanza 
de vida, asesinatos, universitarios, heladas, área y densidad poblacional."

## se trabajará con el data set state.x77

library(dplyr)
library(psych)
library(ggplot2)
library(gridExtra)
library(GGally)
library(lmtest)
library(corrplot)
library(car)

datos <- as.data.frame(state.x77)
datos <- rename(habitantes = Population, analfabetismo = Illiteracy,
                ingresos = Income, esp_vida = 'Life Exp', asesinatos = Murder,
                universitarios = 'HS Grad', heladas = Frost, area = Area,
                .data = datos)
datos <- mutate(.data = datos, den_pobl = habitantes * 1000 / area)

round(cor(x = datos, method = "pearson"), 3)


# histogramas
multi.hist(x = datos, dcol = c("blue", "red"), dlty = c("dotted", "solid"),
           main = "")

ggpairs(datos, lower = list(continuous = "smooth"),
        diag = list(continuous = "barDiag"), axisLabels = "none") + scale_fill_manual(values = my_colors)

modelo <- lm(esp_vida ~ habitantes + ingresos + analfabetismo +
               asesinatos + universitarios + heladas + area +
               den_pobl, data = datos)
summary(modelo)


# selección de los mejores predictores usando la estrategia de stepwise mixto
step(object = modelo, direction = "both", trace = 1)

modelo <- (lm(formula = esp_vida ~ habitantes + asesinatos + universitarios +
                heladas, data = datos))
summary(modelo)

#intervalos de confianza
confint(lm(formula = esp_vida ~ habitantes + asesinatos + universitarios +
             heladas, data = datos))

# Relación lineal entre  predictores núméricos y la variable respuesta
plot1 <- ggplot(data = datos, aes(habitantes, modelo$residuals)) +
  geom_point(color = "orange") + geom_smooth(color = "firebrick", fill = "dodgerblue") + geom_hline(yintercept = 0) +
  theme_bw()
plot2 <- ggplot(data = datos, aes(asesinatos, modelo$residuals)) +
  geom_point(color = "orange") + geom_smooth(color = "firebrick", fill = "dodgerblue") + geom_hline(yintercept = 0) +
  theme_bw()
plot3 <- ggplot(data = datos, aes(universitarios, modelo$residuals)) +
  geom_point(color = "orange") + geom_smooth(color = "firebrick", fill = "dodgerblue") + geom_hline(yintercept = 0) +
  theme_bw()
plot4 <- ggplot(data = datos, aes(heladas, modelo$residuals)) +
  geom_point(color = "orange") + geom_smooth(color = "firebrick", fill = "dodgerblue") + geom_hline(yintercept = 0) +
  theme_bw()
grid.arrange(plot1, plot2, plot3, plot4)

# graficación normal de los residuos
mis_colores <- rainbow()
qqnorm(modelo$residuals, pch =19, col = "dodgerblue", main = "Distribución Normal")
qqline(modelo$residuals, col = "red", lwd = 2)

# Test de hipótesis
shapiro.test(modelo$residuals)

# gráfica de residuos frente a los valores ajustados por el modelo
ggplot(data = datos, aes(modelo$fitted.values, modelo$residuals)) +
  geom_point(pch = 19, color = "dodgerblue") +
  geom_smooth(color = "firebrick", se = FALSE) +
  geom_hline(yintercept = 0, col = "orange") +
  theme_bw()

#comprobación del test
bptest(modelo)

# matriz de correlación entre predictores
corrplot(cor(dplyr::select(datos, habitantes, asesinatos, universitarios, heladas)),
         method = "number", tl.col = "blue")

# análisis inflación de varianza VIF
vif(modelo)
# autocorrelación
dwt(modelo, alternative = "two.sided")

#valores atípicos
datos$studentized_residual <- rstudent(modelo)
ggplot(data = datos, aes(x = predict(modelo), y = abs(studentized_residual))) +
  geom_hline(yintercept = 3, color = "firebrick", linetype = "dashed") +
  # se identifican en rojo observaciones con residuos estandarizados absolutos > 3
  geom_point(aes(color = ifelse(abs(studentized_residual) > 3, 'orange', 'dodgerblue'))) +
  scale_color_identity() +
  labs(title = "Distribución de residuos",
       y = "residuos studentized",
       x = "predicción modelo") + 
  theme_bw() + theme(plot.title = element_text(hjust = 0.5))

# verificación de valores atípicos
which(abs(datos$studentized_residual) > 3)

# tabla general de observaciones de influencia (las ultimas 3 columnas sirven para cauntificar la influencia)
summary(influence.measures(modelo))
#gráfica de las influiencias
influencePlot(modelo)



