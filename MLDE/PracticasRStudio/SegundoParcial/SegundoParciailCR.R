#EXAMEN SEGUNDO PARCIAL 21/05/2024
datos <- read.csv("~/prematuroB.csv", stringsAsFactors=TRUE)
head(datos)
summary(datos)

#modelo con todas: ----
modelo1 = glm(datos$Prematuro~.,datos,family = "binomial")
summary(modelo1)
step(modelo1, direction = "backward",  trace = F)

attach(datos)
modelo2 = glm(Prematuro~PesoMadre + Raza + Fumadora + 
                Hipertensa + Infeccion, datos,family = "binomial")
summary(modelo2)

contrasts(Raza)
contrasts(Fumadora)
contrasts(Hipertensa)
contrasts(Infeccion)
nuevodato = data.frame(PesoMadre = 70.0,Raza = "Blanca" ,
                       Fumadora = "No" ,Hipertensa = "No",Infeccion = "No")

predict(modelo2,nuevodato,type = "response") 


rnula = glm(Prematuro~1,datos,family = "binomial")
G1 = deviance(rnula)-deviance(modelo1)
G2 = deviance(rnula)-deviance(modelo2)

#CONTRASTE FDAL: ----
pchisq(G1,7,lower.tail= F)
pchisq(G2,5,lower.tail = F)


library(pROC)
curvaRoc1 = roc(Prematuro, modelo1$fitted.values, plot = TRUE, 
                xlab = "Proporción Falsos Positivos",
                ylab = "Proporción Verdaderos Postivios", col = "orange", lwd = 2,
                print.auc = TRUE, legacy.axes = TRUE)

curvaRoc2 = roc(Prematuro, modelo2$fitted.values, plot = TRUE, 
                xlab = "Proporción Falsos Positivos",
                ylab = "Proporción Verdaderos Postivios", col = "orange", lwd = 2,
                print.auc = TRUE, legacy.axes = TRUE)

contrasts(Prematuro)

medidas = coords(curvaRoc2, ret = c("threshold", "accuracy", "specificity", 
                                    "sensitivity", "youden", "tp", "tn", "fp", "fn" ))
medidas
# medidas = coords(curvaRoc, ret = "all") # obtiene 24 columnas
# medidas = coords(curvaRoc, ret = "all")[,c(1:8,23)] # esto obtiene las 9 anteriores
medidas

# valor umbral de 0.3 ¿cuantos falsos negativos produce la clasificacion ----
# del modelo2?
summary(modelo2)
predicciones = factor(ifelse(modelo2$fitted.values > 0.3, "Si prematuros", "No prematuros"))
table(predicciones)
table(Prematuro,predicciones,dnn=c("observaciones","predicciones"))

# tabla nos devuelve:
# VP  FN
# FP  VN


#modelo lasso con val cruzada ----
library(caret)
set.seed(123)

control <- trainControl(method = "cv", number = 10)
I_VC <- train(Prematuro ~ ., data = datos,
              method = "glm", family = "binomial", trControl = control )
I_VC

X = model.matrix(Prematuro~., datos)[,-1]
y = datos$Prematuro

library(glmnet)

modelo3  = cv.glmnet(X, y, alpha = 1, family = "binomial")
#alpha=1 (Lasso),  alpha=0 (Ridge)

coef(modelo3, s = "lambda.min")
coef(modelo3, s = "lambda.1se")


predict(modelo3, newx = X[10, ], 
        s = modelo3$lambda.min, 
        type = "response")
