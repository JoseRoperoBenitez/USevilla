datos <- read.csv("cancermama.txt",sep = "",stringsAsFactors = TRUE)

#El objetivo es analizar y explicar según un modelo logístico la probabilidad de
#desarrollar cáncer de mama en función del resto de variables.


#Apartado 1) Niveles de referencia de consumo_alcohol en Poco, de edad_cat en Joven 
# y de visita_hosp en No.

#Veo primero que la ref de cancer de mama este en 0 en NO sufrirlo
contrasts(datos$cancer_mama)
datos$consumo_alcohol = relevel(datos$consumo_alcohol,ref = "Poco")
contrasts(datos$consumo_alcohol)
datos$edad_cat = relevel(datos$edad_cat, ref = "Joven")
datos$visita_hosp = relevel(datos$visita_hosp, ref = "no")

attach(datos)

#Apartado 2)¿Existe dependencia entre desarrollar cáncer y consumir alcohol?
ralcohol = glm(cancer_mama~consumo_alcohol,datos,family = "binomial")
summary(ralcohol)
#consumo_alcoholMucho -1.23867 : esto nos indica que el consumir mucho alcohol 
# disminuye la probabilidad de sufrir cancer de mama. Luego a cto mas alcohol
# consumas, mejor para NO sufrir cancer de mama.

#Odds ratio:
exp(coef(ralcohol)) #0.2897682 la ventaja de ocurrencia de sufrir cancer es 0,28
# mayor en personas que consumen mucho alcohol que las que consumen poco alcohol

exp(confint(ralcohol)) #consumo_alcoholMucho 0.1778176 0.4450467 : odds ratio no es 1

#Podemos decir que si existe dependencia entre consumir alcohol y sufrir cancer:
# dependencia negativa.

#Apartado 3)Considera la regresión logística que prediga la probabilidad de desarrollar cáncer
#mediante las dos covariables “edad_cat” y “consumo_alcohol”.
r2 = glm(cancer_mama~edad_cat+consumo_alcohol,datos,family = "binomial")
summary(r2)
#edad_catMayor          1.6854 : ser de edad mayor aumenta prob sufrir cancer    
#consumo_alcoholMucho  -0.1252 : consumir mucho alcohol disminuye prob cancer

#Interpreta los odd-ratio ¿Qué efecto observas?
exp(coef(r2))
#edad_catMayor consumo_alcoholMucho 
#5.39477795           0.88228314 

#Plantea y resuelve el contraste fundamental.
#Necesitare el estadistico G y para ello necesito la rnula:
rnula = glm(cancer_mama~1,datos,family = "binomial")
G = deviance(rnula)-deviance(r2)

#CONTRASTE FDAL: Ho :B_j = 0
pchisq(G,2,lower.tail= F) #pvalor = 1.925487e-73 
#Rechazo mi contraste fdal: los B_j son distintos de cero, luego ambas variables
# influyen en sufrir cancer de mama o no.

#Apartado 4)Vuelve a estudiar la dependencia entre “cancer_mama” y 
#“consumo_alcohol” dividiendo la población entre jóvenes y mayores. 

datosjoven = datos[edad_cat == "Joven",]
datosmayor = datos[edad_cat == "Mayor",]

t1 = table(datosjoven$cancer_mama,datosjoven$consumo_alcohol)
fisher.test(t1) #p-value = 0.3887 NO RECHAZO INDEP => ASUMO ODDS RATIO = 1
#Dentro de la poblacion joven, el consumir alcohol no influye

rj = glm(cancer_mama~consumo_alcohol,datosjoven,family = "binomial")
summary(rj) #consumo_alcoholMucho  -0.2497

exp(confint(rj)) #consumo_alcoholMucho 0.44606368 1.28033844 => odds ratio = 1


t2 = table(datosmayor$cancer_mama,datosmayor$consumo_alcohol)
fisher.test(t2) #p-value = 0.1222 => no rechazo indep => asumo odds ratio = 1

rm = glm(cancer_mama~consumo_alcohol,datosmayor,family = "binomial")
summary(rm) #consumo_alcoholMucho  1.28042

exp(confint(rm)) #consumo_alcoholMucho 0.6643153 19.4890133


#Apartado 5)Considera el modelo de regresión logística utilizando como variables
#predictoras: “edad_num”, “densidad_mama”, “visita_hosp” y “consumo_alcohol”.
r = glm(cancer_mama~edad_num+densidad_mama+visita_hosp+consumo_alcohol,datos,family = "binomial")
summary(r)

#Aplica un procedimiento de selección de variables mediante un
#procedimiento paso a paso e indica las variables con las que te quedas.

step(r,direction = "backward",trace = F)
#cancer_mama ~ edad_num + densidad_mama + visita_hosp


step(r, direction = "both",trace = F)
#cancer_mama ~ edad_num + densidad_mama + visita_hosp


#odds ratios:
exp(coef(r))

exp(confint(r))
head(datos)
#Predice la probabilidad de desarrollar cáncer de mama para una mujer de
#40 años que tiene una densidad mamaria de 56 y ha ido al hospital.
reg = glm(cancer_mama ~ edad_num + densidad_mama + visita_hosp,datos,family = "binomial")
nuevodato = data.frame(edad_num= 40, densidad_mama = 56 , visita_hosp = "si")

predict(reg,nuevodato,type = "response") #0.2317024

#¿Con cuál de los modelos obtenidos en los apartados 3 y 5.a es preferible
#predecir “cancer_mama”?

#Comparo con la proc : el mejor es cuya area bajo la curva sea mas cercacna a 1:

#apartado3:
r2 = glm(cancer_mama~edad_cat+consumo_alcohol,datos,family = "binomial")
#apartado5a:
reg = glm(cancer_mama ~ edad_num + densidad_mama + visita_hosp,datos,family = "binomial")

library(pROC)
#Apartado 3:
curvaRoc = roc(cancer_mama, r2$fitted.values, plot = TRUE, 
               xlab = "Proporción Falsos Positivos",
               ylab = "Proporción Verdaderos Postivios", col = "orange", lwd = 2,
               print.auc = TRUE, legacy.axes = TRUE)
#AUC = 0.684
#Apartdo 5a:
curvaRoc = roc(cancer_mama, reg$fitted.values, plot = TRUE, 
               xlab = "Proporción Falsos Positivos",
               ylab = "Proporción Verdaderos Postivios", col = "orange", lwd = 2,
               print.auc = TRUE, legacy.axes = TRUE)
#AUC = 0.772 
#Es mejor la del apartado 5c!!