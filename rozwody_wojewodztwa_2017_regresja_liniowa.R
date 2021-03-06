#instalacja pakietu rattle 
#pakiet rattle s�u�y do analizy danych, data mining, statystyki
#install.packages("rattle")
#library(rattle)
#install.packages("rattle.data")
#library(rattle.data)
#install.packages("gdata")
#library("gdata")
#install.packages("xlsx")
#library("xlsx")
#bibioteka do czytania zbioru danych z Excela 
install.packages("readxl")
library("readxl")
#wczytanie zbioru danych z Excela do zmiennej rozwody_regresja
rozwody_regresja <- read_excel("C:\\Users\\ZSZ\\Documents\\project_sztuczna_inteligencja\\rozwody_2017_wojewodztwa.xlsx")
rozwody_regresja
#pocz�tkowe obserwacje (wiersze) ze zbioru danych
head(rozwody_regresja)
#ko�cowe obserwacje ze zbioru danych rozwody_regresja
tail(rozwody_regresja)
#opis struktury - zbioru danych rozwody_regresja
str(rozwody_regresja)
#podsumowanie zbioru danych kwartyle, �rednia,min, max
summary(rozwody_regresja)
#wymiary zbioru danych
dim(rozwody_regresja)
#pobranie kolumny rozwody
rozwody <- rozwody_regresja$rozwody
rozwody
#pobranie kolumny ludno�� do zmiennej ludnosc
ludnosc <- rozwody_regresja$ludnosc
ludnosc
str(ludnosc)
summary(rozwody)
summary(ludnosc)
#var(ludnosc)
#wykres histogramu ludno�ci
hist(ludnosc, col="blue")
hist(rozwody)
#wykres pude�kowy
boxplot(ludnosc, rozwody)  
boxplot(rozwody)
boxplot(ludnosc)
plot(ludnosc, rozwody)
#korelacja mi�dzy 2 cechami, pokazuje si�� i kierunek zale�no�ci,
#pomi�dzy ludno�ci� a ilosci� rozwod�w
cor(ludnosc, rozwody)
cor(rozwody,ludnosc)
#wykres dwuwymiarowy  ludno�ci - rozwody (u�yte sortowanie) 
plot(sort(ludnosc), sort(rozwody))
#ustawienie zbioru danych rozwody_regresja na typ data.frame
rozwody_regresja <- data.frame(ludnosc, rozwody)
rozwody_regresja
#selekcja zbioru danych 4 wiersze i 2 kolumny
rozwody_regresja[1:4,1:2]
rozwody_regresja[1:4,]
#pobranie ilo�ci wierszy
nobs <- nrow(rozwody_regresja)
nobs
#pobranie pr�bki losowej - 12 pozycji, obserwacji
train <- sample(nobs, 0.75*nobs)
train
train_rozwody = rozwody_regresja[train,2]
train_rozwody
train_ludnosc = rozwody_regresja[train,1]
train_ludnosc
#pr�bka losowa 
rozwody_regresja[train,]
#tworzenie modelu liniowego na pr�bce losowej
model_linowy = lm(train_rozwody ~ train_ludnosc, data =rozwody_regresja[train,])
model_linowy
plot(train_rozwody ~ train_ludnosc, main="wykres regresji")
abline(lm(train_rozwody ~ train_ludnosc), col="blue")
plot(model_linowy, main="wykres regresji")
summary(model_linowy)
print(lm(rozwody ~ ludnosc, data =rozwody_regresja))
#przewidywanie ilo�ci rozwod�w dla 12 wojew�dztw
predict( lm(train_rozwody ~ train_ludnosc, data =rozwody_regresja))
#par(mfrow=c(2,2));plot(model_liniowy);par(mfrow=c(1,1))
#####################################################################
#to samo co wy�ej tylko pr�bka nie jest losowa -12 pierwszych pozycji
rozwody_regresja12 <- read_excel("C:\\Users\\ZSZ\\Documents\\project_sztuczna_inteligencja\\rozwody_2017_wojewodztwa.xlsx")
rozwody_regresja12 <- data.frame(rozwody_regresja12$ludnosc, rozwody_regresja12$rozwody)
rozwody_regresja12
train_rozwody = rozwody_regresja12[1:12,2]
train_rozwody
train_ludnosc = rozwody_regresja12[1:12,1]
train_ludnosc
rozwody_regresja12[1:12,]
dane = c(train_ludnosc,train_rozwody)
dane
model_linowy = lm(train_rozwody ~ train_ludnosc, data =dane)
model_linowy
plot(train_rozwody ~ train_ludnosc, main="wykres regresji")
abline(lm(train_rozwody ~ train_ludnosc), col="blue")
plot(model_linowy, main="wykres regresji")
summary(model_linowy)
#przewidywanie ilo�ci rozwod�w dla 12 wojew�dztw
predict( lm(train_rozwody ~ train_ludnosc, data =rozwody_regresja12[1:12,]))
test_rozwody = rozwody_regresja12[13:16,2]
test_rozwody
test_ludnosc = rozwody_regresja12[13:16,1]
test_ludnosc
#przewidywanie ilo�ci rozwod�w dla 4 wojew�dztw
predict( lm(test_rozwody ~ test_ludnosc, data =rozwody_regresja12[13:16,]))
#####################################################################
#badanie czy cecha ludno�� spe�nia zasad� rozk�adu normalnego
shapiro.test(ludnosc)
pwynik <- shapiro.test(ludnosc)$p.value
ifelse(pwynik <0.05, 
"Odrzucamy hipoteze zerowi na poziomie istotno?ci 0.05", 
"Nie ma podstaw do odrzucenia hipotezy zerowej na poziomie istotno?ci 0.05
-rozklad normalny")
#badanie czy cecha rozwody spe�nia zasad� rozk�adu normalnego
shapiro.test(rozwody)
pwynik <- shapiro.test(rozwody)$p.value
ifelse(pwynik <0.05, 
"Odrzucamy hipoteze zerowi na poziomie istotno?ci 0.05", 
"Nie ma podstaw do odrzucenia hipotezy zerowej na poziomie istotno?ci 0.05
-rozklad normalny")
 