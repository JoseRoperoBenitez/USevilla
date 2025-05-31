# Validacion cruzada y técnicas de Regularizacion

## Generacion de unos datos simulados ----

# Establecer una semilla para reproducibilidad
set.seed(123)
n.obs = 1000 # número de observaciones

# Generar datos simulados con relaciones lineales y correlaciones
publicidad <- runif(n.obs, min=1000, max=5000) # Gastos en publicidad, variable uniforme
ubicacion <- as.numeric(factor(sample(c('Centro', 'Suburbio', 'Rural'), n.obs,
                                      replace=TRUE))) # Ubicación de la tienda codificada numéricamente
# el sample con remplazamiento nos va sacando uno de los tres valores
# cuidado pq factor ordena alfabeticamente las variables
dias_ultima_promo <- sample(1:30, n.obs, replace=TRUE) # Días desde la última promoción
comp_cerca <- sample(c(0, 1), n.obs, replace=TRUE) # Presencia de competencia cercana (0 = No, 1 = Sí)

# Creamos multicolinealidad. Idea: 
#  -con más gasto en publicidad, la valoración del cliente mejora
#  -con más días desde la última promoción, la valoración del cliente empeora
# scale() se usa para estandarizar variables --> (van a tener media 0 y var 1)

satis_cliente <-  as.numeric( 5 + scale(publicidad) - scale(dias_ultima_promo))
summary(satis_cliente)

cor(satis_cliente, publicidad)
cor(satis_cliente, dias_ultima_promo)

# error
error = rnorm(n.obs, mean=0, sd=10)

# Crear una variable de ventas que dependa de las otras variables (un modelo lineal)
ventas <- 150 + 0.3*publicidad - 15*ubicacion + 20*satis_cliente - 0.5*dias_ultima_promo - 20*comp_cerca + error

# Crear un data.frame con los datos generados
datos_simulados <- data.frame(ventas, publicidad, ubicacion, satis_cliente, dias_ultima_promo, comp_cerca)
datos_simulados <- round(datos_simulados, 2)

# Ver los primeros registros del data.frame
head(datos_simulados)

mod_lineal = lm(ventas ~ ., data = datos_simulados)
summary(mod_lineal)

# Hay que tener cuidado pq aqui vemos que el problema de multicolinealidad puede
# que no lo observemos a primera por el buen R^2. Pero nos podemos fijar en los 
# coef pq si hay pr. mult. puede haber fallos en los coeficientes.

# En este caso, aunque el modelo realice un buen ajuste, no está estimando bien
# los coeficientes, betaj

## Validacion cruzada o division de datos ----

# Leer apuntes
#La validación cruzada es una técnica que evalúa modelos predictivos al dividir la muestra original en

#un conjunto de entrenamiento para construir (entrenar) el modelo y

#un conjunto de validación o test para evaluar (validar) qué tan bien predice 
#el modelo estimado con datos no vistos.

# Se suele usar RMSE = raiz(SCE/n*)

## Método de Retención ----

set.seed(123) # fijar la semilla
N = nrow(datos_simulados)
0.70*N # 70% de N  
## [1] 700
round(0.70*N,0) 
## [1] 700
indices_entrena = sample(x = 1:N, size = round(0.70*N,0) ) #no ponemos el remplace
                                                           #pq queremos q sea falso
datos_entrena = datos_simulados[indices_entrena,]# saca todas las filas
datos_test = datos_simulados[-indices_entrena, ] #saca todas las variables

modelo_01 = lm(ventas ~ ., data = datos_entrena)
modelo_02 = lm(ventas ~ publicidad + ubicacion, data = datos_entrena)

# Por defecto, la función supone que la variable objetivo está en la primera 
# columna de datos_test. Cambiar si es necesario

RMSE <-  function(modelo, datos_test, colum_var_objetivo = 1)
{
  pred <- predict(modelo, datos_test)
  salida <- sqrt( sum( (datos_test[colum_var_objetivo] - pred)^2 ) / nrow(datos_test) )
  return(salida)
}

RMSE(modelo_01, datos_entrena)
RMSE(modelo_02, datos_test)

#Vemos que el modelo1 va a tener un valor menor de RSME.

## Metodo de validacion cruzada de k iteraciones

# install.packages("caret")
library(caret)

set.seed(123)
# Esta función indica el método de VC: controla la generación de las muestras 
# de entrenamiento y de validación. Las principales opciones para el argumento 
# method en validación cruzada son "cv", "LOOCV" o "repeatedcv"
control <- trainControl(method = "cv", number = 10)

# Esta función ajusta el modelo en las muestras de entrenamiento y lo evalúa 
# en las muestras de validación
modeloVC_01 <- train(ventas ~ ., data = datos_simulados, 
                     method = "lm", trControl = control)
modeloVC_01

modeloVC_02 <- train(ventas ~ publicidad + ubicacion, data = datos_simulados, 
                     method = "lm", trControl = control)
modeloVC_02
# Sigue siendo el modelo 1 mejor.

## Intro a tecnicas de regularizacion: ridge y lasso ----

# Regresion ridge
# leer

# Regresion lasso
# leer

# Elastic Net
## Ejemplo de utilización de gmlnet():

