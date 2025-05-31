## Apartado a)

proceso_A = c(1.8, 1.2, 1.6, 1.7, 1.1, 1.0)
shapiro.test(proceso_A)

# c() permite crear vectores
#shapiro.test realiza el test de Shapiro-Wilk de normalidad

# Como p-valor es 0.3135 > alpha=0.05 No rechazamos la hipótesis nula de normalidad.
# Concluimos que los datos obtenidos siguen una distr. normal 

## Apartado b)

mean(proceso_A) #media muestral
var(proceso_A) #cuasivarianza muestral

# R tiene otras funciones que nos permiten realizar cálculos
suma=sum(proceso_A)
longitud=length(proceso_A)
suma/longitud

## Apartado c)
(mean(proceso_A) - 1.5) / (sd(proceso_A) / sqrt(6))

qt(0.025, 5)
qt(0.975, 5)

2*pt(-0.719195, 5) #usamos la simetría de la t de Student

mean(proceso_A) + qt(0.025, 5) * sd(proceso_A)/sqrt(6)
mean(proceso_A) + qt(0.975, 5) * sd(proceso_A)/sqrt(6)

# Directamente se puede ver:
t.test(proceso_A, mu = 1.5)

t.test(proceso_A, mu = 1.5, alternative = "less") #less pq nos pregunta si es menor

# Descargar y hacer pdf con latex con Quarto.