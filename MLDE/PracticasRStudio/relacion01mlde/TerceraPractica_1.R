
#prost <- read.csv("datos/prostate.txt", sep="")
prost <- read.csv("~/relacion01mlde/datos/prostate.txt", sep="")
# 3.1 ----

class(prost) #Para ver el tipo del fichero
str(prost) #Nos da algo mas de info de todos los datos y el tipo de estos

prost$svi = as.factor(prost$svi) #analogo al factor

summary(prost)  #no esta bien hacer el summary directamente pq hay que tner en
                #cuenta los tipos


#Para acceder a unos datos concretos

#prost$lcavol #accedo a la variable lcavol

prost$lcavol[6]
prost$lcavol[c(3,5)] #accedo a las coordenadas 3 y 5 
prost$lcavol[1:20] #devuelve del 1 al 20
pr1 = prost$lcavol[c(30:57,1,7,10:15)] #guardamos datos
pr1 

prost[,1] #prost$lcavol porque es la primera columna

#prost[1] #igual

prost[2,] #segunda fila de los datos: son los datos del segundo hombre

prost[97, c(1,9)] #de la observación 97, las variables 1 y 9

#lcavol #da error

# 3.1a ----

attach(prost) #Consejo: hacerlo después de modificar los datos
lcavol #ya no da error
head (lcavol)
#Seria otra forma de seleccionar datos


# 3.1b ----

#Para hacer tabla de frecuencias
table(age)

min(age)
min(prost$age) #sin el atach
median(age)   #mediana
quantile(age,c(0.25,0.5,0.75))  #cuantiles

var(age) #cuasivarianza
sd(age) #desviacion tipica

max(age)

seq(40,80,5) #es igualque c(40,45,50,55,60,65,70,75,80) Parecido a 1:20

#Podemos crear intervalos con respecto a los datos
(intervalos = cut(age, breaks = seq(40,80,10)))
age #Comprobamos que esta bien7

#Podemos comprobar el tipo de intervalos con str(intervalos)

(FrecAbs = table(intervalos)) #frecuencia absoluta

(FrecRel = prop.table(FrecAbs)) #frecuencia relativa

(AbsAcum = cumsum(FrecAbs)) #frecuencia acumulada pero se pierde info
(RelAcum = cumsum(FrecRel)) 
(PorcAcum = RelAcum*100) #si mult por 100 vemos los porcentajes

(tabla = cbind(FrecAbs, FrecRel, AbsAcum, RelAcum))

#Para hacer histograma:

hist(age, breaks = seq(40,80,10))#representa la frecuencia absoluta

hist(prost$age, breaks = 4) 

hist(age, breaks = c(40,50,70,80))#representa la densidad de frec. relativa
                                  # pq los intervalos no tienen misma longitud

#Grafico de caja y bigotes
boxplot(prost$age)
boxplot(prost$age,horizontal = T)

#install.packages("fBasics")
library(fBasics) #Cargo la libreria

skewness(age) #Coeficiente de asimetría
kurtosis(age) #Coeficiente de curtosis   #Hay q saber interpretar los result.
                                        # si es 0 es igual q la campana de gauss

plot(lcavol,lpsa) #vemos una nube de puntos

plot(prost[-c(5,6)])
# si usamos el prost[-c(5,6)] esta QUITANDO las columnas 5 y 6. se refiere al resto


# 3.2 ----
# ESTUDIO DE CORRELACIONES

cor(lcavol, lpsa)

cor(  prost[-5]  ) #vemos todos quitando el svi que es un factor.
round( cor(  prost[-5]  ) ,3  ) #round (-,3) nos devuele 3 decimales
#podemos estudiar la relacion entre variables con esa tabla q nos da

heatmap(abs(cor(prost[-5])), scale = "none")
#da colores mas oscuros cuanta mayor sea la correlacion

# 3.3 ----
qqnorm(lpsa)
qqline(lpsa, col = "red")
#es señal de normalidad que los datos esten sobre una recta

shapiro.test(lpsa)

#qqnorm(svi) #No puedo hacerlo para factores
#shapiro.test(svi) #Mismo problema

