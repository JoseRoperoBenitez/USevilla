# Relacion 3. Ejercicio 3

# Nos dan los datos con una tabla

datos<-matrix(
  c( rep(c("si infarto","fumador","joven"),6), # el vector q le pase lo va a repetir 6 veces
     rep(c("no infarto","fumador","joven"),294),
     rep(c("si infarto","no fumador","joven"),4),
     rep(c("no infarto","no fumador","joven"),296),
     rep(c("si infarto","fumador","mayor"),28),
     rep(c("no infarto","fumador","mayor"),172),
     rep(c("si infarto","no fumador","mayor"),5),
     rep(c("no infarto","no fumador","mayor"),195)),  ncol=3,byrow=T) #todos elems de 
                                  # una matriz tienen que ser del mismo tipo
                                  # byrow = T para que relle como queremos

colnames(datos)<- c("Infarto","Tabaco","Edad")
head(datos)

dim(datos)

class(datos)

#datos$Infarto # Da error porque datos no es data.frame

datos <- data.frame(datos)
head(datos)
class(datos)

# Para mostrar los datos en una tabla de frecuencias de triple entrada (enunciado)

table(datos[,1],datos[,2],datos[,3]) # se refieren a las cols 1,2,3

ftable(table(datos[,1],datos[,2],datos[,3])) #flat table

datos$Infarto = as.factor(datos$Infarto)
datos$Edad = as.factor(datos$Edad)
datos$Tabaco = as.factor(datos$Tabaco)

contrasts(datos$Infarto) # vemos los valores referencia que usa
contrasts(datos$Tabaco)

datos$Tabaco = relevel(datos$Tabaco,ref="no fumador")
contrasts(datos$Tabaco) # queremos los valores de referencia los no fumador --> 1 al si fumador

summary(datos) #tabla de frecuencias de los datos individualmente
attach(datos)

# Regresiones logisticas univariantes y multivariante ----

rEdad = glm(Infarto ~ Edad, data = datos, family = "binomial")
summary(rEdad)

exp(coef(rEdad)) #odds ratio
# mayor edad contribuye a la aparición de infartos

rTabaco = glm(Infarto ~ Tabaco, data = datos, family = "binomial")
summary(rTabaco)

exp(coef(rTabaco)) #odds ratio
# fumador contribuye a la aparicion de infartos

rtodas3=glm(Infarto ~ Edad + Tabaco, data = datos, family = "binomial")
summary(rtodas3)

coef(rtodas3) #coeficientes \beta_j
exp(coef(rtodas3)) #odds ratio

ICtodas = confint(rtodas3,level=0.95)
ICtodas
exp(ICtodas)

# Mirar conclusiones: Vemos que una mayor edad y ser fumador contribuyen a la
# aparición de infartos. Odds ratio: ventaja ocurrencia de infarto es 5.44 veces 
# mayor que cuando joven y 4,11 la de tener infarto siedo fumador en vex de no fumador


# Selección de variables ----
step(rtodas3, direction = "both",  trace = F) #nos deja modelo completo

nulo=glm(Infarto ~ 1, family = "binomial")
step(nulo, direction = "forward",
     scope=list(lower=nulo, upper=rtodas3),
     trace = F)

step(rtodas3, direction = "backward",  trace = F) 
# los tres modelos eligen el modelo general con el D = 313 (residual deviance)


# Estudia separadamente en fumadores y no fumadores la incidencia de la edad en ----
# la incidencia del infarto

# pera test de ficher mejor la referencia sobre el si

## Tabla global Edad-Infartos
t1 = table(relevel(Infarto, ref = "si infarto"), relevel(Edad, ref = "mayor"))
t1

fisher.test(t1) # hay dependencia
# obtenemos de nuevo lo que ya obtuvimos con los modelos de regresión logística:
# que globalmente la edad afecta a la aparición de infartos 

## Fumadores
inf_siF = datos[Tabaco == "fumador",]

tfumador = table(relevel(inf_siF$Infarto, ref = "si infarto"), 
                 relevel(inf_siF$Edad, ref = "mayor"))
tfumador

fisher.test(tfumador)
#  Dentro de los fumadores la edad afecta a la aparición de infartos.
# Entre fumadores, tener un infarto es 7.94 veces más verosímil siendo 
# mayor que siendo joven

## No fumadores
inf_noF = datos[Tabaco == "no fumador",]

tnofumador = table(relevel(inf_noF$Infarto, ref = "si infarto"), 
                   relevel(inf_noF$Edad, ref = "mayor"))
tnofumador

fisher.test(tnofumador)

# No se rechaza el contraste. Dentro de los no fumadores la edad no afecta al infarto.
# Leer conclusiones

