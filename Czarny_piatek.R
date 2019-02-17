#Analiza zbioru danych black friday - przyk³ad transakcji dokonanych w sklepie 
#Zbiór danych to przyk³ad transakcji dokonanych w sklepie detalicznym. 
#Sklep chce lepiej poznaæ zachowanie klientów wobec ró¿nych produktów. 
#W szczególnoœci tutaj problemem jest problem regresji,
#w którym próbujemy przewidzieæ zmienn¹ zale¿n¹ (iloœæ zakupów) za pomoc¹ informacji
#zawartych w innych zmiennych.
#Problem klasyfikacji mo¿e byæ równie¿ rozstrzygniêty w tym zbiorze danych,
# poniewa¿ kilka zmiennych ma charakter kategoryczny, a niektóre
# inne podejœcia to "Przewidywanie wieku konsumenta",
# a nawet "Przewidywanie kategorii zakupionych towarów". 
#odczyt zboiru danych BlackFraiday.csv
dataBlackFriday = read.csv("C:\\Users\\ZSZ\\Documents\\project_sztuczna_inteligencja\\BlackFriday.csv")
#sprawdzenie struktury naszego zbioru danych
# struktura data.frame 537577 obserwacji (wierszy) i 12 kolumn (zmiennych)
str(dataBlackFriday)
dim(dataBlackFriday)
#selekcja pocz¹tkowych wierszy ze zbioru danych
head(dataBlackFriday)
dataBlackFriday$Age[4:5]
#selekcja ostatnich wierszy ze zbioru danych
tail(dataBlackFriday)
#obserwujemy, ¿e niektóre obesrwacje zawieraj¹ brakuj¹ce informacje (NA)
#Analiza ka¿dej zmiennej pod wzglêdem statystyki:
#minimum, 1 kwartyl, 2 kwartyl (mediana), œrednia, 3 kwartyl, maximum
#informacje o kwartylach https://mfiles.pl/pl/index.php/Kwartyl
summary(dataBlackFriday)
#################################
head(dataBlackFriday)
dataBlackFriday[1:2,11:12]
sum(dataBlackFriday$Purchase)
zak = dataBlackFriday$Purchase
sum(zak)
data = dataBlackFriday[dataBlackFriday$Age!="55+", 12]
head(data)
sum(data$Purchase)
##################################
#mydata$Marital_Status = as.factor(mydata$Marital_Status)
#?plot
#pakiet do agregacji danych
install.packages("dplyr")
library(dplyr)
library(magrittr)
library(ggplot2)
#group_by(Age)
#df = c(mydata$Purchase,mydata$Age)
#summary(df)
#?ggplot
###################################################
x= group_by(dataBlackFriday, Age)
x
ilosc=summarize(x, ilosc_zakup=n())
ilosc
y=summarize(x, sumowanie= sum(Purchase))  
y
###################################################
#analiza kwot wydanych na zakupy
zakupy = dataBlackFriday$Purchase
age = dataBlackFriday$Age
boxplot(zakupy, main ="Podsumowanie zakupów", col ="green")
summary(zakupy)
sum(zakupy)
#suma zakupów wykonanych przez ró¿ne grupy wiekowe
# Step 1
dataBlackFriday %>% 
#Step 2
group_by(Age) %>% 
#Step 3
summarise(suma_zakupow = sum(Purchase)) %>% 
#arrange(desc(suma_zakupow))

#Step 4
ggplot(aes(x = Age, y = suma_zakupow, fill = Age)) + 
    geom_bar(stat = "identity") +
    theme_classic() + 
   #ylim(0,3000000)+
labs(
        x = "przedzia³y wiekowe - Age",
        y = "suma zakupów",
        title = paste(
            "Sumy zakupów poczynionych przez ró¿ne grupy wiekowe"
        
))

####################################################
#iloœæ zakupów wykonanych przez ró¿ne grupy wiekowe
# Step 1
dataBlackFriday %>% 
#Step 2
group_by(Age) %>% 
#Step 3
summarise(ilosc_zakupow = n()) %>% 
#arrange(desc(ilosc_zakupow))

#Step 4
ggplot(aes(x = Age, y = ilosc_zakupow, fill = Age)) + 
    geom_bar(stat = "identity") +
    theme_classic() +
    #ylim(0,3000000)+
