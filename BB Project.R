#Code used
library(ggplot2)
library(dplyr)

batting <-read.csv('C:\\Users\\Newton\\Desktop\\Batting.csv')
head(batting)
str(batting)
head(batting$AB)
head(batting$X2B)

batting$BA <- batting$H / batting$AB
tail(batting$BA)

batting$OBP <- (batting$H +batting$BB + batting$HBP)/(batting$AB + batting$BB + batting$HBP + batting$SF)
tail(batting$OBP)

batting$X1B <- batting$H + batting$X2B + batting$X3B + batting$HR

batting$SLG = ((batting$X1B) + (2*batting$X2B) +(3*batting$X3B) + (4*batting$HR))/batting$AB
str(batting)

sal <-read.csv('C:\\Users\\Newton\\Desktop\\Salaries.csv')
summary(sal)
batting <- subset(batting, yearID >= 1985)
summary(batting)
combo <-merge(batting,sal, by = c('playerID','yearID'))
summary(combo)

lostplayers <- subset(combo,playerID %in%c("giambja01","damonjo01","saenzol01"))
lostplayers <- subset(lostplayers, yearID == 2001)
lostplayers <- lostplayers[c("playerID","H","X2B","X3B","HR","OBP","SLG","BA","AB")]
head(lostplayers)


#AB has to be equal or greater than 1469
#OBP has to be equal or greater than 1.091606
#cannot exceed 15 million dollars

avail.players <- filter(combo, yearID == '2002')
head(avail.players)

avail.players <-avail.players[c("playerID","yearID","AB","salary","OBP")]

#Exclude: giambja01","damonjo01","saenzol01


#seem to be allot of players with OBP below zero. need to filter out
avail.players <-filter(avail.players, OBP > 0 )
avail.players <-filter(avail.players,salary < 8000000)
avail.players <-filter(avail.players, AB > 200)

head(avail.players)

#These are the players with best AB scores that fit the qualifications
replacements <-head(avail.players[order(avail.players$AB, decreasing = TRUE),],3)
replacements

sum(replacements$salary)
sum(replacements$AB)
sum(replacements$OBP)
