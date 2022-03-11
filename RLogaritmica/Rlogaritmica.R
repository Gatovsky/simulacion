# Datos

x<-c(0.5, 1, 2, 4, 6, 8, 10, 12)
y<-c(4, 6, 10, 15, 17, 18.5, 19, 19.5)
datos<-data.frame(x,y)

datos

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