# install.packages("glmnet")
library(glmnet)
modelo_ridge <- glmnet(X, y, alpha = 0)
modelo_lasso <- glmnet(X, y, alpha = 1)

#Calculamos suma de los coef de regresion

sum(abs(coef(mod_lineal)[-1])) #la q usa lasso

sum((coef(mod_lineal)[-1]^2)) # la que usa rige

## Fun glmnet para calculos los metodos de reg. ----

# Si se tiene un data.frame con los datos: y, x en: datos
# 1. Quitar valores NA:  datos = na.omit(datos)
## En este caso no existen valores NA
# 2. Convertir a matrix las variables predictoras del siguiente modo:
#     x = model.matrix(y ~ ., datos)[, -1]
X = model.matrix(ventas ~ ., datos_simulados)[,-1]
head(X)

y = datos_simulados$ventas

# METODO LASSO

library(glmnet)
ajuste_Lasso <- glmnet(X, y, alpha = 1)  # alpha = 1 por defecto (Lasso)
ajuste_Lasso

par(mfrow = c(1, 2))
plot(ajuste_Lasso)
plot(ajuste_Lasso, xvar = "lambda", label = TRUE)
# Cada color se asocia a una de las varaibles predictoras

# METODO RIDGE
#library(glmnet)
ajuste_Ridge <- glmnet(X, y, alpha = 0)  
ajuste_Ridge

par(mfrow = c(1, 2))
plot(ajuste_Ridge)
plot(ajuste_Ridge, xvar = "lambda", label = TRUE)

# Busacmos seleccionar el valor óptimo de landa

# Regularizacion de Ridge con validacion cruzada

#library(glmnet)
set.seed(123) # Para reproducibilidad
cv_ajuste_Ridge <- cv.glmnet(X, y, alpha = 0)
c(cv_ajuste_Ridge$lambda.min, log(cv_ajuste_Ridge$lambda.min) ) #landa q minimiza

c(cv_ajuste_Ridge$lambda.1se, log(cv_ajuste_Ridge$lambda.1se) ) #es largo de explicar
                                                 # pero se suele quedar con este

par(mfrow = c(1, 1))
plot(cv_ajuste_Ridge)  #muestra el error cuadratico medio para log(landa)

coef(cv_ajuste_Ridge)  # coef(cv_modelo, s = "lambda.1se")
coef(cv_ajuste_Ridge, s = "lambda.min") #el que buscamos q hemos dicho q coincide

predict(cv_ajuste_Ridge, newx = X[1:5, ], s = c(cv_ajuste_Ridge$lambda.min, cv_ajuste_Ridge$lambda.1se))

#Calculamos RSME:
# mean((y - predict(cv_ajuste_Ridge, X, )) ^ 2) #hace lo mismo
sqrt(mean((y - predict(ajuste_Ridge, X, s = cv_ajuste_Ridge$lambda.1se)) ^ 2) )

sqrt(mean((y - predict(ajuste_Ridge, X, s = cv_ajuste_Ridge$lambda.min)) ^ 2) )
# No se ha mejorado con respecto al primer RSME que hicimos

sum(abs(coef(cv_ajuste_Ridge, s = "lambda.min")[-1]))

sum((coef(cv_ajuste_Ridge, s="lambda.min")[-1]^2))

sum(abs(coef(cv_ajuste_Ridge, s = "lambda.1se")[-1]))
sum((coef(cv_ajuste_Ridge, s="lambda.1se")[-1]^2))


# Regularizacion LASSO

#library(glmnet)
set.seed(123) # Para reproducibilidad
cv_ajuste_Lasso <- cv.glmnet(X, y, alpha = 1)
c(cv_ajuste_Lasso$lambda.min, log(cv_ajuste_Lasso$lambda.min) )

c(cv_ajuste_Lasso$lambda.1se, log(cv_ajuste_Lasso$lambda.1se) )

plot(cv_ajuste_Lasso)  

coef(cv_ajuste_Lasso, s = "lambda.min" )  
coef(cv_ajuste_Lasso)  # coef(cv_modelo, s = "lambda.1se")

predict(cv_ajuste_Lasso, newx = X[1:5, ], s = c(cv_ajuste_Lasso$lambda.min))

#Calculo RSME

# mean((y - predict(cv_ajuste_Lasso, X, )) ^ 2) #hace lo mismo
sqrt(mean((y - predict(ajuste_Lasso, X, s = cv_ajuste_Lasso$lambda.1se)) ^ 2) )

sqrt(mean((y - predict(ajuste_Lasso, X, s = cv_ajuste_Lasso$lambda.min)) ^ 2) )

sum(abs(coef(cv_ajuste_Lasso, s = "lambda.min")[-1]))
sum((coef(cv_ajuste_Lasso, s="lambda.min")[-1]^2))

sum(abs(coef(cv_ajuste_Lasso, s = "lambda.1se")[-1]))
sum((coef(cv_ajuste_Lasso, s="lambda.1se")[-1]^2))

## EXTRA ----

# La fun glmenet tb se va a poder usar con la regresion logistica

# ibrary(glmnet)
# fit_cv = cv.glmnet(X, y, family = "binomial", alpha = 1)
# plot(fit_cv)
