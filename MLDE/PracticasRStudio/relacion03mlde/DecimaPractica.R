# Relacion 3. Ejercicio 1

# Lectura de Datos ----
admision <- read.csv("~/admision.txt", sep="", stringsAsFactors=TRUE)
summary (admision)
# No es necesario correr estas líneas si las variables 
# ya se leyeron como factores
admision$admitido = as.factor(admision$admitido)
admision$Nivel.centro = as.factor(admision$Nivel.centro)
admision$sexo = as.factor(admision$sexo)

str(admision)

summary(admision) #hay 2 var cuantitativas y 3 categoricas(factores)

contrasts(admision$admitido) # para ver codificaciones internas de las variables
                            # de tipo Factor
contrasts(admision$sexo) # esta y la anterior son variables dicotómicas o binarias

# mujer 1 indica que en la reg, la var predictora asoc sera sexoMujer
# por lo que cuando sea ind hombre valdra 0 y mujer 1, solo tiene efecto en modelo
# cuando sea una mujer.

contrasts(admision$Nivel.centro) #tiene 4 categorias. se codifica orden alfabitico
                                 # lo que puede dar fallos
# cuando hay var categorica con k categorias, se usan k-1 var. ficticias o dummy,
# para describirla adec mediante var dicotomicas. Aqui hay 3 dummys.

admision$Nivel.centro = relevel(admision$Nivel.centro, ref = "Escaso" ) #definimos orden adecuado
                                         # ref para poner la referencia
contrasts(admision$Nivel.centro)
# se generan 3 variables dummy

(mDummy = lm(calificacion ~ Nivel.centro, data = admision)) #vemos c.dummy no se solapan

predict(mDummy, data.frame(Nivel.centro = "Medio"))  # 570.149 + 25.877 =beta0 + beta(centromedio)
# no van a influir en la prediccion las otras variables

predict(mDummy, data.frame(Nivel.centro = "Escaso")) # 570.149 + nada más pq es la var referencia.

attach(admision)


# Estudio descriptivo previo ----
summary(admision)

# Para las continuas hacemos boxplot y vemos sus correlaciones:

boxplot(calificacion)$out #Representa el boxplot y los valores outliers.


#boxplot.stats(calificacion)$out solo muestra los valores outliers, 
#                                sin representar el boxplot

ind = which(calificacion %in% boxplot.stats(calificacion)$out) 
admision[ind,]

boxplot(test.psico)$out
which.min(test.psico)

# vemos que las obs 72,180,305 y 326 son outliners para calif y la 290 para test.psico

cor(calificacion, test.psico)
# Se descarta colinealidad y multicolinealidad0
# OJOOO: se puede hacer solo la correlacion con las var continuas


# para las categóricas hacemos tabla con los porcentajes de cada categoria

table(admitido) #Por ser de clase Factor, es lo mismo que salía en el summary

100*prop.table(table(admitido))
100*prop.table(table(sexo))
100*prop.table(table(Nivel.centro))


# Analiza, desde el punto de vista univariante, si cada una de las variables cualitativas influyen en la admisión. ----

# Dependencia entre el sexo y la admisión
table(admitido,sexo)

#para facilitar la interpret rehacemos la tabla con los si admitido en primera fila
(tAS= table(relevel(admitido, ref = "Si admitido"), sexo)) #el si suele ser el q nos interesa

fisher.test(tAS)
# vamos a contrastar la hipótesis nula H0: las probabilidades de ser o no admitido 
# son las mismas en hombres y mujeres.
# analogo a decir: el ratio de Si admitido en hombres es igual el ratio de Si 
# admitido en mujeres. --> odds ratio. = 1.516607
# Esto no dice: Es 1.52 veces más verosímil resultar admitido siendo hombre que siendo mujer


table(admitido, sexo) # son de tipo discreto - no podemos ver correlacion lineal
fisher.test(table(admitido, sexo))
# comprobamos que si tenemos arriba el no admitido va a salir lo mismo

# Sin embargo,  no hemos podido rechazar el contraste de homogeneidad porque el 
# p-valor es 0.06743. No podemos rechazar que se trate distinto a los hombres q a las mujeres.
 
fisher.test(tAS, alternative = "greater")
# H1: odds ratio>1, ratio de no admitidos en hombre es mayor q el de mujeres
# sale p-valor 0.03 --> rechaz H0 y se acepta H1. 
# Por tanto: Es más verosímil ser admitido siendo hombre que siendo mujer


# Dependencia entre el centro de preparación y la admisión
(tAD=table(Nivel.centro, admitido) )
(c=chisq.test(tAD)) 
# H0: Nivel.centro sea homogenea respecto a admitido, es decir, la prop de admitidos
# es la misma en todos los niveles de centro.
# p-valor muy pequeño por lo que rechazamos H0 --> el centro de preparación 
#                                                  influye en la admisió


