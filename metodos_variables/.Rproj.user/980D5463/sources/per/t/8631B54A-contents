library(ggplot2)
library(dplyr)
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


# uniforme discreta #
runifD <- function(n = 1, k) floor(k * runif(n)) + 1
# 1000 simulaciones de una distribución Uniforme
# discreta con parámetro k = 20
x <- runifD(n = 1000, k = 20)
qplot(x, binwidth = 1, fill=I("dodgerblue2"), col=I("black"))


# Poisson usando Inversión #
rpoisI <- function(lambda = 1){
  U <- runif(1)
  i <- 0
  p <- exp(-lambda)
  P <- p
  while(U >= P){
    p <- lambda * p / (i + 1)
    P <- P + p
    i <- i + 1
  }
  i
}

sims_pois <- rerun(1000, rpoisI()) %>% flatten_dbl()

qplot(sims_pois, binwidth = 1, fill=I("dodgerblue2"), col=I("black"))