# Iteraccion ----

# Leer bien con respecto a lo que hemps visto
# Se dice que hay interacción cuando el efecto de una covariable en la variable 
# explicada depende del valor de, al menos, otra covariable.

# Antes vimos finalmente que la cafe no tenia que ver con infarto, esto era confusion

## Interacción

I = glm(Infarto ~ Edad * Tabaco, data = datos, family = "binomial")
summary(I)

# esto es: beta1*Edad + beta2*Tabaco + beta3*Edad*Tabaco

# si ponemos Edad:Tabaco hariamos el modelo --> beta1*Edad*Tabaco

# por lo tanto el primero es equivalente a poner :
#  Edad + Tabaco + Edad:Tabaco

# vemos que la unica variable significativa es la de las dos juntas. La interpre.
# es que la edad y tabaco no explican por si solas la aparicion de infarto,
# pero sí cuando se dan ambas a la vez

II = glm(Infarto ~ Edad:Tabaco, data = datos, family = "binomial")
summary(II)
# haciendo esto solamente salen cosas sin sentido

# Tener en cuenta errores de redondeo
exp(-4.3041 + 0.6405 + 0.4122 + 1.4360 ) / (1 + exp(-4.3041 + 0.6405 + 0.4122 + 1.4360 ))
# esto nos da la prob

predict(I, data.frame( Edad = "mayor", Tabaco = "fumador"), type = "response") #es lo mismo que arriba
# sale un 14%

exp(coef(I)) #odds ratio --> mirar la linea de encima de esto
#  la ventaja de ocurrencia de un infarto en un individuo mayor y fumador es 
# 1.89743590*1.510204*4.2039 = 12.04651 veces mayor que en un individuo joven y no fumador.

library(ggplot2)
library(sjPlot)
plot_model(I, type = "int")

# si no habria interaccion se respetaria las disntacias de jover a mayor, vemos que no pasa

# Contraste fundamental. Bondad de Ajuste. ----

# las dos variables son discretas por lo q podemos usar y calcular el G

1 - pchisq(354.73 - 310.06, df = 3)
# rechazamos contraste

1 - pchisq(310.06, df = 1000 - 3 -1)
# leer

# Regresión logística como clasificador ----

# Nos fijamos en las probs de sufrir un infarto estimadas por el modelo
newdata = data.frame(Edad = c("joven", "joven", "mayor", "mayor"), Tabaco = c("no fumador", "fumador", "no fumador", "fumador"))
predict(I, newdata, type = "response")

tf = table(round(I$fitted.values,4)); tf #fitted.values --> valores ajustados
# basandonos en el modelo, tienen las probs mas altas de infartar (0.14) son 
# personas mayores que fuman.

# Leer IMPORTANTE

# Construimos matriz de confusion
predicciones = ifelse(I$fitted.values > 0.1, "si infarto", "no infarto") #0.1 es el nivel q fijamos
table(predicciones)
#dnn son los nombres de las dimensiones
table(I$model$Infarto, predicciones, dnn = c("observaciones", "predicciones")) 
# Infarto primero nos da ñas obsd y las cols predicciones

# la tabla sale con los VP en el (1,1) y los VN en el (2,2)
# VP FN
# FP VN

# tasa de aciertos (VP + VN)/n
# tasa de verdaderos positivos (VP)/(VP + FN)
# tasa de falsos positivos FP/(VN+FP) --> su complem. tasa de verdaderos negativos (especifidad).
# la medida que mas nos interesa es la espcifidad y q sea cercana a 1

# ver los puntos 
# los dos primeros nos interesan mas que sean mas cercanos a 1
# el tercero nos interesa que sea menor posible
# el ultimo nos interesa que se lo mas alta posible

# Curva ROC ----

# La curva ROC se genera calculando y trazando la proporción de verdaderos
# positivos frente la proporción de falsos positivos según se varía el threshold
#install.packages("pROC")
library(pROC)
curvaRoc = roc(Infarto, I$fitted.values, plot = TRUE, 
               xlab = "Proporción Falsos Positivos",
               ylab = "Proporción Verdaderos Postivios", col = "orange", lwd = 2,
               print.auc = TRUE, legacy.axes = TRUE) #ojo con como empieza
# nos interesa que salga lo mas cerca a 1 el AUC


medidas = coords(curvaRoc, ret = c("threshold", "accuracy", "specificity", 
                                   "sensitivity", "youden", "tp", "tn", "fp", "fn" ))
# medidas = coords(curvaRoc, ret = "all") # obtiene 24 columnas
# medidas = coords(curvaRoc, ret = "all")[,c(1:8,23)] # esto obtiene las 9 anteriores
medidas

