#install.packages("rattle")
#library(rattle)
#install.packages("rattle.data")
#library(rattle.data)
#install.packages("gdata")
#library("gdata")
#install.packages("xlsx")
#library("xlsx")
#bibioteka do czytania Excela 
install.packages("readxl")
library("readxl")
rozwody_regresja <- read_excel("C:\\Users\\ZSZ\\Documents\\project_sztuczna_inteligencja\\rozwody_2017_wojewodztwa.xlsx")
rozwody_regresja
head(rozwody_regresja)
tail(rozwody_regresja)
str(rozwody_regresja)
summary(rozwody_regresja)
dim(rozwody_regresja)
rozwody <- rozwody_regresja$rozwody
ludnosc <- rozwody_regresja$ludnosc
rozwody_regresja

str(ludnosc)
summary(rozwody)
summary(ludnosc)
#var(ludnosc)

hist(ludnosc, col="blue")
hist(rozwody)
boxplot(ludnosc, rozwody)  #wykres pude3kowy
boxplot(rozwody)
boxplot(ludnosc)
plot(ludnosc, rozwody)
cor(ludnosc, rozwody)
cor(rozwody,ludnosc)
plot(sort(ludnosc), sort(rozwody))
rozwody_regresja = data.frame(ludnosc, rozwody)
rozwody_regresja
rozwody_regresja[1:4,1:2]
nobs <- nrow(rozwody_regresja)
nobs
train <- sample(nobs, 0.75*nobs)
train
train_rozwody = rozwody_regresja[train,2]
train_rozwody
train_ludnosc = rozwody_regresja[train,1]
train_ludnosc
rozwody_regresja[train,]

model_linowy = lm(train_rozwody ~ train_ludnosc, data =rozwody_regresja[train,])
model_linowy
plot(train_rozwody ~ train_ludnosc, main="wykres regresji")
abline(lm(train_rozwody ~ train_ludnosc), col="blue")

plot(model_linowy, main="wykres regresji")
summary(model_linowy)
print(lm(rozwody ~ ludnosc, data =rozwody_regresja))
predict( lm(train_rozwody ~ train_ludnosc, data =rozwody_regresja))
#par(mfrow=c(2,2));plot(model_liniowy);par(mfrow=c(1,1))
##############################################################
rozwody_regresja2 <- read_excel("C:\\Users\\ZSZ\\Documents\\project_sztuczna_inteligencja\\rozwody_2017_wojewodztwa.xlsx")
rozwody_regresja2 = data.frame(rozwody_regresja2$ludnosc, rozwody_regresja2$rozwody)
rozwody_regresja2
train_rozwody = rozwody_regresja2[1:12,2]
train_rozwody
train_ludnosc = rozwody_regresja2[1:12,1]
train_ludnosc
dane = c(train_ludnosc,train_rozwody)

model_linowy = lm(train_rozwody ~ train_ludnosc, data =dane)
model_linowy
plot(train_rozwody ~ train_ludnosc, main="wykres regresji")
abline(lm(train_rozwody ~ train_ludnosc), col="blue")

plot(model_linowy, main="wykres regresji")
summary(model_linowy)
print(lm(rozwody ~ ludnosc, data =rozwody_regresja))
predict( lm(train_rozwody ~ train_ludnosc, data =rozwody_regresja2[1:12,]))
test_rozwody = rozwody_regresja2[13:16,2]
test_rozwody
test_ludnosc = rozwody_regresja2[13:16,1]
test_ludnosc
#plot(test_rozwody ~ test_ludnosc, main="wykres regresji")
#abline(lm(test_rozwody ~ test_ludnosc), col="blue")


predict( lm(test_rozwody ~ test_ludnosc, data =rozwody_regresja2[13:16,]))

##################################################################
shapiro.test(ludnosc)

pwynik <- shapiro.test(ludnosc)$p.value
ifelse(pwynik <0.05, 
"Odrzucamy hipoteze zerowi na poziomie istotno?ci 0.05", 
"Nie ma podstaw do odrzucenia hipotezy zerowej na poziomie istotno?ci 0.05
-rozklad normalny")
shapiro.test(rozwody)

pwynik <- shapiro.test(rozwody)$p.value
ifelse(pwynik <0.05, 
"Odrzucamy hipoteze zerowi na poziomie istotno?ci 0.05", 
"Nie ma podstaw do odrzucenia hipotezy zerowej na poziomie istotno?ci 0.05
-rozklad normalny")
year <- rep(2014:2017, each=4)
year
quarter <- rep(1:4, 4)
quarter
cpi <- c(162.2, 164.6, 166.5, 166.0,
         + 166.2, 167.0, 168.6, 169.5,
         + 171.0, 172.1, 173.3, 174.0, 
         + 174.1, 174.2, 173.9, 174.1)
cpi
plot(cpi, xaxt="n", ylab="CPI", xlab="")
axis(1, labels=paste(year,quarter,sep="Q"), at=1:16, las=3)

dane<-data.frame(year,cpi)
dane
reg<- lm(cpi~year+quarter , data=dane)

summary(reg)
print(reg)
predict(reg)

 