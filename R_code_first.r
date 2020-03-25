#we need "quotes" because we use a character element
install.packages("sp")

# we don't need "quotes" because sp is now an object inside R
library(sp)

data(meuse)

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