qqnorm(pgg45)
qqline(pgg45,col = "red")
shapiro.test(pgg45)


## CUARTA PRACTICA (continuacion del ejercicio 3)

# 3.7 ----

shapiro.test(lpsa)

t.test(lpsa, mu = 4, alternative = "less") #nos fijamps p-valor

# 3.8 ----
#selecciona los valores de lpsa en individuos jóvenes
lpsajoven = prost[prost$age <= 65,"lpsa"] 
#selecciona los valores de lpsa en individuos mayores
lpsamayor = prost[prost$age > 65,"lpsa"]  

summary(lpsajoven)  # nos devuelve un resumen del vector
summary(lpsamayor)

boxplot(lpsajoven, lpsamayor) 

#summary(lm(lpsa~edad))

shapiro.test(lpsajoven) #se acepta normalidad
shapiro.test(lpsamayor) #se acepta normalidad

# Tenemos dos muestras que asumimos normales e independientes

var.test(lpsajoven, lpsamayor) #asumimos igualdad de varianzas
t.test(lpsajoven, lpsamayor, var.equal = TRUE, alternative = "less")
# Rechazo la hipótesis nula de que las medias sean iguales en ambos grupos de 
# personas. Es más, concluimos que los jóvenes tienen, en media, menos lpsa que
# las personas mayores.

# 3.9 ----

# Los >= 4 aparecen como TRUE
cancerjoven = lpsajoven>=4
cancermayor = lpsamayor>=4

tablajoven = table(cancerjoven)
tablamayor = table(cancermayor)

tablacancer = rbind(tablajoven, tablamayor)
tablacancer

# Como tenemos tamaños distintos conviene trabajar con proporciones

# En proporciones para cada grupo: [1,] joven, [2,] mayor
rbind(
  round( prop.table(tablajoven), 4), 
  round( prop.table(tablamayor), 4)
)

fisher.test(tablacancer) #vemos p-valor y no encontramos evidencias para rechazar

# A pesar de observar una mayor proporción de lpsa en la muestra de la gente 
# mayor que en la joven, con el test de Fisher no podemos rechazar la igualdad 
# de proporciones de lpsa en ambos grupos a nivel poblacional.

##########################################################################
# 3.4 ----
# Veamos ahora sobre el modelo lineal
# el criterio que vamos a usar es el de minimos cuadrados

reg1 = lm(lpsa ~ lcavol) #primero variable objetivo y
                         #luego las variables explicativas

plot(lcavol, lpsa)
abline(reg1, col ="red" ) #pinta una linea sobre un grafico hecho

cor(lpsa,lcavol) #coef.de correlación lineal

# la curva de regresion va a hacer la media de los valores repetidos en 
#una misma x en vez de ver los puntos como los de la grafica

cor(lpsa,lcavol)^2 #coef. de determinación (va a estar entre 0 y 1)
                   #cuanto mas cercano será mejor

summary(reg1)

########
#hace la regresión sobre todas las variables explicativas de prost
lm(lpsa ~ ., data = prost)  #vemos un tipo de regresion multiple

#explicación svi en la regresión
lm(lpsa ~ svi)

# 3.5 ----

#Predicción cuando lcavol vale su valor medio
mean(lcavol)

#1.5073       0.7193  
reg1$coefficients

1.5073  +  0.7193*1.35001 #2.478...

predict(reg1, newdata = data.frame(lcavol = c(1.35,2))) 
# ojo con el predict pq hay veces que es mejor hacerl a mano el calculo
# como hemos hecho calculando las medias y viendo los valores respect.

# 3.6 ----

# Vector de residuos a mano
lpsa - (1.5072975 +  0.7193204*lcavol ) #lpsa es la y 
#head(lpsa - (1.5072975 +  0.7193204*lcavol))

lpsa - reg1$fitted.values #forma analoga de hacerlo
# head(lpsa - reg1$fitted.values)

reg1$residuals #forma sencilla
#head(reg1$residuals) #forma sencilla

plot(reg1$residuals, lpsa)
