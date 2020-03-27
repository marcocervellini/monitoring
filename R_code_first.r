# first lesson 2020_03_25 -  Moniotring Ecosystem
#Intro to R

#we need "quotes" because we use a character element
install.packages("sp")

# we don't need "quotes" because sp is now an object inside R
library(sp)

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

### Multipanell in R: lesson 2020_03_27 - Moniotring Ecosystem

install.packages("sp")
install.packages("GGally")

#The R package 'ggplot2' is a plotting system based on the grammar of graphics. 
#'GGally' extends 'ggplot2' by adding several functions to reduce the complexity
#of combining geometric objects with transformed data. Some of these functions
#include a pairwise plot matrix, a two group pairwise plot matrix, a parallel 
#coordinates plot, a survival plot, and several functions to plot networks.

library (sp) # reqiore (sp) will also do the same job

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

# ~ is made ALT + 0126

pairs(~ cadmium + copper + lead + zinc, data=meuse)

# start from is done by using the comma, that is ","

pairs(meuse[,3:6])

#Excercise: prettify this graph

pairs(meuse[,3:6],pch=15, col="red",cex=2)

#GGally package will prettify the graph

ggpairs(meuse[,3:6])

# We have on the diagonal the distribution frequency, on the x axe we have the values, on the Y axe we have the frequency
# in thi example we have an higher frequency for low value





