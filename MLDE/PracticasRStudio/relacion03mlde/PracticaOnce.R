# Ejercicio 2 Relacion 3

#(Problema de Confusion)

#Lectura de Datos ----
inf = fumarcafe <- read.csv("~/fumarcafe.txt", sep="", stringsAsFactors=TRUE)
summary (inf)

contrasts(inf$infarto)
contrasts(inf$cafe)
contrasts(inf$tabaco)

inf$tabaco = relevel(inf$tabaco,ref="No fumador")
# El exito en todos va a ser el No
contrasts(inf$tabaco)
attach(inf)

# Dependencia entre haber sido fumador y haber sufrido un infarto ----

#La interpretación de la odds ratio sería confusa. Vamos a rotar la tabla
table(infarto,tabaco)
(t.fum = table(relevel(infarto, ref = "Si infarto"), 
               relevel(tabaco, ref = "fumador")))
fisher.test(t.fum)

# Se rechaza la independencia, es decir: hay dependencia entre haber sido 
# fumador y haber sufrido un infarto. El odds ratio mayor q 1
# Interpret odd ratio --> ventaja de ocurrencia de tener infarto es 6.54
# veces mayor en fumadores que en no fumadores.


# Cuantifica esa dependencia mediante un modelo que prediga sufrir un infarto ----
# en función de que la persona sea o no fumadora.

r.fum = glm(infarto ~ tabaco, family = "binomial")
summary(r.fum)

exp( coef(r.fum) ) #odds ratio estimadas
( Ir.fum = confint(r.fum) ) #IC \betas_j

exp(Ir.fum) #IC odds ratio
# rechazamos que betafumador = 0, por tanto q su odds ratio sea 1


# Dependencia entre haber sido consumidor de café y haber sufrido un infarto.----

# Cambiamos las referencias para facilitar la interpretación
(t.cafe = table(relevel(infarto, ref = "Si infarto"), 
                relevel(cafe, ref = "Si consume cafe")))
fisher.test(t.cafe) # que haya dependencia no implica causalidad

# Interpretación de la odds ratio estimada: la ventaja de ocurrencia de un 
# infarto es veces mayor cuando se consume café que cuando no.


# Cuantifica esa dependencia mediante un modelo que prediga sufrir un infarto ----
# en función de que la persona sea o no consumidora de café.
r.cafe=glm(infarto ~ cafe, family = "binomial")
summary(r.cafe)
exp(coef(r.cafe)) #odds ratio
( Ir.cafe = confint(r.cafe) ) #IC \betas_j
exp(Ir.cafe) #IC odds ratio


# Construye un modelo logístico que prediga sufrir un infarto en función de ----
# las dos covariables. 
# Compara el modelo obtenido con los de los apartados anteriores.

rtodas2=glm(infarto ~ cafe + tabaco, family = "binomial")
summary(rtodas2)
#nos damos cuenta que lo mejor parece ser quitar cafeSi
# peor AIC que el de solamente fumar. Nos dice que es mejor quitar el cafe
exp(coef(rtodas2)) #odds ratio

( IC.rtodas = confint(rtodas2) ) #IC \beta_j
exp(IC.rtodas2) #IC odds ratio
# Vamos que el cafe no influye en el modelo, el beta estimado del cafe es prac. 0

# LEER CONCLUSION

# Dependencia entre las dos covariables del modelo.(cafe y tabaco) ----
(t3 = table(relevel(tabaco, ref = "fumador") , 
            relevel(cafe, ref = "Si consume cafe")))
fisher.test(t3)
# se rechaza H0 de indep. Hay indep y la ventaja de ocurrencia de consimur cafe
# es 75.67 veces mayor en fumadores que no fumadores


# Dependencia entre haber sido consumidor de café y haber sufrido un infarto en ----
# las personas fumadoras

inf_si = inf[tabaco == "fumador",]  #Seleccionamos los fumadores de la muestra
summary(inf_si)

(tfumador = table(relevel(inf_si$infarto, ref = "Si infarto"),
                  relevel(inf_si$cafe, ref = "Si consume cafe")))

fisher.test(tfumador) #no encontramos para rechazar la independencia

glm_si=glm(infarto ~ cafe, data = inf_si, family="binomial")
summary(glm_si)

# Se observa que dentro del grupo de los fumadores, el café no afecta al 
# infarto. La odds ratio estimada es 1


# Dependencia entre haber sido consumidor de café y haber sufrido un infarto
# en las personas no fumadoras.

inf_no = inf[tabaco == "No fumador",]
summary(inf_no)

(tnofumador = table(relevel(inf_no$infarto, ref = "Si infarto"), 
                    relevel(inf_no$cafe, ref = "Si consume cafe")))

fisher.test(tnofumador) #no encontramos rezones para rechazar indep

glm_no=glm(infarto ~ cafe, data = inf_no, family="binomial")
summary(glm_no)

# Se observa que dentro del grupo de los no fumadores, el café no afecta al infarto.

# Relacionar sucedido con paradoja de Simpson ----

# Leer apuntes

# A este efecto se le llama confusion: globalmente se observa una tendencia (el 
# café afecta a los infartos), pero segregando la muestra mediante una tercera
# variable (llamada variable de confusión), se observa la tendencia contraria.
# En este caso, la variable de confusión es tabaco.
# La cuestión es que la variable que causa los infartos es el tabaco, no el café.


# Construccion de un modelo con el menor número de variables explicativas ----

# Regresión paso a paso hacia atrás
step(rtodas2, direction="backward")

# obtenemos lo que estabamos buscando

# Contrastes de los modelos. ----

rtodas2
1 - pchisq(397 - 361.8, df = 2) # se rechaza el modelo fundamental

r.fum
1 - pchisq(397 - 361.8, df = 1) # tb se rechaza el modelo fundamental


# Veamos ahora si los modelos ajustan bien los datos con un test de bondad 
# de ajuste

rtodas2 #se usa el D: residual deviance
# También podría usarse la función deviance() en vez de copiar el número
1 - pchisq(361.8, df = 1000 - 2 - 1) # rtodas2
# aceptamos H0

r.fum
1 - pchisq(361.8, df = 1000 - 1 - 1) #r.fum

# si hay un ejercicio con var continuas podemos discretizarla y pasarlas a factores