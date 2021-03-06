#Analiza zbioru danych black friday - przyk�ad transakcji dokonanych w sklepie detalicznym
#Sklep chce lepiej pozna� zachowanie klient�w wobec r�nych produkt�w. 
#W szczeg�lno�ci tutaj problemem jest problem regresji,
#w kt�rym pr�bujemy przewidzie� zmienn� zale�n� (ilo�� zakup�w) za pomoc� informacji
#zawartych w innych zmiennych.
#Problem klasyfikacji mo�e by� r�wnie� rozstrzygni�ty w tym zbiorze danych,
#poniewa� kilka zmiennych ma charakter kategoryczny, a niekt�re
#inne podej�cia to "Przewidywanie wieku konsumenta",
#a nawet "Przewidywanie kategorii zakupionych towar�w". 
#odczyt zbioru danych BlackFraiday.csv
dataBlackFriday = read.csv("C:\\Users\\ZSZ\\Documents\\project_sztuczna_inteligencja\\BlackFriday.csv")
#sprawdzenie struktury naszego zbioru danych
# struktura data.frame 537577 obserwacji (wierszy) i 12 kolumn (zmiennych)
str(dataBlackFriday)
dim(dataBlackFriday)
#selekcja pocz�tkowych wierszy ze zbioru danych
head(dataBlackFriday)
dataBlackFriday$Age[4:5]
#selekcja ostatnich wierszy ze zbioru danych
tail(dataBlackFriday)
#obserwujemy, �e niekt�re obesrwacje zawieraj� brakuj�ce informacje (NA)
#Analiza ka�dej zmiennej pod wzgl�dem statystyki:
#minimum, 1 kwartyl, 2 kwartyl (mediana), �rednia, 3 kwartyl, maximum
#informacje o kwartylach https://mfiles.pl/pl/index.php/Kwartyl
summary(dataBlackFriday)
#######################################################
head(dataBlackFriday)
dataBlackFriday[1:2,11:12]
sum(dataBlackFriday$Purchase)
zak = dataBlackFriday$Purchase
sum(zak)
data = dataBlackFriday[dataBlackFriday$Age!="55+", 12]
head(data)
sum(data$Purchase)
########################################################
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
########################################################
x= group_by(dataBlackFriday, Age)
x
ilosc=summarize(x, ilosc_zakup=n())
ilosc
y=summarize(x, sumowanie= sum(Purchase))  
y
#######################################################
#analiza kwot wydanych na zakupy
zakupy = dataBlackFriday$Purchase
age = dataBlackFriday$Age
boxplot(zakupy, main ="Podsumowanie zakup�w", col ="green")
summary(zakupy)
sum(zakupy)
#suma zakup�w wykonanych przez r�ne grupy wiekowe
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
        x = "przedzia�y wiekowe - Age",
        y = "suma zakup�w",
        title = paste(
            "Sumy zakup�w wykonanych przez r�ne grupy wiekowe"
        
))

####################################################
#ilo�� zakup�w wykonanych przez r�ne grupy wiekowe
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
        x = "przedzia�y wiekowe - Age",
        y = "ilo�� zakup�w",
        title = paste(
            "Ilo�ci zakup�w wykonanych przez r�ne grupy wiekowe"
        
))
#################################################
#ilo�� zakup�w z podzia�em na p�e� wykres s�upkowy
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
        x = "p�e� - Gender",
        y = "ilo�� zakup�w",
        title = paste(
            "Ilo�ci zakup�w z podzia�em na p�e�"
        
))

#######################################
#ilo�� zakup�w z podzia�em na p�e� wykres ko�owy
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
   main="Podzia� klient�w na m�czyzny i kobiety")

########################################################
#inaczej bez sql wykres ko�owy
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
   main="Podzia� klient�w na m�czyzny i kobiety")


########################################################
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
        y = "ilo�� zakup�w",
        title = paste(
            "Ilo�ci zakup�w z podzia�em na kategorie miasta"
        
))

###########################################################
#r�ne testy
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

