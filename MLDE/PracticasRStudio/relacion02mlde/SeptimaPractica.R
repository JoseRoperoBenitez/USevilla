# Mira en primer lugar tabla de ejercicio 2.1 y anova de ese mismo

# Ejercicio 3 Relacion 2

coches <- read.csv("~/relacion02mlde/Car_sales.txt", sep="")

str(coches) #vamos los chr 
# vemos que hay 157obs

summary(coches)
#Vemos que hay bastante datos NA's

coches = na.omit(coches) # quitamos los valores de NA's
dim(coches) # vemos que se ha reducido el numero de obs

# vamos a convertir las variables cualitativas en variables de tipo factor.
coches$fabricante<- factor(coches$fabricante)
coches$modelo <- factor(coches$modelo)
coches$tipo<-factor(coches$tipo)
summary(coches)


#queremos estudiar la variable reventa. No vamos a usar las variables fabricante
# ni modelo.
summary(coches$fabricante)
summary(coches$modelo)
coches = coches[, -c(1,2)] #quitamos esas dos cols

attach(coches)


## Analisis Descriptivo ----

# primero analizamos graficamente
hist(reventa)
boxplot(reventa) #observamos muchos outliners

#cuales son esos outliners?
boxplot.stats(reventa)$out

ind = which(reventa %in% c(boxplot.stats(reventa)$out))
coches[ind,] #para detectar sus respectivas filas dejando vacia las columnas
            

#parecen ser coches caros --> esperamos correlacion alta entre reventa y precio

# quitamos la variable cualitativa "tipo", en la tercera columna
round(cor(coches[,-3]), 2) #tenemos 0.95 en lo q buscamos

heatmap(abs(cor(coches[,-3])), scale = "none")
# las mas correladas con reventa son precio y caballos

#vemos que hay alta colinealidad entre algunas variables

#sin variable explicada (1) y sin explicativas cualitativas (3)
det(cor(coches[-c(2,3)])) #la primera es quitamos la columna reventa
# ==> los datos presentan alta multicolinealidad


## Estudio variable tipo ----
# vamos a estudiar su correlacion con reventa

boxplot(reventa ~ tipo, col = "lightblue", horizontal =TRUE)
contrasts(tipo) #nos informa a qn le da el 0 y a qn el 1

rt = lm(reventa ~ tipo, data = coches)
summary(rt) #la variable q lleva el valor 0 es la de referencia
# nos dice que valor de reventa esperado de camion es 18.640 y coche 
# 18.640 - 2.454, modelo no parece aportar mucho

## Eleccion y analisis del modelo ----

#hacemos regresion lineal de reventa con todas
rtodas=lm(reventa~.,data=coches)
summary(rtodas)

# hay variables no explicativas, usamos metodos paso a paso

rback=step(rtodas,direction="backward")
# El modelo propuesto en este caso contiene 6 variables 
# en STEP si le cambio el valor predeterminado de k = 2 puedo obtener el BIC
# en vez del AIC --> k = log(nrow(-))
rback
summary(rback)

# Hacia delante
nulo=lm(reventa~1, data = coches)
rfor=step(nulo,direction="forward",
          scope=list(lower=nulo,upper=rtodas), trace = FALSE)
rfor
summary(rfor)

# Ambas direcciones
rboth=step(rtodas, direction="both",trace=FALSE)
rboth

summary(rboth)

#podemos ver si estan anidados rback y rfor
anova(rfor,rback) # ya que uno esta dentro de otro
# vemos q no rechazamos la igualdad a 0 de las otras 2 otras variables extra,
# por lo tanto podemos afirmar que rfor es mejor


## Mejor modelo con k variables ----

#install.packages("leaps")
library(leaps)

mejores=regsubsets(reventa~.,data=coches, nvmax = 4)
summary(mejores) #Mejor subconjunto de variables predictoras

summary(mejores)$outmat #coincide el mejor modelo con rfor

#tb obtenemos fijandonos el mejor modelo con 3 variables
mejor3=lm(reventa~precio+peso_revestimiento+tapón_combustible)
summary(mejor3)

anova(mejor3,rfor)
# por el p-valor si rechazamos que la variable sea 0 por lo tanto esa cuarta 
# variable si es necesaria. A pesar de que la diferencia de R^2 es muy poca.

## Hipotesis del modelo ----

par(mfrow=c(2,2))
plot(rfor)

shapiro.test(rfor$residuals)#Normalidad
# aceptamos normalidad

#install.packages("car")
library(car)
ncvTest(rfor)#Test de homocedasticidad, test Score

library(lmtest)
bptest(rfor)#Test de homocedasticidad de Breusch-Pagan
# en ambos rechazamos la homocedasticidad. Buscamos el problema

par(mfrow=c(1,1))
plot(reventa ~ precio) #las de mayor correlacion

plot(log(reventa) ~ log(precio)) #ajustamos un poco las graficas

# hacemos regresion con este cambio
r_log = lm(log(reventa) ~ log(precio) + longitud + peso_revestimiento + tapón_combustible, data = coches)
summary(r_log)

# hay que teneer en cuenta los asteriscos

plot(r_log)

shapiro.test(r_log$residuals) #aceptamos normalidad
library(car)
ncvTest(r_log) 
library(lmtest)
bptest(r_log) # en estos dos si que se ha aceptado la homocedasticidad ==> 
# tenemos las hipotesis deseadas


## Estudio de la multicolinalidad de las variables ----

# se puede haver con la funcion vif()
library(car)
vif(r_log)

# Un VIF inferior a 5 indica una baja correlación de ese predictor con otros 
# predictores. Un valor entre 5 y 10 indica una correlación moderada, 
# mientras que los valores de VIF mayores que 10 son un signo de una 
# correlación alta y no tolerable de los predictores del modelo

# lo hacemos con la regresion multiple 
vif(rtodas) # "caballos" presenta una correlación alta al superar el valor 10

# con rback
vif(rback) # solamente "peso_revestimiento" presenta correlación moderada


## Prediciones con var transformadas ----

lreventa = log(reventa)
lprecio = log(precio)
r_log2 = lm( lreventa ~ lprecio + longitud + peso_revestimiento + tapón_combustible)

newdata_01 = data.frame(
  lprecio = c(mean(log(precio)), 
              median(log(precio)) ),
  longitud = c(mean(longitud), 
               median(longitud) ),
  peso_revestimiento = c(mean(peso_revestimiento),
                         median(peso_revestimiento) ),
  tapón_combustible = c(mean(tapón_combustible),
                        median(tapón_combustible) )
)

predict(r_log2, newdata = newdata_01, interval = "confidence")

# Y en IP para la variable
predict(r_log2, newdata = newdata_01, interval = "prediction")

# Interpretacion de los betaj
(vbeta = coef(r_log))

# 1% de incremento en el precio
precio0 = 100
precio1 = 101
pred_0 = vbeta[1] + vbeta[2]*log(precio0)
pred_1 = vbeta[1] + vbeta[2]*log(precio1)
epred_0 = exp(pred_0)
epred_1 = exp(pred_1)
# produce un aumento 1.13% aprox. en reventa
(epred_1/epred_0)*100-100

# variación de una unidad en peso_revestimiento
pesorev0 = 0
pesorev1 = 1
pred_0 = vbeta[1] + vbeta[4]*pesorev0
pred_1 = vbeta[1] + vbeta[4]*pesorev1
epred_0 = exp(pred_0)
epred_1 = exp(pred_1)
# produce una disminución del 16.04% aprox. en reventa
(epred_1/epred_0)*100-100

# y los coef sin transformaciones: 
coef(rfor)
