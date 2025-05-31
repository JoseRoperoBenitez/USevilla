# Confusion e Iteracion. Generacion de Datos (material extra)

# Deteccion de la interaccion en un modelo ----

modelo_interaccion <- lm(y ~ X1 + X2 + X1:X2, data = tus_datos) #incluimos 
                               #termino de interaccion X1xX2.

# La confusion y multicolinealidad ----

# Instalar y cargar el paquete car si aún no está instalado
if (!require(car)) {
  install.packages("car")
}
library(car)

# Calcular el VIF para el modelo
vif(model) # Un VIF alto indica una fuerte multicolinealidad. 

# Si encuentras que el VIF es alto para algunas variables, para reducir la 
# multicolinealidad se podría considerar: 
# - eliminar una de las variables correlacionadas o,
# - combinarlas en una sola variable.

# Generacion de datos simulados. V1: sin correlaciones entre los predictores ----

# Establecer una semilla para reproducibilidad
set.seed(123)

# Generar datos simulados
ventas <- rnorm(100, mean=200, sd=20) # Ventas simuladas
publicidad <- runif(100, min=1000, max=5000) # Gastos en publicidad
ubicacion <- factor(sample(c('Centro', 'Suburbio', 'Rural'), 100, replace=TRUE)) # Ubicación de la tienda
satis_cliente <- rnorm(100, mean=7, sd=1.5) # Calificaciones de satisfacción del cliente
dias_ultima_promo <- sample(1:30, 100, replace=TRUE) # Días desde la última promoción
comp_cerca <- sample(c(0, 1), 100, replace=TRUE) # Presencia de competencia cercana (0 = No, 1 = Sí)

# Crear un data.frame con los datos generados
datos_simulados <- data.frame(ventas, publicidad, ubicacion, satis_cliente, dias_ultima_promo, comp_cerca)

# Ver los primeros registros del data.frame
head(datos_simulados)

# V2: con correlacion entre los predictores: ----

# Establecer una semilla para reproducibilidad
set.seed(123)

# Generar datos simulados con relaciones lineales y correlaciones
publicidad <- runif(100, min=1000, max=5000) # Gastos en publicidad
ubicacion <- as.numeric(factor(sample(c('Centro', 'Suburbio', 'Rural'), 100, replace=TRUE))) # Ubicación de la tienda codificada numéricamente
satis_cliente <- rnorm(100, mean=7, sd=1.5) # Calificaciones de satisfacción del cliente
dias_ultima_promo <- sample(1:30, 100, replace=TRUE) # Días desde la última promoción
comp_cerca <- sample(c(0, 1), 100, replace=TRUE) # Presencia de competencia cercana (0 = No, 1 = Sí)

# Crear una variable de ventas que dependa de las otras variables
ventas <- 150 + 0.3*publicidad - 15*ubicacion + 8*satis_cliente - 0.5*dias_ultima_promo - 20*comp_cerca + rnorm(100, mean=0, sd=10)

# Añadir una correlación entre publicidad y dias_ultima_promo
dias_ultima_promo <- dias_ultima_promo + 0.2*publicidad

# Crear un data.frame con los datos generados
datos_simulados <- data.frame(ventas, publicidad, ubicacion, satis_cliente, dias_ultima_promo, comp_cerca)

# Ver los primeros registros del data.frame
head(datos_simulados)

# Introducir multicolinealidad: Metodo simple ----
# Instalar paquetes necesarios si no están instalados
if (!require("MASS")) install.packages("MASS", dependencies = TRUE)

library(MASS)

# Establecer la semilla para reproducibilidad
set.seed(123)

# Generar datos con multicolinealidad usando la función mvrnorm
# Supongamos que tenemos 3 variables predictoras y una variable de respuesta
# Las variables predictoras tienen una alta correlación entre sí

# Crear una matriz de correlación
correlation_matrix <- matrix(c(1, 0.9, 0.9, 0.9, 1, 0.9, 0.9, 0.9, 1), nrow = 3)

# Generar datos
data <- mvrnorm(n = 100, mu = c(0, 0, 0), Sigma = correlation_matrix)

# Convertir a dataframe y añadir una variable de respuesta
data <- as.data.frame(data)
colnames(data) <- c("Predictor1", "Predictor2", "Predictor3")
data$Response <- with(data, 3 + 2 * Predictor1 + 2 * Predictor2 + 2 * Predictor3 + rnorm(100))

