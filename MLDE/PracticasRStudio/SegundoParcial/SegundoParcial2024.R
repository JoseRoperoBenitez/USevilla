datos <- read.csv("~/pulsar.csv", stringsAsFactors=TRUE)

str(datos)
summary(datos)
contrasts(datos$categoria)

attach(datos)

modelo1 = glm(categoria~.,data=datos,family = "binomial")
summary(modelo1)

rback=step(modelo1, direction = "backward",  trace = F)
rback

modelo2 = glm(categoria~ V1 + V2 + V3 + V4 + V5 + V6 + V8, family = "binomial", 
              data = datos)
summary(modelo2)
G = 10959.5 -2616.1
1-pchisq (G,7)
rnula = glm(categoria~1,datos,family = "binomial")
G1 = deviance(rnula)-deviance(modelo2)
pchisq(G1,7,lower.tail= F)


nuevodato = data.frame(V1=0,V2=0,V3=0,V4=0,V5=0,V6=0,V8=0)
100*predict(modelo2,nuevodato,type = "response")

library(pROC)
curvaRoC= roc(categoria, modelo2$fitted.values, plot = TRUE, 
                xlab = "Proporción Falsos Positivos",
                ylab = "Proporción Verdaderos Postivios", col = "orange", lwd = 2,
                print.auc = TRUE, legacy.axes = TRUE)

categoria = relevel(categoria, ref="pulsar")
predicciones = factor(ifelse(modelo2$fitted.values > 0.0893, "pulsar", "IEM"))
table(predicciones)

table(categoria,predicciones,dnn=c("observaciones","predicciones"))

n=1960 +15938 
n
n2=458 + 15801 + 1502 +137
n2

tasa_acierto = (15801 + 1502)/n
tasa_acierto

library(caret)
set.seed(123)

control <- trainControl(method = "cv", number = 10)
I_VC <- train(categoria ~ ., data = datos,
              method = "glm", family = "binomial", trControl = control )
I_VC

X = model.matrix(categoria~., datos)[,-1]
y = datos$categoria

library(glmnet)

modelo3  = cv.glmnet(X, y, alpha = 1, family = "binomial")
#alpha=1 (Lasso),  alpha=0 (Ridge)

coef(modelo3, s = "lambda.min")
