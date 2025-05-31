# Ejercicio 2.1 ----

arboles <- read.csv2("~/relacion02mlde/arboles.txt", sep="")

## 2.1.1 ----

summary(arboles)
str(arboles) #para ver el tipo de datos que tenemos

var(arboles) #Matriz de Varianzas covarianzas


# A veces se usa una medida de variacion: coeficiente de variacion - nos da 
# info sobre como de lejos estan los datos de la media

(CV_diametro = sd(arboles$diametro)/abs(mean(arboles$diametro)) )

attach(arboles) #para no tener que escribir arboles$diametro, etc


(CV_volumen = sd(volumen)/mean(volumen) ) #Es la que presenta mayor dispersión

(CV_altura = sd(altura)/mean(altura) ) 

#Hemos comparado las tres

# Podemos hacer directamente un diagrama de na caja de bigotes

boxplot(arboles) #suele ser mejor hacerlos uno a uno, si no, pueden verse muy  
                 #aplastados

par(mfrow = c(3,1)) #dividimos en tres la ventana grafica
boxplot(diametro, horizontal = TRUE, main ="diametro")
boxplot(altura, horizontal = TRUE, main ="altura")
boxplot(volumen, horizontal = TRUE, main ="volumen")

par(mfrow = c(1,1)) #para obtener los graficos de nuevo de uno en uno

hist(volumen) #observamos el outlier. ¿Qué observación es?
# se detencta lo de outlier con el diagrama de caja y bigote

bx_vol = boxplot(volumen, horizontal = TRUE, main ="volumen")
bx_vol #vemos en sout el outlier
#outilers:
bx_vol$out

#no es el mejor metodo
which.max (volumen) #en que observacion se alcanaza al maximo
volumen[31]

#mejor del sig modo
i1 = which(max(volumen)==volumen)
volumen [i1]

#correlacion
plot(arboles)

round(cor(arboles),3)
round(cor(arboles),3)^2 # Matriz r cuadrados

heatmap(abs(cor(arboles)), scale = "none" ) #mapa de calor


## 2.1.2 ----

(rVD = lm(volumen ~ diametro, data = arboles)) #se pone el data sino se usa attach

# sale bo=-36.943 y b1=5.066

(s_rVD = summary(rVD)) #para ver la bondad de ajuste podemos ver el valor 
                       #de multiple R_squared

mean(rVD$residuals) 

(rVA = lm(volumen ~ altura, data = arboles))
(s_rVA = summary(rVA))

rVA$coefficients
rVA$residuals #podemos obtener datos de ahi

s_rVA$r.squared

plot(diametro, volumen)
abline(rVD, col = "red")


plot(altura, volumen)
abline(rVA, col = "blue")

# leer conclusiones

## 2.1.3 ----

# r_multiple = lm(volumen ~ diametro + altura, data=arboles)
(r_multiple = lm(volumen ~ .,data=arboles))

(s_r_multiple = summary(r_multiple)) #teoricamente este modelo es mejor pq 
                                     #el R^2 es mayor que los de la lineal
# El contraste fundamental se rechaza: F-statistic:   255 on 2 and 28 DF, 
# p-value: < 2.2e-16. Es decir, concluimos que los betaj no son todos nulos 
# conjuntamente. Destacamos que el contraste  , si bien se rechaza, no 
# se hace con un p-valor muy pequeño. Es decir, la variable altura no 
# aporta gran cosa al modelo (aunque algo aporta).

#leer conclusion apuntes

# Mejor modelo: r_multiple



#para leer hipotesis previas del modelo

#fitted --> valor ajustado

par(mfrow=c(1,1))
#para ver las graficas una a una
plot(r_multiple, which = 1)
plot(r_multiple, which = 2)
plot(r_multiple, which = 3) # habla de la homosteacidad (no funciona bien)
plot(r_multiple, which = 5) # muestra observaciones extrañas

plot(r_multiple, which = 4) #muestra multicolinealidad
plot(r_multiple, which = 6) #parecido al anterior

par(mfrow=c(2,2)) #para que nos pinte 4 graficos (1,2,3,5)
plot(r_multiple)

par(mfrow=c(1,1))


#usamos tambien contrastes de hipotesis

shapiro.test(r_multiple$residuals) #No rechazo normalidad.(por el pvalor)

#otro contaste de normalidad(vinculado a la regresion) usams mejo shapiro
install.packages("nortest")
library(nortest)
ad.test(r_multiple$residuals)


# Vemos ahora Homocedasticidad (vista tb en el grafico tercero)
#install.packages("lmtest")
library(lmtest)

bptest(r_multiple) #No rechazo homocedasticidad

# install.packages("car")
library(car)

ncvTest(r_multiple) #No rechazo(por el pvalor)

# Puedo dar por buena la homocedasticidad del modelo.
# En conclusión: se verifican las hipótesis del modelo r_multiple

# se añade contraste modelo volumen altura

shapiro.test(rVA$residuals) #Se acepta, pero con menor p-valor
bptest(rVA)  #Se rechaza la homocedasticidad
ncvTest(rVA) #También se rechaza

## 2.1.4 ----

confint(r_multiple, level=0.95) #IC para los \beta_j
#nos fijamos que no esta el 0 en el intervalo q tb nos da info

## 2.1.5 ----
mean(arboles$diametro) #13.24839
mean(arboles$altura) #76)

#Predicción a mano:
-57.9877 +4.7082*13.24839 +0.3393*76  

#El volumen predicho sería 30.17517

#Veamos ahora la predicción usando
#la función predict()

nuevodato = data.frame(diametro =13.24839,
                       altura = 76) #para tener una sola fila

predict(r_multiple, newdata = nuevodato)

predict(r_multiple, nuevodato, interval = "confidence" ) #IC para la respuesta media

predict(r_multiple, nuevodato, interval = "prediction", level = 0.95 ) #interval de predicion
#no va a ser para un arbol medio, va a ser un arbol mas abierto

## 2.1.6 ----
anova(rVD)
anova(rVD, r_multiple) #nos aseguramos que el modelo rmultiple es mejor
# nos fijamos en el 0.01449 - se ve que no aporta nada nuevo al modelo que tenemos
# saled de (1 -pf())
anova(rVA, r_multiple) #tiene que ser anidado

# anova(secuencial)
anova(r_multiple)

# Mirar los apuntes con la explicacion

## 2.1.7
volCalculado = pi * altura * (diametro/2)^2
rVol = lm(volumen ~ volCalculado)
summary(rVol)
