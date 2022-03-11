library(ggplot2)

ggplot(tibble(x = c(-2 , 2)), aes(x)) + 
  geom_hline(yintercept = 0, color = "gray") +
  geom_vline(xintercept = 0, color = "gray") +
  stat_function(fun = qnorm, aes(color = "fq")) +
  stat_function(fun = dnorm, aes(color = "fdp")) +
  stat_function(fun = pnorm, aes(color = "fda")) +
  coord_fixed()
  #labs(color = "", title = "Método de transformación inversa caso Normal")


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


