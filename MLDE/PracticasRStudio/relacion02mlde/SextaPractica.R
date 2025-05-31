# Ejercicio 2 relacion2

marcas_cigarros <- read.csv("~/relacion02mlde/ciga.txt", sep="")
str(marcas_cigarros)

#como hay una primera fila de char la vamos a quitar para facilitar todo luego

ciga = marcas_cigarros[,-1]
attach(ciga)

## 2.2.1 ----

summary(ciga)

par(mfrow = c(2,2)) #Gráficos 2x2
hist(monoxcar)
hist(alquitra)
hist(nicotina)
hist(peso)

# parece haber observaciones dispares de las anteriores,
# vemos graficas de caja y bigote

par(mfrow = c(2,2)) #Gráficos 2x2
boxplot(monoxcar, horizontal = T, xlab = "monoxcar")
boxplot(alquitra, horizontal = T, xlab = "alquitra")
boxplot(nicotina, horizontal = T, xlab = "nicotina")
boxplot(peso, horizontal = T, xlab = "peso")

# Vemos que hay observaciones raras, outlines. Queremos detectarlos

which.min(monoxcar) #nos devuelve el indice en que se alnaza el min
# el individuo 16 de los 28 es el raro

which.min(nicotina)
which.min(peso)

which.max(alquitra)
which.max(nicotina)
which.max(peso)

# tiene pinta de que tanto las observaciones 3 como la 16 son las observaciones
# raras

# si queremos las covarianzas de todos las variables
var(ciga) #son todas positivas --> relacion tio directo

# podemos verlo:
pairs(ciga)

cor(ciga) #coefs correlacion lineal
# si es alto nos indica que va a ser una colinealidad

heatmap(abs(cor(ciga)), scale="none") 

# sin embargo para el problema de la multicolinealidad, como piuede ser de mas
# variables vamos a ver el determinante:

det(cor(ciga[,-4])) #quitamos la variable respuesta
# sale resultado cercano a 0 como tiene q salir
det(cor(ciga))

## 2.2.2 ----

rn=lm(monoxcar~nicotina)
plot(monoxcar~nicotina) 

plot(nicotina, monoxcar) #OJO al orden de los argumentos, son el mismo gráfico
abline(rn, col = "red")

summary(rn)
# b1 es el 12.3954
# no se rechaza que b0=0 por el pvalor

confint(rn) #vemos que el 0 esta

#Por lo demás, el modelo es aceptable, y el resto de contrastes sí se rechazan.
#Si quisiéramos ver el modelo sin término independiente: 

lm(monoxcar ~ nicotina - 1) #-1 pq le decimos que no queremos la cte

par(mfrow = c(1,1))

## 2.2.3 ----

ra=lm(monoxcar~alquitra)
plot(alquitra,monoxcar)
abline(ra,col="blue")

summary(ra) #vemos que es el mejor q el anterior

#vemos comparacion grafica

par(mfrow = c(1,2))
plot(nicotina, monoxcar)
abline(rn, col = "red")
plot(alquitra,monoxcar)
abline(ra,col="blue")

par(mfrow = c(1,1))

## 2.2.4 ----
# Estuidio completo de todas las var explicativas

rmult = lm(monoxcar ~ ., data = ciga)
summary(rmult)

# se observa que no tiene sentido que al aumentar en una unidad el 
# porcentaje de nicotina, descienda en -2.6317 --> esto es POR EL PROBLEMA
# DE MULTICOLINEALIDAD, lo visto antes con los coef de correlacion

confint(rmult)

# nos podriamos quedar por esto salmente con el alquitran en vez de la nicotina
# ya que el r^2 era mejor

## METODO PASO A PASO HACIA ATRAS 

#step(rmult,direction = "backward",trace=1)
step(rmult,direction = "backward")# Nos queda el modelo con solo el alquitrán

#nos fijariamos en el AIC 

#Si preferimos sólo ver el modelo final escribimos "trace=FALSE"
step(rmult,direction = "backward",trace=FALSE)
#vemos que se queda con el AIC

## METODO PASO A PASO HACIA ALANTE

nulo=lm(monoxcar~1) #HAY QUE FIJAR DONDE EMPEZAMS
summary(nulo)
# Nos queda el modelo con solo el alquitrán
step(nulo,direction = "forward",
     scope=list(lower=nulo, upper=rmult),trace=1)

# el forward busca el menor AID
# el backwar busca el mayor AID

# lo podemos hacer en ambos sentidos

# Nos queda el modelo con solo el alquitrán
step(rmult,direction = "both",trace=1)

# nos queda entonces el modelo con el alquitran

summary(ra)

par(mfrow = c(2,2))
#Se realizan los cuatro gráficos que ayudan a la comprobación de las hipótesis
plot(ra)
#nos da los 4 graficos para interpretar los datos
# recordamos que hay un grafo que nos informa de la multicolinealidad

#Normalidad
residuos=ra$residuals
shapiro.test(residuos)#Existe normalidad en los residuos - aceptamos la norm

#Homocedasticidad
library(car)

#No se puede aceptar la homocedasticidad, se rechaza la hipótesis nula de 
#homocedasticidad p = 0.048393
ncvTest(ra) 

#podemos quitar las observaciones raras para que mejore

ciga_2=ciga[-3,] #quitamos la tercera observación QUE ERA OUTLINER
ra_2<-lm(monoxcar~alquitra,data=ciga_2)
summary(ra_2)

#Comprobamos las hipótesis
par(mfrow = c(2,2))
plot(ra_2)
#vemos q mejora la homocedasticidad

residuos_2=ra_2$residuals
shapiro.test(residuos_2)#Se da la normalidad

ncvTest(ra_2) #se cumple la homocedasticidad

medioal=mean(ciga_2$alquitra)
predict(ra_2,newdata=data.frame(alquitra=medioal))#predicción puntual

#Intervalo de confianza para la predicción de la nueva observación
predict(ra_2,newdata=data.frame(alquitra=medioal),interval="prediction")

#Intervalo de confianza para el valor medio o esperado de la nueva observación
predict(ra_2,newdata=data.frame(alquitra=medioal),interval="confidence")