# Ver las primeras filas del dataframe
head(data)

# Calcular el Factor de Inflación de la Varianza (VIF) para verificar la multicolinealidad
library(car)
vif(lm(Response ~ ., data = data))

# Introd. multic.: metodo mas completo ----
# Instalar paquetes necesarios si no están instalados
if (!require("MASS")) install.packages("MASS", dependencies = TRUE)
library(MASS)

# Establecer la semilla para reproducibilidad
set.seed(123)

# Generar datos con multicolinealidad oculta
# Supongamos que tenemos 4 variables predictoras y una variable de respuesta
# Las variables predictoras tienen bajas correlaciones lineales entre sí
# pero hay multicolinealidad debido a una combinación lineal

# Crear una matriz de correlación con bajas correlaciones
correlation_matrix <- matrix(c(1, 0.1, 0.1, 0.1, 
                               0.1, 1, 0.1, 0.1, 
                               0.1, 0.1, 1, 0.1, 
                               0.1, 0.1, 0.1, 1), nrow = 4)

# Generar datos
data <- mvrnorm(n = 100, mu = c(0, 0, 0, 0), Sigma = correlation_matrix)

# Convertir a dataframe y añadir una variable de respuesta
data <- as.data.frame(data)
colnames(data) <- c("Predictor1", "Predictor2", "Predictor3", "Predictor4")
data$Response <- with(data, 3 + 2 * Predictor1 + 2 * (Predictor2 - Predictor3) + rnorm(100))

# Ver las primeras filas del dataframe
head(data)

# Calcular el Factor de Inflación de la Varianza (VIF) para verificar la multicolinealidad
library(car)
vif(lm(Response ~ ., data = data))


# Generacion datos: V3 con variables predictoras de tipo factor y con algunas ----
# interacciones entre ellas 
# Establecer la semilla para reproducibilidad
set.seed(123)

# Generar variables numéricas
num_var1 <- rnorm(100)  # Variable numérica normal
num_var2 <- runif(100, min = 50, max = 100)  # Variable numérica uniforme
num_var3 <- sample(1:10, 100, replace = TRUE)  # Variable numérica entera
num_var4 <- rpois(100, lambda = 3)  # Variable numérica de Poisson
num_var5 <- rexp(100, rate = 0.1)  # Variable numérica exponencial
num_var6 <- rbinom(100, size = 1, prob = 0.5)  # Variable numérica binomial

# Generar variables de factor
factor_var1 <- factor(sample(c("Categoría 1", "Categoría 2"), 100, replace = TRUE))
factor_var2 <- factor(sample(c("Grupo A", "Grupo B", "Grupo C"), 100, replace = TRUE))

# Crear interacciones entre variables
interaction1 <- num_var1 * num_var3
interaction2 <- num_var2 * as.numeric(factor_var1)

# Generar la variable de respuesta con una combinación lineal de las predictoras e interacciones
response <- 5 + 1.5 * num_var1 + 2 * num_var2 + 0.5 * num_var3 + 
  3 * as.numeric(factor_var1) + 2 * as.numeric(factor_var2) +
  interaction1 + interaction2 + rnorm(100)

# Crear el dataframe
data <- data.frame(response, num_var1, num_var2, num_var3, num_var4, num_var5, num_var6, factor_var1, factor_var2, interaction1, interaction2)

# Ver las primeras filas del dataframe
head(data)


# V4: con variables predictoras poco significativas (generacion datos) ----
# Establecer la semilla para reproducibilidad
set.seed(123)

# Generar variables numéricas significativas
num_var1 <- rnorm(100)  # Variable numérica normal
num_var2 <- runif(100, min = 50, max = 100)  # Variable numérica uniforme
num_var3 <- sample(1:10, 100, replace = TRUE)  # Variable numérica entera
num_var4 <- rpois(100, lambda = 3)  # Variable numérica de Poisson
num_var5 <- rexp(100, rate = 0.1)  # Variable numérica exponencial
num_var6 <- rbinom(100, size = 1, prob = 0.5)  # Variable numérica binomial

# Generar variables numéricas poco significativas
num_var7 <- rnorm(100, mean = 0, sd = 10)  # Variable numérica con alta varianza
num_var8 <- runif(100, min = -10, max = 10)  # Variable numérica con rango amplio

# Generar variables de factor significativas
factor_var1 <- factor(sample(c("Categoría 1", "Categoría 2"), 100, replace = TRUE))
factor_var2 <- factor(sample(c("Grupo A", "Grupo B", "Grupo C"), 100, replace = TRUE))