labs(
        x = "przedzia³y wiekowe - Age",
        y = "iloœæ zakupów",
        title = paste(
            "Iloœci zakupów poczynionych przez ró¿ne grupy wiekowe"
        
))
#################################################
#iloœæ zakupów z podzia³em na p³eæ wykres s³upkowy
#Step 1
dataBlackFriday %>% 
#Step 2
group_by(Gender) %>% 
#Step 3
summarise(ilosc_zakupow_plec = n()) %>% 
#arrange(desc(ilosc_zakupow_plec))

#Step 4
ggplot(aes(x = Gender, y = ilosc_zakupow_plec, fill = Gender)) + 
   geom_bar(stat = "identity") +    
    theme_classic() +
    ylim(0,420000)+
labs(
        x = "p³eæ - Gender",
        y = "iloœæ zakupów",
        title = paste(
            "Iloœci zakupów z podzia³em na p³eæ"
        
))

#######################################
#iloœæ zakupów z podzia³em na p³eæ wykres ko³owy
install.packages("plotrix")
library(plotrix)
gender <- dataBlackFriday$Gender
gender
install.packages("sqldf")
library(sqldf)

FM <-sqldf("SELECT gender as genderFM, COUNT(*) as iloscFM
       FROM dataBlackFriday	 
       GROUP BY gender
       ORDER BY gender")
FM
female <-FM$genderFM[1]
female
male <-FM$genderFM[2]
male
iloscFemale <-FM$iloscFM[1]
iloscFemale 
iloscMale <-FM$iloscFM[2]
iloscMale
valuesFM = c(iloscFemale,iloscMale)
valuesFM/sum(valuesFM)

labelsFM = c(female, male)
#labelsFM = c("FEMALE","MALE")
procent <- round((valuesFM/sum(valuesFM))*100)
labelsFM <- paste(labelsFM,procent) # add percents to labels 
labelsFM <- paste(labelsFM,"%",sep=" ") # ad % to labels 
circle <- pie3D(valuesFM,labels=labelsFM, explode=0.1,
   main="Podzia³ klientów na mê¿czyzny i kobiety")

#######################
#inaczej bez sql wykres ko³owy
gender <- data.frame(dataBlackFriday$Gender)
gender
genderFM <- nrow(gender)
genderFM
genderF <-data.frame(gender[gender!="M"])
genderF
 genderF <- nrow(genderF)
genderF
genderM = genderFM - genderF
genderM
valuesFM = c(genderF,genderM)
valuesFM/sum(valuesFM)

labelsFM = c("FEMALE","MALE")
procent <- round((valuesFM/sum(valuesFM))*100)
labelsFM <- paste(labelsFM,procent) # add percents to labels 
labelsFM <- paste(labelsFM,"%",sep=" ") # ad % to labels 
circle <- pie3D(valuesFM,labels=labelsFM, explode=0.1,
   main="Podzia³ klientów na mê¿czyzny i kobiety")


########################
dataBlackFriday %>% 
#Step 2
group_by(City_Category) %>% 
#Step 3
summarise(ilosc_zakupow_kategoria = n()) %>% 
#arrange(desc(ilosc_zakupow_kategoria))

#Step 4
ggplot(aes(x = City_Category, y = ilosc_zakupow_kategoria, fill = City_Category)) + 
   geom_bar(stat = "identity") +    
    theme_classic() +
    ylim(0,420000)+
labs(
        x = "kategoria miasta - City_Category",
        y = "iloœæ zakupów",
        title = paste(
            "Iloœci zakupów z podzia³em na kategorie miasta"
        
))
dataBlackFriday
names(dataBlackFriday)
str(dataBlackFriday)
is.na(dataBlackFriday)
na = any(is.na(dataBlackFriday)) 
if (na ==T) 
{
    dataBlackFriday$Product_Category_2 = 0
    dataBlackFriday$Product_Category_3 = 0

}
any(is.na(dataBlackFriday))
is.na_replace_0 <- dataBlackFriday$Product_Category_2 
is.na_replace_0 
is.na_replace_0[is.na(is.na_replace_0)]  <-0
is.na_replace_0