#Por curiosidad, podemos repasar qué elementos tenía un test Chi Cuadrado

names(c)#todos los elementos que encontramos en "c"
# Nos fijamos en los valores observados,los esperados y los residuos
c$observed #la tabla t1

c$expected #Todos los valores esperados son mayores que 5, si no habría Warning

c$residuals #diferencia entre observados y esperados



# Analiza, desde el punto de vista univariante, si cada una de las variables cuantitativas influyen en la admisión ----

#Comportamiento de la variable calificación en los grupos de admitidos/no admitidos

#Primero dividimos calificacion en uno para si admitido y otro para no admitido
nota.admitidos=admision[admitido=="Si admitido","calificacion"]
summary(nota.admitidos)
nota.Noadmitidos=admision[admitido=="No admitido","calificacion"]
summary(nota.Noadmitidos)

par(mfrow = c(1,2))
hist(nota.admitidos)
hist(nota.Noadmitidos)
par(mfrow = c(1,1))
#parace que nota admitidos es mayor que la de no admitidos

shapiro.test(nota.admitidos) #pvalor 0.02094, se rechaza la normalidad
shapiro.test(nota.Noadmitidos)#pvalor 0.02172, se rechaza la normalidad

#Al ser distribuciones no normales deberíamos pasar a contrastes no paramétricos.
# No lo vemos asi que hacemos como si nada y sup q muestras son normales

#Se admite que las varianzas son iguales.
var.test(nota.admitidos,nota.Noadmitidos) 

#Se rechaza la igualdad de medias.
t.test(nota.admitidos,nota.Noadmitidos,var.equal=TRUE) 

#viendo los datos podemos pensar q nota admitidos es mayor q no admitidos, lo vemos
t.test(nota.admitidos,nota.Noadmitidos,alternative="greater", var.equal=TRUE)
# podemos concluir: la calificación es mayor en los admitidos

# La calificación influye en la admisión: una alta calificación favorece la admisión.



# Comportamiento de la variable puntuación en el test psicotécnico en los grupos de admitidos/no admitidos ----
psico.si=admision[admitido=="Si admitido","test.psico"]
summary(psico.si)
psico.no=admision[admitido=="No admitido","test.psico"]
summary(psico.no)

par(mfrow = c(1,2))
hist(psico.si)
hist(psico.no)
par(mfrow=c(1,1))

shapiro.test(psico.si) #pvalor  0.0003394, se rechaza la normalidad
shapiro.test(psico.no)#pvalor  0.001575, se rechaza la normalidad
#aunq rechacemos normalidad lo vamos a asumir para continuar

var.test(psico.si,psico.no) #Se admite que las varianzas son iguales.
t.test(psico.si,psico.no,var.equal=TRUE)#Se rechaza la igualdad de medias.

t.test(psico.si,psico.no,alternative="greater", var.equal=TRUE)
# Concluimos:  la puntuación del test es mayor en los admitidos



# Regresión correspondiente respecto a todos los factores. Interpretación ----
# Vale para Y bernoulli o binomial, en general
rtodas = glm(admitido ~ ., data = admision, family = "binomial") #glm con faminili
                                                # binomial de r.logistica 
rtodas
# Hay que tener en cuenta la interpretacion de los betaj si son positivos o negativos
# Hay que tener en cuenta si las var son continuas o categoricas
coef(rtodas)
exp(coef(rtodas))

# Por ej, el modelo estima que cuando la nota del psicotécnico aumenta en una
# unidad, es 2.168 veces más verosímil ser admitido.
# Tambien estima que es 1/0.63 = 1.577 veces mas verosimil que un hombre sea 
# admitido que una mujer

(IC = confint(rtodas)) #ICs para los \beta_j

exp(IC) # ICs para las odds ratio  - nos fijamos en el 1
#centro basico la unica que tiene el 1 en el IC
summary(rtodas)
# podemos ver que el unico que está el uno en el exp(IC) es el unico en el sumary que 
# aparece como variable no significativa , esto nos dice que:
#   el modelo considera que no es significativo provenir de un centro 
# de nivel básico frente a uno de nivel escaso a la hora de ser seleccionado

# se puede comentar en el sumary el numero de grado de libertad

# Los estadísticos D y G

# la desviacion aparece expresada mediante Null Deviance

#el modelo saturado un modelo con tantos parámetros como observaciones

m.sat = glm(admitido ~ as.factor(1:400), data = admision, family="binomial") #por 400 observaciones
# sabemos que la max verosimilitud del modelo saturado en la regresión logística siempre es 1 