# Generar variables de factor poco significativas
factor_var3 <- factor(sample(c("Nivel 1", "Nivel 2"), 100, replace = TRUE))
factor_var4 <- factor(sample(c("Tipo X", "Tipo Y", "Tipo Z", "Tipo W"), 100, replace = TRUE))

# Crear interacciones entre variables
interaction1 <- num_var1 * num_var3
interaction2 <- num_var2 * as.numeric(factor_var1)

# Generar la variable de respuesta con una combinación lineal de las predictoras e interacciones
response <- 5 + 1.5 * num_var1 + 2 * num_var2 + 0.5 * num_var3 + 
  3 * as.numeric(factor_var1) + 2 * as.numeric(factor_var2) +
  interaction1 + interaction2 + rnorm(100)

# Crear el dataframe
data <- data.frame(response, num_var1, num_var2, num_var3, num_var4, num_var5, num_var6, 
                   num_var7, num_var8, factor_var1, factor_var2, factor_var3, factor_var4, 
                   interaction1, interaction2)

# Ver las primeras filas del dataframe
head(data)

## Ejemplo de resolución de regresión lineal con datos con interacción ----
mod_lineal_noint = lm(response ~ num_var1 + num_var2 + num_var3 + num_var4 + 
                        num_var5 + num_var6 + num_var7 + num_var8 +
                        factor_var1 + factor_var2 + factor_var3 + factor_var4 ,  
                      data = data )
summary(mod_lineal_noint)

# interaction1 <- num_var1 * num_var3
# interaction2 <- num_var2 * as.numeric(factor_var1)
mod_lineal_siint = lm(response ~ num_var1 + num_var2 + num_var3 + num_var4 + 
                        num_var5 + num_var6 + num_var7 + num_var8 +
                        factor_var1 + factor_var2 + factor_var3 + factor_var4 +
                        num_var1:num_var3 + num_var2:factor_var1,
                      data = data )
summary(mod_lineal_siint) 

# V5: se introducen observaciones atípicas (outliers) y valores faltantes (NA) ----
# Establecer la semilla para reproducibilidad
set.seed(123)

# Función para añadir outliers a una variable numérica
add_outliers <- function(variable, amount, multiplier = 3) {
  # Identificar los índices para los outliers
  indices <- sample(1:length(variable), amount, replace = TRUE)
  # Calcular el valor de los outliers
  outliers <- mean(variable) + multiplier * sd(variable)
  # Añadir outliers a la variable
  variable[indices] <- outliers
  return(variable)
}

# Función para añadir valores faltantes a una variable
add_missing_values <- function(variable, amount) {
  # Identificar los índices para los valores faltantes
  indices <- sample(1:length(variable), amount, replace = TRUE)
  # Añadir valores faltantes a la variable
  variable[indices] <- NA
  return(variable)
}

# Aplicar las funciones a las variables numéricas
num_var1 <- add_outliers(num_var1, 5)
num_var1 <- add_missing_values(num_var1, 5)
# Repetir para las demás variables numéricas...

# Aplicar las funciones a las variables de factor
factor_var1 <- as.character(factor_var1)
factor_var1 <- add_missing_values(factor_var1, 5)
factor_var1 <- factor(factor_var1)
# Repetir para las demás variables de factor...

# Crear el dataframe con las variables modificadas
data <- data.frame(response, num_var1, num_var2, num_var3, num_var4, num_var5, num_var6,
                   num_var7, num_var8, factor_var1, factor_var2, factor_var3, factor_var4,
                   interaction1, interaction2)

# V6: se introduce el efecto de confusión ----
# Establecer la semilla para reproducibilidad
set.seed(123)

# Funciones previamente definidas para añadir outliers y missing values
# ...

# Generar una variable confusora que esté correlacionada con num_var1 y num_var2
confounder <- 0.3 * num_var1 + 0.5 * num_var2 + rnorm(100, mean = 0, sd = 1)

# Ajustar la variable de respuesta para incluir el efecto de la variable confusora
data$response <- data$response + 1.2 * confounder

# Añadir la variable confusora al dataframe
data$confounder <- confounder

# Crear un modelo de regresión lineal incluyendo la variable confusora
model <- lm(response ~ num_var1 + num_var2 + confounder, data = data)

# Resumen del modelo para ver el efecto de la confusión
summary(model)