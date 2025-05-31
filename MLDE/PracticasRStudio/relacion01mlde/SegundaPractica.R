proceso_B = c(2.1, 1.9, 1.5, 2.0, 1.3, 1.4)
shapiro.test(proceso_B) #Podemos asumir normalidad

mean(proceso_B)  #media muestral
var(proceso_B)  #cuasivarianza

t.test(proceso_B, mu = 1.5)
t.test(proceso_B, mu = 1.5, alternative = "less")


# Apartado 1.5)

# Cuando vienen datos apareados hay que tener cuidado pq pueden ser dependientes
# Vamos a intentrar con la diferencia de variables y mediante el test de shapiro
# wilk comprobamos si podemos asumir normalidad

(Incremento = proceso_B - proceso_A) 
shapiro.test(Incremento) #Podemos asumir normalidad

t.test(Incremento) #no es necesario poner mu=0, viene por defecto.

# La DIFERENCIA DE VARIABLES NORMALES DEPENDIENTES NO SIEMPRE ES NORMAL

t.test(Incremento, alternative = "greater")

# Mirar conclusion en papel y apuntes

# Nota: de manera equivalente, con muestras apareadas, puede usarse t.test con
# dos argumentos. Sin embargo, es algo más largo de escribir, y dado además 
# hemos de comprobar previamente la normalidad de la variable Incremento, 
# no merece la pena

t.test(proceso_A, proceso_B, paired = T)
t.test(proceso_A, proceso_B, paired = T, alternative = "greater")


# Apartado 1.6

t.test(Incremento, mu = 2.5)
t.test(Incremento, mu = 2.5, alternative = "less")

# Ojo con los p-valores que nos dan mucha informacion.


## EJERCICIO 2

# Apartado 2.1

# Seguimos los paso de la nota:

# En este caso, está claro por el enunciado que tenemos dos muestras
# independientes. En estos casos: 
# 1. Comprobaremos la normalidad de las muestras mediante shapiro.test()
# 2. Contrastaremos mediante var.test() (test basado en la F de Snedecor) si 
# podemos suponer que las varianzas poblacionales de cada muestra son iguales
# 3. En función de lo anterior, contrastaremos la igualdad de medias en 
# ambas muestras mediante t.test(), especificando el argumento var.equal = F 
# o bien var.equal = T. Es decir, contrastaremos si


# Paso 1
# HAY que TENER EN CUENTA QUE SON INDEPENDIENTES

programa_A = c(0.32, 0.39, 0.28, 0.21, 0.30, 0.29, 0.33, 0.36, 0.40, 0.37)
shapiro.test(programa_A) #Asumimos normalidad

programa_B = c(0.32, 0.25, 0.30, 0.42, 0.40, 0.39, 0.27, 0.24, 0.36, 0.35)
shapiro.test(programa_B) #Asumimos normalidad

# Paso 2
var.test(programa_A, programa_B)

# Paso 3
#Asumimos igualdad de varianzas

t.test(programa_A, programa_B, paired = F, var.equal = T) #OJO CON VAR.EQUAL=T
                                                    # EN paso 2 lo hemos visto.


# Apartado 2.2

(Eficacia_A = programa_A < 0.35) #Ponemos todo entre parentesis para ver el contenido

# es analogo a hacer
# Eficacia_A = programa_A < 0.35
# Eficacia_A

(Eficacia_B = programa_B < 0.35)


(tabla_A = table(Eficacia_A) ) #Para crear una tabla de frecuencia.
(tabla_B = table(Eficacia_B) )

(tabla = rbind(tabla_A, tabla_B) ) #para crear tabla juntando filas 'r'bind

colnames(tabla) = c("No Eficaz","Eficaz")
rownames(tabla) = c("Programa A","Programa B")
tabla  # Para escribir mejor la tabla

tf1 = fisher.test(tabla) # Recomendando para ver igualdad de prob de las be(p)

tf1$p.value # Para que nos de el p_valor


# Apartado 3

programa_C = c(0.39, 0.45, 0.30, 0.42, 0.40, 0.39, 0.37, 0.36, 0.36, 0.40)

Eficacia_C = programa_C < 0.35 

(tabla_C = table(Eficacia_C))

(tabla3 = rbind(tabla, tabla_C) )

rownames(tabla3) = c("Programa A","Programa B", "Programa C")

tabla3

contraste_chi = chisq.test(tabla3) #Mirar la nota de apuntes sobre el warning
contraste_chi

# Cuando hay alguna frecuencia esperada menor que 5, aparece el warning. Esto
# se debe a que algunos investigadores consideran que la aproximación 
# chi-cuadrado no es muy adecuada en estos casos


# En una tabla con las mismas proporciones pero
# mayor tamaño muestral, las frecuencias esperadas
# pueden cambiar

t_experimento = matrix(c(40,50,90,60,50,10), nrow = 3 ) #Para evitar el warning
t_experimento

test_chi_experimento= chisq.test(t_experimento)
test_chi_experimento$expected

#Habiendo realizado el contraste chi cuadrado para la tabla de contigencia de 
# la eficacia de los programas A, B y C, se ha obtenido un p-valor = 0.05411 y 
# un warning de que la aproximación chi-cuadrado podría ser incorrecta (porque 
# hay frecuencias esperadas menores que 5).En consecuencia, técnicamente no
# podemos rechazar que los programas tengan la misma eficacia, es decir, que la 
# variable eficacia sea homogénea en los distintos programas.

# Veamos ahora el contraste entre A y C (por practicar)
(tabla_AC = rbind(tabla_A,tabla_C) )
fisher.test(tabla_AC) #no puedo rechazar la homogeneidad
                      # test de ficher PQ matriz 2x2

# Veamos ahora el contraste entre B y C
(tabla_BC = rbind(tabla_B,tabla_C) )
fisher.test(tabla_BC) #no puedo rechazar la homogeneidad
