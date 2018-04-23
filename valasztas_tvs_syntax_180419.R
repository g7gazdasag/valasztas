#FIDESZ LISTÁS EREDMÉNYÉNEK TÖBBVÁLTOZÓS ELEMZÉSE JÁRÁSI ADATOK ALAPJÁN
#Hajdu Miklós, G7.hu
require(readxl)
require(MASS)
require(betas)

df <- read_excel("data-raw/valasztas_tvs_input_180419.xlsx", 
                 sheet = "data_readin")

#Budapestet kihagyjuk - feltételezésünk szerint itt más összefüggések várhatók, mint országosan
df <- df[ which(substr(df$jnev,1,8)!='Budapest'), ]

#Régió változó faktorként történő beállítása, hogy kontrollálhassunk rá a modellben
df$regio.f <- factor(df$regio)
is.factor(df$regio.f)

#Robust regression
model <- robust::lmRob(fidesz_arany ~ isk + jov + vagyon + vallalk + mnrata + kor + kozmunk + regio.f, data = df)
betas.lmr(model)
summary(model)
