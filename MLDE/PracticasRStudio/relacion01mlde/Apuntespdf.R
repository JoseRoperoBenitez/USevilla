---
  title: "Relación 1 Resuelta"
subtitle: "Prácticas R - Modelos Lineales y Diseño de Experimentos"
#date: "Curso 2022/2023 - Universidad de Sevilla"
format: pdf
author: "Paco Jácome"
---
  
  
  {{< downloadthis pdfs/relacion01mlde.pdf dname=relacion01mlde label="Descargar Enunciados Relación 1 en pdf" icon=file-earmark-pdf type=success >}} Ver: [Enunciados (pdf)](pdfs/relacion01mlde.pdf){target="_blank"}

# Ejercicio 1

**Para analizar la longitud de unos dispositivos electrónicos fabricados por un proceso A, se extrajo una muestra aleatoria de seis dispositivos, obteniéndose los siguientes resultados:**
  
  **1.8, 1.2, 1.6, 1.7, 1.1, 1.0**
  
  **Con el fin de aumentar la longitud media de los dispositivos en 2.5 unidades, se introdujeron los dispositivos anteriores en un nuevo proceso de fabricación, B, obteniéndose los siguientes resultados:**
  
  **2.1, 1.9, 1.5, 2.0, 1.3, 1.4.**
  
  **Use en todos los análisis un nivel de significación del 5%.**
  
  ## 1. ¿Se puede considerar que la longitud de los dispositivos obtenidos con el proceso A sigue una distribución normal?
  
  $$
  \left\{ 
    \begin{align*}
    H_0 & : \text{Proceso A} \sim \mathcal{N}
    \\
    H_1 & : \text{Proceso A} \not \sim \mathcal{N}
    \end{align*}
    \right.
    $$
      
      ```{r}
    proceso_A = c(1.8, 1.2, 1.6, 1.7, 1.1, 1.0)
    shapiro.test(proceso_A)
    ```
    
    Viendo que el $p$-valor es $0.3135 > \alpha$, no rechazamos la hipótesis nula de normalidad.
    Podemos asumir que la longitud de los dispositivos obtenidos con el proceso A sigue una distribución normal.
    
    ## 2. Construye estimadores puntuales de la media $\mu$ y de la varianza $\sigma^2$ de la longitud de los dispositivos obtenidos con el proceso A.
    
    Usaremos los estimadores habituales para los parámetros poblacionales $\mu$ y $\sigma^2$ de distribuciones normales.
    Recordemos que estos parámetros son desconocidos.
    Usaremos pues la media muestral $\bar{x} = \frac{1}{n}\sum_{i = 1}^n x_i$ como estimador de $\mu$ y la cuasivarianza $S_c^2 = \frac{1}{n-1}\sum_{i = 1}^n (x_i - \bar{x})^2$ como estimador de $\sigma^2$:
      
      ```{r}
    mean(proceso_A)
    var(proceso_A)
    ```
    
    ## 3. ¿Se puede considerar que la longitud media de los dispositivos obtenidos con el proceso A es inferior a 1.5 unidades?
    
    Veamos primero si, dada nuestra muestra, podemos considerar que la longitud media pueda ser justamente 1.5 o no.
    Es decir, asumiendo que Proceso A $\sim \mathcal{N}(\mu, \sigma^2)$, siendo estos parámetros desconocidos, realicemos el contraste
    
    $$
      \left\{ 
        \begin{align*}
        H_0 & : \mu = 1.5
        \\
        H_1 & : \mu \neq 1.5
        \end{align*}
        \right.
        $$ Recordemos resultados de Inferencia: Sabemos que si $X \sim \mathcal{N}(\mu, \sigma^2)$, y $n$ variables $X_1, X_2, \ldots, X_n$ independientes e idénticamente distribuidas a $X$ (es decir, una **muestra aleatoria simple** o **m.a.s.** de $X$), se tiene que la **variable aleatoria** media muestral verifica
        
        $$ \bar{X} \sim \mathcal{N}\left(\mu, \frac{\sigma^2}{n}\right) $$ Tipificando,
        
        $$
          \dfrac{\bar{X} - \mu}{ \dfrac{\sigma}{\sqrt{n}}} \sim \mathcal{N}\left(0, 1 \right)
        $$ Si $\sigma$ fuera conocida, podríamos utilizar este resultado para obtener inferencias sobre $\mu$, pero no es el caso.
        Se usa entonces un resultado parecido, pero que no depende de $\sigma$, y que da lugar a la distribución $t$ de Student (de $n-1$ grados de libertad):
          
          $$
          \dfrac{\bar{X} - \mu}{ \dfrac{S_c}{\sqrt{n}}} \sim t_{n-1}
        $$ Esta es una distribución conocida, de la cual puedo calcular sus cuantiles fácilmente con R.
        
        Nótese que, si suponemos cierta la hipótesis nula $H_0$ de que $\mu = 1.5$, entonces tendremos una **realización** de este estadístico.
        Si esta realización es **muy extrema**, es decir, si se encuentra en las colas de distribución, de ser cierta la hipótesis nula habríamos obtenido un resultado muy poco probable.
        
        Si fijamos un valor $\alpha$ como una fracción de probabilidad en los extremos de las colas, rechazaremos la hipótesis nula cuando la realización se encuentre justo en esta región, que se denominará **región crítica**, y que aúna los valores más raros bajo $H_0$.
        
        En consecuencia, la probabilidad de equivocarnos y rechazar $H_0$ siendo verdadera será de $\alpha$, y puede ser tan pequeña como elijamos (aunque, usualmente, se usa $\alpha = 0.05$).
        
        Sin embargo, no sabemos nada a priori sobre la probabilidad de aceptar $H_0$ siendo esta falsa.
        Es por eso que, cuando digamos que rechazamos $H_0$, lo diremos con contundencia, pero cuando no se rechace, solo diremos eso.
        Evitaremos decir "se acepta $H_0$", pues podríamos estar errados.
        
        Volviendo al ejercicio, dada nuestra muestra, obtenemos:
          
          ```{r}
        (mean(proceso_A) - 1.5) / (sd(proceso_A) / sqrt(6))
        ```
        
        La región crítica estará a la izquierda del cuantil $\alpha/2$ y a la derecha del cuantil $1 - \alpha/2$:
          
          ```{r}
        qt(0.025, 5)
        qt(0.975, 5)
        ```
        
        Como $-0.719195$ no se encuentra en la región crítica (no está en las colas), no podemos rechazar $H_0$.
        Por tanto, no podemos asumir otra cosa que $\mu = 1.5$.
        
        Si queremos calcular cuál es la probabilidad de obtener un resultado tanto o más extremo que el que hemos obtenido, estaremos calculando el $p$-valor:
          
          ```{r}
        2*pt(-0.719195, 5) #usamos la simetría de la t de Student
        ```
        
        Cuando esta probabilidad es mayor que $\alpha$, no se rechaza $H_0$ Cuando es menor, entonces sí se rechaza.
        
        Por otro lado, y teniendo en cuenta que se ha usado la simetría de los cuantiles, si de la fórmula de la región crítica despejamos $\mu$,
        
        $$P\left( {- t_{n-1, \, 1- \frac{\alpha}{2}}} \leq \frac{\bar{X} - {\mu}}{\frac{S_c}{\sqrt{n}}} \leq {t_{n-1, \, 1-\frac{\alpha}{2}}} \right) = 1-\alpha.$$ se obtiene el intervalo aleatorio de confianza para $\mu$
          
          $$IC(\mu; 1-\alpha)=\left(\bar{X}\mp t_{n-1, 1-\frac{\alpha}{2}}\frac{S_c}{\sqrt{n}} \;\right)$$ Aplicado a nuestra muestra, será:
          
          ```{r}
        mean(proceso_A) + qt(0.025, 5) * sd(proceso_A)/sqrt(6)
        mean(proceso_A) + qt(0.975, 5) * sd(proceso_A)/sqrt(6)
        ```
        
        Como 1.5 se encuentra dentro del intervalo obtenido para nuestra muestra, no podemos rechazar $H_0$.
        Por el contrario, si se encontrara fuera, la rechazaríamos y nos quedaríamos con la hipótesis alternativa.
        
        Todo esto, de manera resumida, es lo que devuelve R usando una sola línea de código:
          
          ```{r}
        t.test(proceso_A, mu = 1.5)
        t.test(proceso_A, mu = 1.5, alternative = "less")
        ```
        
        No podemos rechazar que $\mu = 1.5$.
        Por tanto, y respondiendo al enunciado, no puedo considerar que $\mu <1.5$.
        
        ## 4. Repite los apartados anteriores para las longitudes de los dispositivos obtenidos con el proceso B.
        
        ```{r}
        proceso_B = c(2.1, 1.9, 1.5, 2.0, 1.3, 1.4)
        shapiro.test(proceso_B) #Podemos asumir normalidad
        
        mean(proceso_B)
        var(proceso_B)
        
        t.test(proceso_B, mu = 1.5)
        t.test(proceso_B, mu = 1.5, alternative = "less")
        ```
        
        No podemos rechazar que $\mu = 1.5$.
        Por tanto, y respondiendo al enunciado, no puedo considerar que $\mu <1.5$.
        
        ## 5. ¿Modifica el proceso B la longitud de los dispositivos fabricados con el proceso A?
        
        Como las muestras son dependientes, hemos de calcular una nueva variable dada por la diferencia de las muestras.
        Habrá que comprobar si podemos asumir normalidad en esta nueva variable, ya que la diferencia de variables normales dependientes no siempre es una variable normal.  
        
        ```{r}
        (Incremento = proceso_B - proceso_A) 
        
        shapiro.test(Incremento) #Podemos asumir normalidad
        
        t.test(Incremento)
        t.test(Incremento, alternative = "greater")
        
        ```
        
        Respondiendo a la pregunta: sí, el proceso B modifica (en media) la longitud de las dispositivos obtenidas mediante el proceso A.
        De hecho, habiendo realizado el contraste unilateral, podemos concluir que el proceso B alarga los dispositivos.
        
        ```{r eval = FALSE}
        # Nota: de manera equivalente, con muestras apareadas, puede usarse t.test con dos argumentos.
        # Sin embargo, es algo más largo de escribir, y dado además hemos de comprobar previamente la 
        # normalidad de la variable Incremento, no merece la pena
        
        t.test(proceso_A, proceso_B, paired = T)
        t.test(proceso_A, proceso_B, paired = T, alternative = "greater")
        ```
        
        ## 6. ¿Se puede considerar que el nuevo dispositivo cumple el requisito para el cual ha sido introducido?
        
        ```{r}
        t.test(Incremento, mu = 2.5)
        t.test(Incremento, mu = 2.5, alternative = "less")
        ```
        
        Si realizamos el contraste bilateral, rechazamos $H_0: \mu = 2.5$.
        
        Si realizamos el contraste unilateral "less", también rechazamos $H_0: \mu = 2.5$.
        En conclusión, asumimos $H_1: \mu < 2.5$.
        
        Por tanto, el proceso B no cumple con su cometido.
        Aunque alarga algo los dispositivos, no los alarga en 2.5 unidades.
        
        # Ejercicio 2
        
        **Se desea analizar el comportamiento de un determinado tipo de programa, A, para detectar errores. Para ello, se aplicó el programa en diez situaciones diferentes, obteniéndose los siguientes tiempos en la detección:**
          
          **0.32, 0.39, 0.28, 0.21, 0.30, 0.29, 0.33, 0.36, 0.40, 0.37**
          
          **Con un nuevo tipo de programa, B, aplicado en otras situaciones, los resultados fueron:**
          
          **0.32, 0.25, 0.30, 0.42, 0.40, 0.39, 0.27, 0.24, 0.36, 0.35**
          
          **Usa en todos los análisis un nivel de significación del 5%.**
          
          ## 1. ¿Qué conclusiones podemos obtener conjuntamente sobre los tiempos de detección de ambos programas?
          
          En este caso, está claro por el enunciado que tenemos dos muestras independientes.
        En estos casos:
          
          1.  Comprobaremos la normalidad de las muestras mediante `shapiro.test()`
        2.  Contrastaremos mediante `var.test()` (test basado en la $F$ de Snedecor) si podemos suponer que las varianzas poblacionales de cada muestra son iguales, es decir, si $$
          \left\{ 
            \begin{align*}
            H_0 & : \sigma_1^2  = \sigma_2^2
            \\
            H_1 & : \sigma_1^2  \neq \sigma_2^2
            \end{align*}
            \right.
            $$
              3.  En función de lo anterior, contrastaremos la igualdad de medias en ambas muestras mediante `t.test()`, especificando el argumento `var.equal = F` o bien `var.equal = T`. Es decir, contrastaremos si $$
              \left\{ 
                \begin{align*}
                H_0 & : \mu_1  = \mu_2
                \\
                H_1 & : \mu_1  \neq \mu_2
                \end{align*}
                \right.
                $$
                  
                  ```{r}
                programa_A = c(0.32, 0.39, 0.28, 0.21, 0.30, 0.29, 0.33, 0.36, 0.40, 0.37)
                shapiro.test(programa_A) #Asumimos normalidad
                
                programa_B = c(0.32, 0.25, 0.30, 0.42, 0.40, 0.39, 0.27, 0.24, 0.36, 0.35)
                shapiro.test(programa_B) #Asumimos normalidad
                
                var.test(programa_A, programa_B)
                #Asumimos igualdad de varianzas
                
                t.test(programa_A, programa_B, paired = F, var.equal = T) #Asumimos igualdad de medias
                
                ```
                
                No tengo razones para decir que haya un programa mejor que otro.
                **En media, parecen funcionar igual.**
                  
                  ## 2. El programa será eficaz si el tiempo de detección es inferior a 0.35 segundos. Compara la eficacia de ambos programas.
                  
                  En este ejercicio, agruparemos los datos en una tabla, y usaremos el test de Fisher.
                
                ```{r}
                (Eficacia_A = programa_A < 0.35)
                (Eficacia_B = programa_B < 0.35)
                
                (tabla_A = table(Eficacia_A) )
                (tabla_B = table(Eficacia_B) )
                
                (tabla = rbind(tabla_A, tabla_B) )
                
                colnames(tabla) = c("No Eficaz","Eficaz")
                rownames(tabla) = c("Programa A","Programa B")
                tabla
                
                fisher.test(tabla)$p.value
                
                
                ```
                
                Usando el test exacto de Fisher, concluimos que ambos programas son igual de eficaces.
                No existen diferencias significativas entre la eficacia de estos programas.
                
                ## 3. En el mercado se dispone de un nuevo programa (Programa C), con las siguientes observaciones muestrales: 0.39, 0.45, 0.30, 0.42, 0.40, 0.39, 0.37, 0.36, 0.36, 0.40. Compara la eficacia de los tres tipos de programas.
                
                En este ejercicio, agruparemos los datos en una tabla, y usaremos el test chi-cuadrado.
                
                ```{r}
                programa_C = c(0.39, 0.45, 0.30, 0.42, 0.40, 0.39, 0.37, 0.36, 0.36, 0.40)
                
                Eficacia_C = programa_C < 0.35 
                
                (tabla_C = table(Eficacia_C))
                
                (tabla3 = rbind(tabla, tabla_C) )
                rownames(tabla3) = c("Programa A","Programa B", "Programa C")
                
                tabla3
                
                contraste_chi = chisq.test(tabla3)
                
                contraste_chi$expected
                # Cuando hay alguna frecuencia esperada menor que 5, 
                # aparece el warning. Esto se debe a que algunos
                # investigadores consideran que la aproximación
                # chi-cuadrado no es muy adecuada en estos casos
                
                # En una tabla con las mismas proporciones pero
                # mayor tamaño muestral, las frecuencias esperadas
                # pueden cambiar
                
                t_experimento = matrix(c(40,50,90,60,50,10), nrow = 3 )
                t_experimento
                
                test_chi_experimento= chisq.test(t_experimento)
                test_chi_experimento$expected
                ```
                
                Habiendo realizado el contraste chi cuadrado para la tabla de contigencia de la eficacia de los programas A, B y C, se ha obtenido un p-valor = 0.05411 y un warning de que la aproximación chi-cuadrado podría ser incorrecta (porque hay frecuencias esperadas menores que 5).
                
                En consecuencia, técnicamente no podemos rechazar que los programas tengan la misma eficacia, es decir, que la variable eficacia sea homogénea en los distintos programas.
                
                Sin embargo, no nos faltan razones para sospechar de la falsedad de H0: el p-valor es muy cercano al nivel de significación, estamos usando un tamaño muestral muy bajo para un test asintótico, no se cumple la condición de las frecuencias esperadas mayores o iguales que 5, y además la proporción muestral de eficacia en el programa C es muy inferior a la de los demás programas.
                
                Por practicar:
                  
                  ```{r}
                (tabla_AC = rbind(tabla_A,tabla_C) )
                
                fisher.test(tabla_AC) #no puedo rechazar la homogeneidad
                
                (tabla_BC = rbind(tabla_B,tabla_C) )
                
                fisher.test(tabla_BC) #no puedo rechazar la homogeneidad
                
                
                ```
                
                De nuevo, y en contra de lo que esperábamos visualmente, no hemos rechazado los contrastes de homogeneidad 2 a 2 A con C y B con C.
                La diferencia en la proporción de eficacia podría venir explicada por el azar, dado que mi muestra es pequeña.
                
                # Ejercicio 3
                
                **La base de datos prostate.txt contiene información sobre diversas variables relacionadas con el cáncer de próstata, siendo la variable `lpsa` la que se desea predecir como una combinación lineal de las restantes.**
                  
                  **Considerar: Nivel de significación del 5%.**
                  
                  ## Lectura de datos
                  
                  {{< downloadthis datos/prostate.txt dname=prostate label="Descarga los datos: prostate.txt" icon=database-fill-down type=info class=data-button id=prostate >}}
                
                ```{r}
                #Escribir aquí la dirección donde se encuentre el archivo. Depende de cada ordenador.
                
                prost <- read.csv("datos/prostate.txt", sep="")
                #prost <- read.csv("C:/Users/chamorro/Downloads/prostate.txt", sep="") #practica
                ```
                
                Sobre los datos:
                  
                  | Variable | Descripción                                          |
                  |----------|------------------------------------------------------|
                  | lcavol   | log del volumen del tumor                            |
                  | lweight  | log del peso del peso de la próstata                 |
                  | age      | edad del paciente                                    |
                  | lbph     | log de la cantidad de hiperplasia prostática benigna |
                  | svi      | invasión vesículas seminales                         |
                  | lcp      | log de la penetración capsular                       |
                  | gleason  | puntuación escala de Gleason                         |
                  | pgg45    | porcentaje de puntuaciones de Gleason de 4 ó 5       |
                  | lpsa     | log del PSA (antígeno prostático)                    |
                  
                  ## 1. Use el comando `summary()` para representar estadísticas básicas sobre las variables.
                  
                  ```{r}
                prost$svi = factor(prost$svi) 
                
                summary(prost)
                ```
                
                ## Apartado extra 1: Acceso a los datos y a las variables. El comando `attach()`.
                
                ```{r}
                #prost$lcavol #accedo a la variable lcavol
                
                prost$lcavol[c(3,5)] #accedo a las coordenadas 3 y 5 
                prost[,1] #prost$lcavol porque es la primera columna
                #prost[1] #igual
                
                prost[2,] #segunda fila de los datos: son los datos del segundo hombre
                
                prost[97, c(1,9)] #de la observación 97, las variables 1 y 9
                
                #lcavol #da error
                
                attach(prost) #Consejo: hacerlo después de modificar los datos
                head(lcavol) #ya no da error
                ```
                
                ## Apartado extra 2: Tablas de frecuencia. Histogramas. Diagrama de cajas y bigotes. El comando `plot()`.
                
                Tablas de frecuencia:
                  
                  ```{r}
                table(age)
                min(age)
                max(age)
                
                seq(40,80,5) #es igualque c(40,45,50,55,60,65,70,75,80)
                
                (intervalos = cut(age, breaks = seq(40,80,10)))
                
                FrecAbs = table(intervalos)
                FrecRel = prop.table(FrecAbs)
                AbsAcum = cumsum(FrecAbs)
                RelAcum = cumsum(FrecRel)
                
                (tabla = cbind(FrecAbs, FrecRel, AbsAcum, RelAcum))
                ```
                
                Histograma:
                  
                  ```{r}
                hist(age, breaks = seq(40,80,10))#representa la frecuencia absoluta
                hist(age, breaks = c(40,50,70,80))#representa la densidad de frecuencia relativa
                ```
                
                Gráfico de cajas y bigotes:
                  
                  ```{r}
                boxplot(age)
                ```
                
                Coeficientes de asimetría y de curtosis:
                  
                  ```{r}
                #install.packages("fBasics")
                library(fBasics)
                
                skewness(age) #Coeficiente de asimetría
                kurtosis(age) #Coeficiente de curtosis
                ```
                
                La función plot:
                  
                  ```{r}
                plot(lcavol,lpsa)
                plot(prost[-c(5,6)])
                
                ```
                
                ## 2. Use el comando `cor()` para estudiar las correlaciones entre las variables, e identifique las dos variables más fuertemente correladas.
                
                ```{r}
                cor(lcavol, lpsa)
                cor(prost[-5])
                
                heatmap(abs(cor(prost[-5])), scale = "none")
                ```
                
                Las variables más fuertemente correladas son `gleason` con `pgg45` (0.75) y `lcavol` con psa (0.73).
                
                ## 3. ¿Qué puede decir sobre la normalidad de las variables? Use los comandos `qqnorm()` y `shapiro.test()`.
                
                Lo vemos para lpsa, svi, pgg45.
                
                ```{r}
                qqnorm(lpsa)
                qqline(lpsa, col = "red")
                shapiro.test(lpsa)
                ```
                
                Viendo el gráfico QQnorm y habiendo realizado el test de Shapiro-Wilk, no rechazamos la normalidad de `lpsa`.
                
                ```{r}
                #qqnorm(svi) #No puedo hacerlo para factores
                #shapiro.test(svi) #Mismo problema
                
                qqnorm(pgg45)
                qqline(pgg45,col = "red")
                shapiro.test(pgg45)
                ```
                
                Rechazamos la normalidad de `pgg45`.
                
                ## 4. Use el comando `lm()` para obtener un modelo lineal de predicción de la variable `lpsa` a partir de las otras.
                
                Primero usaremos solo `lcavol` como variable explicativa y veremos la representación gráfica de la recta de regresión.
                Después usaremos todas las variables explicativas.
                
                ```{r}
                reg1 = lm(lpsa ~ lcavol)
                
                plot(lcavol, lpsa)
                abline(reg1, col ="red" )
                
                cor(lpsa,lcavol) #coef.de correlación lineal
                cor(lpsa,lcavol)^2 #coef. de determinación
                
                summary(reg1)
                
                ########
                
                lm(lpsa ~ ., data = prost) #hace la regresión sobre todas las variables explicativas de prost
                
                lm(lpsa ~ svi)
                
                
                #explicación svi en la regresión
                ```
                
                ## 5. Use el comando `predict()` para evaluar las predicciones de `lpsa` sobre el conjunto de datos anterior.
                
                Por simplicidad, lo haremos con el modelo que usa únicamente `lcavol` como variable explicativa.
                Usaremos su valor medio.
                
                ```{r}
                #Predicción cuando lcavol vale su valor medio
                mean(lcavol)
                
                #1.5073       0.7193  
                reg1$coefficients
                
                
                1.5073  +  0.7193*1.35001 #2.478...
                
                
                predict(reg1, newdata = data.frame(lcavol = c(1.35,2))) 
                ```
                
                ## 6. Represente los residuos frente a `lpsa`.
                
                ```{r}
                # Vector de residuos a mano
                lpsa - (1.5072975 +  0.7193204*lcavol )
                lpsa - reg1$fitted.values
                
                reg1$residuals #forma sencilla
                
                plot(reg1$residuals, lpsa)
                ```
                
                Vemos que hay una dependencia directa entre `lpsa` y los residuos: si una crece, la otra también, y viceversa (ojo,los residuos tienen signo).
                
                Observamos que cuando `lpsa` toma valores muy grandes o muy pequeños, los residuos crecen en valor absoluto.
                
                ## 7. ¿Se puede considerar que la media de la variable `lpsa` es de 4 unidades?
                
                ```{r}
                shapiro.test(lpsa)
                t.test(lpsa, mu = 4, alternative = "less")
                ```
                
                Rechazo la hipótesis nula del contraste: la media de `lpsa` no es 4.
                De hecho, realizando el contraste `"less"`, concluimos que la verdadera media de `lpsa` es menor que 4.
                
                ## 8. Se considera que una persona es “Joven” si su edad (`age`) es menor o igual a 65 años y “Mayor” a partir de los 65 años. Analizar en cuál de los dos grupos de edad la variable `lpsa` es mayor.
                
                **Indicación:** Para seleccionar los subgrupos de individuos utilizar:
                  
                  ```{r}
                lpsajoven = prost[prost$age <= 65,"lpsa"] #selecciona los valores de lpsa en individuos jóvenes
                lpsamayor = prost[prost$age > 65,"lpsa"]  #selecciona los valores de lpsa en individuos mayores
                
                summary(lpsajoven)
                summary(lpsamayor)
                
                boxplot(lpsajoven, lpsamayor)
                
                #summary, boxplot.
                
                #summary(lm(lpsa~edad))
                ```
                
                Parece que las personas mayores de la muestra tienen un mayor `lpsa`.
                
                Vamos a contrastar si la media de `lpsa` es mayor en las personas ancianas que en las jóvenes, realizando los contrastes pertinentes.
                
                ```{r}
                shapiro.test(lpsajoven) #se acepta normalidad
                shapiro.test(lpsamayor) #se acepta normalidad
                
                # Tenemos dos muestras que asumimos normales e independientes
                
                var.test(lpsajoven, lpsamayor) #asumimos igualdad de varianzas
                
                t.test(lpsajoven, lpsamayor, var.equal = TRUE, alternative = "less")
                ```
                
                Rechazo la hipótesis nula de que las medias sean iguales en ambos grupos de personas.
                Es más, concluimos que los jóvenes tienen, en media, menos `lpsa` que las personas mayores.
                
                ## 9. Se sospecha que un hombre desarrollará cáncer si `lpsa` es como mínimo 4. ¿El grupo de Jóvenes y Mayores tienen la misma posibilidad de desarrollar cáncer?
                
                **Indicación:** `cancerjoven = lpsajoven>=4` y `cancermayor = lpsamayor>=4`.
                
                ```{r}
                cancerjoven = lpsajoven>=4
                cancermayor = lpsamayor>=4
                
                tablajoven = table(cancerjoven)
                tablamayor = table(cancermayor)
                
                tablacancer = rbind(tablajoven, tablamayor)
                tablacancer
                
                fisher.test(tablacancer)
                ```
                
                A pesar de observar una mayor proporcion de `lpsa` $\geq4$ en nuestra en la gente mayor que en la joven, con el test de Fisher no podemos rechazar la igualdad de proporciones de `lpsa` $\geq 4$ en ambos grupos a nivel poblacional.
                
                **Nota:** más sobre este conjunto de datos en <https://hastie.su.domains/ElemStatLearn/printings/ESLII_print12_toc.pdf>.
                Este es uno de los libros de referencia de la asignatura, y es de descarga gratuita.