# View(medidas)
medidas[ medidas$accuracy == max(medidas$accuracy), ]

coords(curvaRoc, "best", ret = c("threshold", "accuracy", "specificity", 
                                 "sensitivity", "youden" ))
# El criterio best implementado en esta función para elegir el mejor umbral es 
# maximizar el índice de Youden:
# Leer el criterio Youden --> Cuanto mas se acerque a uno mejor. OJOOo

# Las probabilidades predichas eran la primera fila de esta tabla
tf

# Una forma de comparar modelos puede ser con el criterio Youden. Aunq se suele usar 
# mas el AIC

# Validacion Cruzada ----
install.packages("caret")
library(caret)
set.seed(123)

control <- trainControl(method = "cv", number = 10)
I_VC <- train(Infarto ~ Tabaco*Edad, data = datos,
              method = "glm", family = "binomial", trControl = control )
I_VC 
# Sale ese accuracy porque el threshold por defecto es 0.5. 
# es complicado cambiarlo,
# la tasa de acierto es 0.95. la medida kappa esta explicada pero no muy importante

kappaCohen <- function(tp, tn, fp, fn)
{2 * (tp*tn - fn*fp) / ((tp+fp)*(fp+tn) + (tp+fn)*(fn+tn))  }

kappaCohen(1,1,0,0) # Máximo teórico
kappaCohen(0,0,1,1) # Mínimo teórico
kappaCohen(28, 785, 172, 15) # No es muy bueno...


# Regularizacion Lasso ----

X = model.matrix(Infarto ~ Tabaco*Edad, datos)[,-1] #quitamos la primera columna
head(X)

y = datos$Infarto
library(glmnet)

ajuste_Lasso <- glmnet(X, y, alpha = 1, family = "binomial")  # alpha = 1 por defecto (Lasso)
ajuste_Lasso                                                  # si alpha=0 es la ridge

# %DEv es similar al R^2, cuanto mas cerca de 0 mejor, cuanto mas cerca de 100 mejor

par(mfrow = c(1, 2))
plot(ajuste_Lasso)
plot(ajuste_Lasso, xvar = "lambda", label = TRUE) # las lineas de distinto color son los beta

set.seed(123) # Para reproducibilidad
cv_ajuste_Lasso <- cv.glmnet(X, y, alpha = 1, family = "binomial")

par(mfrow = c(1, 1))
plot(cv_ajuste_Lasso)

# Observamos que lambda.min < lambda.1se
c(cv_ajuste_Lasso$lambda.min, log(cv_ajuste_Lasso$lambda.min) )

c(cv_ajuste_Lasso$lambda.1se, log(cv_ajuste_Lasso$lambda.1se) )

coef(cv_ajuste_Lasso)  # coef(cv_modelo, s = "lambda.1se")

coef(cv_ajuste_Lasso, s = "lambda.min")
# estos no representan lo mismo que los odds ratio

# Estos resultados son z'beta:
predict(cv_ajuste_Lasso, newx = X[1, ], 
        s = c(cv_ajuste_Lasso$lambda.min, cv_ajuste_Lasso$lambda.1se))

# type = response aplica logit^{-1}(z'beta) para obtener probabilidades estimadas:
predict(cv_ajuste_Lasso, newx = X[1, ], 
        s = c(cv_ajuste_Lasso$lambda.min, cv_ajuste_Lasso$lambda.1se), 
        type = "response") # el response para que te devuelva las probabilidades

# con estas medidas podriamos hacer una nueva matriz de confusion. Podriamos una
# vez dado el modelo podriamos haber comparado sus coefs youden.


#Chuleta regularizacion (Lasso y Ridge)
library(glmnet)
X = model.matrix()[,-1]
y = datos$varObj
mod_Lasso = glmnet(X,y,alpha=1,family="binomial")
mod_Ridge = glmnet(X,y,alpha=0,family="binomial")
sqrt(mean((y - predict(ajuste_Ridge, X, s = cv_ajuste_Ridge$lambda.1se)) ^ 2) ) # RSME
plot(mod_Lasso)
set.seed(123) # Validación en regularización
cv_mod_Lasso = cv.glmnet(X,y,alpha=1,family="binomial")
cv_mod_Ridge = cv.glmnet(X,y,alpha=0,family="binomial")
coef(cv_mod_Lasso, s = "lambda.min")
predict(cv_mod_ajuste, newx = X, s = cv_mod_Lasso$lambda.min, type = "response")

#validacion cruzada
library(caret)
control = trainControl(method = "cv", number = 10)
R_VC = train(..., trControl = control)