# Residual deviance: D(rtodas) = 454.6 en el summary 
deviance(rtodas)

-2*logLik(rtodas) # nos da lo mismo y los g.l.

# Null deviance: D(modelo nulo) = 500 en el summary
nulo = glm(admitido ~ 1, data = admision, family = "binomial")
deviance(nulo)

-2*logLik(nulo)
# Considerar errores al usar métodos iterativos: sale aproximadamente 0 (1 el mx.ver.sat)
logLik(m.sat)
deviance(m.sat)
(G = deviance(nulo)-deviance(rtodas))

# a menor D mejor modelo, a mayor G mejor modelo

# Contraste para G - parecido al contraste fundamental
#ojo con la region critica
pchisq(G, 6, lower.tail = F) # para ver el p-valor del contraste
anova(nulo, rtodas, test = "LRT") # Hace lo mismo pero con el LRT


#Contraste para D - contrasta si el modelo estudiado es el correcto 
#install.packages("ResourceSelection")
pchisq(454.6, 393, lower.tail = F)
anova(rtodas, m.sat, test = "LRT") # Hace lo mismo 

# Sin embargo, en este caso no es correcto usar D para el contraste porque el
# modelo contiene variables explicativas continuas, será válido cuando todas las 
# variables explicativas sean de tipo factor.

#Si hay variables explicativas continuas usamos:
library(ResourceSelection)
hoslem.test(rtodas$y,rtodas$fitted.values)
#en este contraste nos interesa aceptar y no rechazar

# En conclusión, no podemos rechazar que el modelo ajustado sea el correcto 
# (mismo contraste que la D). Esto va a significar que realmente el modelo va bien



# Predice la probabilidad de que un hombre, procedente de un centro con nivel de ----
# formación escaso, con una calificación de 20 puntos y 3 puntos en el test 
# psicológico, sea admitido.

nuevodato = data.frame(calificacion = 20, test.psico = 3, 
                       Nivel.centro = "Escaso", sexo = "Hombre")
(pp = predict(rtodas, nuevodato) )

# ¿Una probabilidad negativa? No. En una regresión logística hay que transformar el resultado:
exp(pp)/(1 + exp(pp)) #esta es la tranformacion para tener la PROBABILIDAD
 
predict(rtodas, nuevodato, type = "response") # analogo a lo anterior con ese type

# Interpretación: La estimación de la probabilidad de que un individuo en las 
# condiciones pedidas sea admitido es de 0.05309492.


# Estudio modificando las categorías de referencia de los factores cualitativos. ----
# Interpreta las odds-ratio

refCambiadas = admision

refCambiadas$Nivel.centro = relevel(refCambiadas$Nivel.centro, 
                                    ref = "Superior") #en vez de Escaso

refCambiadas$sexo = relevel(refCambiadas$sexo, ref = "Mujer")#en vez de Hombre

contrasts(refCambiadas$sexo)
contrasts(refCambiadas$Nivel.centro)

# Modelo con todas las variables explicativas, pero con REFERENCIAS CAMBIADAS
(rtodasRC = glm(admitido ~ ., data = refCambiadas, family = "binomial") )

# Podemos ver si han cambiado los coeficientes
coef(rtodasRC)
coef(rtodas)

exp(coef(rtodasRC))
exp(coef(rtodas))
# Podemos comparar estos resultados con el primero obtenido


# Métodos de selección de variables paso a paso. Conclusiones ----
step(rtodas,direction = "backward", trace = F)
# no ha quitado ninguna de las varibales

nulo=glm(admitido ~ 1, data=admision, family = "binomial") #OJO con el type
step(nulo,direction ="forward",
     scope=list(lower=nulo, upper=rtodas), trace = F)
#tambien nos devuelve todas
step(rtodas, direction = "both", trace = F)
# Parece un modelo adecuado para explicar estas varibles

# Curva ROC ----
#install.packages("pROC")
library(pROC)

curvaRoc = roc(admitido, rtodas$fitted.values, plot = TRUE, 
               xlab = "Porcentaje Falsos Positivos",
               ylab = "Porcentaje Verdaderos Postivios", col = "orange", lwd = 2,
               print.auc = TRUE)
# AUC nos interesa que sea lo mas cercano a uno.

coords(curvaRoc, "best", ret = c("threshold", "accuracy", "specificity", 
                                 "sensitivity", "youden" )) # el best elige el mejor nivel
                                                            # el que hace mejores predicciones (0.3342...)
# nos da unos coeficientes que pertenecen a la tabla de confusión. se va a ver 
# mas en el ejercicio 3. Van a ser medidas de efectividad