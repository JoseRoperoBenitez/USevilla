# Segundo Parcial 20-21

cancermama <- read.csv("~/cancermama.txt", sep="", stringsAsFactors=TRUE)

# 1. Indica las variables predictoras y su naturaleza. Establece los niveles de ----
# referencia de consumo_alcohol en Poco, de edad_cat en Joven y de visita_hop
# en No.

str(cancermama)
summary (cancermama)

cancermama$consumo_alcohol = relevel(cancermama$consumo_alcohol, ref = "Poco")
contrasts (cancermama$consumo_alcohol)

# cancermama$edad_cat = relevel (cancermama$edad_cat, ref ="Joven")
contrasts (cancermama$edad_cat) # ya esta como nos pedian

contrasts(cancermama$visita_hosp) # ya esta como nos pedian

# 2. ¿Existe dependencia entre desarrollar cáncer y consumir alcohol? Realiza la ----
# regresión logística univariante e interpreta el odd-ratio.
attach(cancermama)

reglog02= glm(cancer_mama ~ consumo_alcohol, data = cancermama,
              family = "binomial")
summary (reglog02)
#consumo_alcoholMucho -1.23867 : esto nos indica que el consumir mucho alcohol 
# disminuye la probabilidad de sufrir cancer de mama. Luego a cto mas alcohol
# consumas, mejor para NO sufrir cancer de mama.

exp(coef(reglog02)) #odds ratio <1. 
#0.2897682 la ventaja de ocurrencia de sufrir cancer es 0,28
# mayor en personas que consumen mucho alcohol que las que consumen poco alcohol

exp(confint(ralcohol)) #consumo_alcoholMucho 0.1778176 0.4450467 : odds ratio no es 1

1/ exp(coef(reglog02)) # le hacemos inversa.
# el modelo estima que es 3.451034 veces mas verosmil que poco consumo alcol 
# provoca cancer_mama

#Podemos decir que si existe dependencia entre consumir alcohol y sufrir cancer:
# dependencia negativa.

# 3. Considera la regresión logística que prediga la probabilidad de desarrollar cáncer ----
# mediante las dos covariables “edad_cat” y “consumo_alcohol”. 

reglog03= glm(cancer_mama ~cancermama$consumo_alcohol + edad_cat, data = cancermama,
              family = "binomial")
summary (reglog03)
#edad_catMayor          1.6854 : ser de edad mayor aumenta prob sufrir cancer    
#consumo_alcoholMucho  -0.1252 : consumir mucho alcohol disminuye prob cancer

# Interpret odds ratio ¿que se obs?

exp(coef(reglog03)) 
# edad_catMayor consumo_alcoholMucho 
#5.39477795           0.88228314 
# vemos que la edad aumenta la verosimilitud de tener cancer y ademas tambien 
# aumenta 

1/ exp(coef(reglog03))

# obersamos en primer lugar que baja el 1/odds ratio baja con respecto a antes,
# hay confusion o iteracion

# Plantea y resuelve el contraste fundamental
summary (reglog03)
G = 3931.7 - 3596.9 #null deviance - residual deviance
G

#Necesitare el estadistico G y para ello necesito la rnula:
rnula = glm(cancer_mama~1,cancermama,family = "binomial")
G = deviance(rnula)-deviance(reglog03)
G
#CONTRASTE FDAL: Ho :B_j = 0
pchisq(G,2,lower.tail= F) #pvalor = 1.925487e-73 
1-pchisq (G,2) #2 grados de libertad, chicuadrado(p) p=2
#Rechazo mi contraste fdal: los B_j son distintos de cero, luego ambas variables
# influyen en sufrir cancer de mama o no.

# 4. Vuelve a estudiar la dependencia entre “cancer_mama” y “consumo_alcohol” ----
# pero dividiendo la población entre jóvenes y mayores. ¿Concuerda con el
# apartado anterior? Explica los resultados que observas para justificar tu
# respuesta.

cancerm_jov = cancermama[edad_cat=="Joven",]
summary (cancerm_jov)
cancerm_may = cancermama[edad_cat=="Mayor",]

tb_jov = table (cancerm_jov$cancer_mama, cancerm_jov$consumo_alcohol)
tb_jov

fisher.test(tb_jov) 
#p-value = 0.3887 NO RECHAZO INDEP => ASUMO ODDS RATIO = 1
#Dentro de la poblacion joven, el consumir alcohol no influye
rj = glm(cancer_mama~consumo_alcohol,cancerm_jov,family = "binomial")
summary(rj) #consumo_alcoholMucho  -0.2497
exp(confint(rj)) #consumo_alcoholMucho 0.44606368 1.28033844 => odds ratio = 1


