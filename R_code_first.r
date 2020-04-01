# first lesson 2020_03_25 -  Moniotring Ecosystem
#Intro to R

#we need "quotes" because we use a character element
install.packages("sp")
install.packages("GGally")
install.packages("ggplot2")

# we don't need "quotes" because sp is now an object inside R
library(sp)
library(GGally)
library(ggplot2)

library (sp) # require (sp) will also do the same job

data(meuse) # there is a dataset available named meuse

#let's see how the meuse dataset is structured:
meuse

#let's look at the first raw of the set (only the first 6 line of the dataset)
head(meuse)

#let's plot two variables
#let's see if the zinc concentration is related to that of copper
#"attach" the dataset to R
# comma let you to put other arguments
attach(meuse)
plot(zinc,copper)
plot(zinc,copper, col="green")
plot(zinc,copper, col="green",pch=19)
# cex a charcter exageration e.g. cex=2 is the double, e.g. cex=0.5 is the half
plot(zinc,copper, col="green",pch=19,cex=2)

### lesson 2020_03_27 - Moniotring Ecosystem, Multipanell in R: 

#The R package 'ggplot2' is a plotting system based on the grammar of graphics. 
#'GGally' extends 'ggplot2' by adding several functions to reduce the complexity
#of combining geometric objects with transformed data. Some of these functions
#include a pairwise plot matrix, a two group pairwise plot matrix, a parallel 
#coordinates plot, a survival plot, and several functions to plot networks.

#dataset in R are called "dataframe"

attach(meuse)

#Exercise: see the name of the variables and plot cadmium versus zinc

names(meuse)
plot(cadmium,zinc)
plot(cadmium,zinc, pch=15, col="red",cex=2)

#Exercise: make all the possible pairways combinations

plot(x,cadmium)
plot(x,zinc)
plot.....

#Plot it is not a good idea for this excerse

#We have to use "pairs"

pairs(meuse)

#reducing the amount of variables , subsetting, 2 ways:

# ~ is made ALT + 126

pairs(~ cadmium + copper + lead + zinc, data=meuse)

# start from is done by using the comma, that is ","

pairs(meuse[,3:6])

#Excercise: prettify this graph

pairs(meuse[,3:6],pch=15, col="red",cex=2)

#GGally package will prettify the graph

ggpairs(meuse[,3:6])

# We have on the diagonal the distribution frequency, on the x axe we have the values, on the Y axe we have the frequency
# in thi example we have an higher frequency for low value

### lesson 2020_04_01 - Moniotring Ecosystem, Spatial in R: 

# R code for spatial view of points

# coordinates

data(meuse)

coordinates(meuse) = ~x+y

plot(meuse)

# with spplot you can visualize a plot with a precise variable and its range of values
spplot(meuse, "zinc")
#the same for copper with a "main" title
spplot(meuse,"copper", main="Copper concentration")
#another way to visualize is the function "bubble"
bubble(meuse, "zinc")
#another way to visualize is the function "bubble"
bubble(meuse, "zinc", main="Zinc concentration")
#Adding the color red to the bubbles
bubble(meuse, "zinc", col="red", main="Zinc concentration")

#Reading the file covid_agg.csv in lab_monit folder in C:/RStudio/lab_monit
setwd("C:/RStudio/lab_monit")
#"head=T" means that you communicate to R that there is a title in the first row(header)
covid<-read.table("covid_agg.csv", head=T)
covid

#with function "attach" we can use directly the data to plot
attach(covid)
plot(country, cases)

#without "attach" you have to write in this way, you have to explain to R how to red the table
plot(covid$country,covid$cases)

#without "attach" you have to write in this way, you have to explain to R how to red the table
plot(covid$country,covid$cases)

plot(country, cases, las=0) #parallel labels

plot(country, cases, las=1) #orizontal labels

plot(country, cases, las=2) #perpendicular labels

plot(country, cases, las=3) #vertical labels

plot(country, cases, las=3, cex.axis=0.5) #half of the previous size labels

#to use ggplot2 you must have, data, variable and type of symbol you want to use