tb_may = table (cancerm_may$cancer_mama, cancerm_may$consumo_alcohol)
tb_may 

fisher.test(tb_may) # aceptamos indep
#p-value = 0.1222 => no rechazo indep => asumo odds ratio = 1

var.test(tb_jov, tb_may) #admitimos igualdad de varianzas

t.test(tb_jov,tb_may, var.equal=TRUE) #no se rechaza igualdad de medias

# La edad no ingluye a priori en tener cancer de mama

#Parece que tenemos la paradoja de simpson, es decir el efecto de confusion


# 5. Considera el modelo de regresión logística utilizando como variables ----
# predictoras: “edad_num”, “densidad_mama”, “visita_hosp” y
# “consumo_alcohol”

reglog04= glm(cancer_mama ~edad_num + densidad_mama + visita_hosp + consumo_alcohol, 
              data = cancermama, family = "binomial")
summary (reglog04)

# a) Aplica un procedimiento de selección de variables mediante un ----
# procedimiento paso a paso e indica las variables con las que te quedas.

rback= step(reglog04, direction= "backward", trace=F)
rback
# se queda con edad_num, densidad_mama, visita_hosp
# menor AIC por 1 que con todas las variables

rboth = step(r, direction = "both",trace = F)
#cancer_mama ~ edad_num + densidad_mama + visita_hosp

# b) Interpreta las odd-ratio ----
exp(coef(rback))
# manteniendo las otras var ctes es 2.055 veces mas verosimil tener cancer mama 
# si visita hosp respect a no(cat ref)
# las otras son cuantitativas:
# es 1.12 veces mas verosimil tener cancer mama cuando la edad numerica
# aumenta en una unidad
# es 1.71 veces mas verosimil tener cancer mama cuando la densidad de la mama
# aumenta en una unidad

1/exp(coef(rback))

# c) ¿Rechazarías que la odd-ratio correspondiente a “visita_hosp” fuera 1? ----
# ¿Qué significado tendría no rechazar en cuanto a la relación entre
# “cancer_mama” y “visita_hosp”?
exp(confint(rback)) #rechazo odds ratio de visitahosp sea 1 pq no pertenece al IC


# d) Plantea y resuelve un test de bondad de ajuste y el contraste fundamental. ----
# se hace como antes
summary(rback)
G =3931.7 - 3370.2
1-pchisq (G,3) #pvalor=0 ==> se rechaza el contrate fundamental

# Tambien el contraste sobre D: contrasta si si el modelo estudiado es el correcto.
pchisq(D,n-p-1, lower.tail = F) #solo cuando no var continuas
anova(rtodas, m.sat, test = "LRT") # Hace lo mismo

# e) Predice la probabilidad de desarrollar cáncer de mama para una mujer de ----
# 40 años que tiene una densidad mamaria de 56 y ha ido al hospital.
reg = glm(cancer_mama ~ edad_num + densidad_mama + visita_hosp,cancermama,family = "binomial")
nuevodato = data.frame(edad_num= 40, densidad_mama = 56 , visita_hosp = "si")

predict(reg,nuevodato,type = "response")  #0.2317024 %

# f) ¿Con cuál de los modelos obtenidos en los apartados 3 y 5.a es preferible ----
# predecir “cancer_mama”?

#Comparo con la proc : el mejor es cuya area bajo la curva sea mas cercacna a 1:

#apartado 3:
reglog03= glm(cancer_mama ~cancermama$consumo_alcohol + edad_cat, data = cancermama,
              family = "binomial")
#apartado 5a:
rback= step(reglog04, direction= "backward", trace=F)

library(pROC)
#Apartado 3:
curvaRoc = roc(cancer_mama, reglog03$fitted.values, plot = TRUE, 
               xlab = "Proporción Falsos Positivos",
               ylab = "Proporción Verdaderos Postivios", col = "orange", lwd = 2,
               print.auc = TRUE, legacy.axes = TRUE)
#AUC = 0.684

#Apartado 5.a)
curvaRoc = roc(cancer_mama, rback$fitted.values, plot = TRUE, 
               xlab = "Proporción Falsos Positivos",
               ylab = "Proporción Verdaderos Postivios", col = "orange", lwd = 2,
               print.auc = TRUE, legacy.axes = TRUE)
#AUC = 0.772 
#Es mejor la del apartado 5c!!




