
#we need "quotes" because we use a character element
install.packages("sp")
install.packages("GGally")
install.packages("ggplot2")
install.packages("spatstat")
install.packages("rgdal")
install.packages("raster")
install.packages("RStoolbox")
install.packages("rasterdiv")
install.packages("rasterVis")

# if install.packages don't work for ggplot2 you can install the devtools package

install.packages("devtools")
devtools::install_github("tidyverse/ggplot2")

# we don't need "quotes" because sp is now an object inside R
library(sp)
library(GGally)
library(ggplot2)
library(spatstat)
library(rgdal)
library(raster)
library(RStoolbox)
library(rasterdiv)
library(rasterVis)

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

#####################################################################################
### 2nd lesson 2020_03_27 - Moniotring Ecosystem, Multipanell in R: 

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

#####################################################################################################################
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


# save the .RData under the menu File  - you should write also the name save.image(xxxx.RData)
# In this way you can open a new script reloading all your data
save.image()

###########################################################################################################
### 4th lesson 2020_04_03 - Moniotring Ecosystem, Spatial in R (second part): 

setwd("C:/RStudio/lab_monit")
# here you can load all your data previously saved with save.image()
load(".Rdata")
#list all your onjects
ls()
library(ggplot2)

# loading the dataframe "mpg" contained in "ggplot2" package
data(mpg)
head(mpg)
names(mpg)

#key components of GGplot2 package: data, aes, geometry
#geometry as point
ggplot(mpg,aes(x=displ,y=hwy)) + geom_point
#geometry as line
ggplot(mpg,aes(x=displ,y=hwy)) + geom_line()
#geometry as polygons
ggplot(mpg,aes(x=displ,y=hwy)) + geom_polygon(

#Let's apply GGplot2 to "covid" dataframe
head(covid)  
#with "size" you can emphasize the size if a certain variable depending on its range value, in this case the va "cases"
ggplot(covid, aes(x=lon, y=lat, size=cases)) + geom_point()

#point pattern analysis
#plotting with package "spatstat"
covids <- ppp(lon, lat, c(-180,180), c(-90,90))
d <- density(covids)
plot(d)
points(covids)
  
###########################################################################################################
### 5th lesson 2020_04_03 - Moniotring Ecosystem, Spatial in R (coastline): 

setwd("C:/RStudio/lab_monit")
#Let's input vector lines (x0y0,x1y1,...)
coastlines <-  readOGR("ne_10m_coastline.shp")
coastlines
plot(coastlines, add=T)

#change the colours and make the graph beautiful
cl <- colorRampPalette(c("yellow","orange","red")) (100)
plot(d, col=cl)
points(covids)
plot(coastlines, add=T, col="yellow")

# Exercise: plot della mappa di densità con una nuova colorazione, e aggiunta delle coastlines
clr <- colorRampPalette(c("blue","light blue","light green","yellow")) (100)
plot(d, col=clr)
points(covids)
plot(d, col=clr, main="Densities of covid-19")
plot(coastlines, add=T, col="black")
  
#export in PDF
pdf("covid_density.pdf")
clr <- colorRampPalette(c("light green", "yellow","orange","violet")) (100)
plot(d, col=clr, main="Densities of covid-19")
points(covids)
plot(coastlines, add=T)
dev.off()

##########################################################################################################################
#### 6th lesson 2020_04_15 - Monitoring Ecosystem, Dispersal_Multivariare in R (to be compiled see folder 4 in Rstudio document):



######################################################################################################################################################################
#### 7th lesson 2020_04_17 - Monitoring Ecosystem, RS in R: 

setwd("C:/RStudio/lab_monit")

###############################################################################################################################################################################
#### 8th lesson 2020_04_22 - Monitoring Ecosystem, RS in R: 

p224r63_2011<-brick("p224r63_2011_masked.grd")
plot(p224r63_2011)

cl <- colorRampPalette(c('black','grey','light grey'))(100)
plot(p224r63_2011, col=cl)

#Band colours

#B1=Blue (B)
#B2=Green (G)
#B3=Red (R)
#B4=Near Infrared (NIR)

#multiframe of different plots
#2rows and 2columns
par(mfrow=c(2,2))
#B1
clb <- colorRampPalette(c('dark blue','blue','light blue'))(100)
plot(p224r63_2011$B1_sre, col=clb)
#B2
clg <- colorRampPalette(c('dark green','green','light green'))(100)
plot(p224r63_2011$B2_sre, col=clg)
#B3
clr <- colorRampPalette(c('dark red','red','pink'))(100)
plot(p224r63_2011$B3_sre, col=clr)
#B4
clnir <- colorRampPalette(c('red','orange','yellow'))(100)
plot(p224r63_2011$B4_sre, col=clnir)

dev.off

# How to create a human visible image
# Associate the Landsat band to the RGB system of the computers
#plotRGB

par(mfrow=c(1,1))# why I have to explain this to R even of I used dev.off?
plotRGB(p224r63_2011,r=3,g=2,b=1, stretch="Lin")
plotRGB(p224r63_2011,r=4,g=3,b=2, stretch="Lin")

#exercise, put the NIr on the top of g component
plotRGB(p224r63_2011,r=3,g=4,b=2, stretch="Lin")

#exercise, put the NIr on the top of b component
plotRGB(p224r63_2011,r=3,g=2,b=4, stretch="Lin")

#4rows and 1column
par(mfrow=c(4,1))

dev.off

# How to create a human visible image
# Associate the Landsat band to the RGB system of the computers
#plotRGB

par(mfrow=c(1,1))# why I have to explain this to R even of I used dev.off?
plotRGB(p224r63_2011,r=3,g=2,b=1, stretch="Lin")
plotRGB(p224r63_2011,r=4,g=3,b=2, stretch="Lin")

#exercise, put the NIr on the top of g component
plotRGB(p224r63_2011,r=3,g=4,b=2, stretch="Lin")

#exercise, put the NIr on the top of b component
plotRGB(p224r63_2011,r=3,g=2,b=4, stretch="Lin")

save.image("R_code_rs.Rdata")
rm(list = ls())

###############################################################################################################################################################################
#### 9th lesson 2020_04_24 - Monitoring Ecosystem, RS in R - comparing 1988Vs2011: 

setwd("C:/RStudio/lab_monit")
load("R_code_rs.Rdata")
ls()
p224r63_1988<-brick("p224r63_1988_masked.grd")
plot(p224r63_1988)
par(mfrow=c(2,1))
# putting on the top the blue band in R of RGB
plotRGB(p224r63_1988,r=3,g=2,b=1, stretch="Lin")
plotRGB(p224r63_2011,r=3,g=2,b=1, stretch="Lin")

# False colours RGB 432 (in this way we can associate the reflection of vegetation to the R band)
plotRGB(p224r63_1988,r=4,g=3,b=2, stretch="Lin")
plotRGB(p224r63_2011,r=4,g=3,b=2, stretch="Lin")

# Enhance the noise!
plotRGB(p224r63_1988,r=4,g=3,b=2, stretch="hist")
plotRGB(p224r63_2011,r=4,g=3,b=2, stretch="hist")

#DVI for 2011

dvi_2011<-p224r63_2011$B4_sre - p224r63_2011$B3_sre
cl <- colorRampPalette(c("darkorchid3","light blue","lightpink4"))(100) 
plot(dvi_2011, col=cl)

#DVI for 1988

dvi_1988<-p224r63_1988$B4_sre - p224r63_1988$B3_sre
cl <- colorRampPalette(c("darkorchid3","light blue","lightpink4"))(100) 
plot(dvi_1988, col=cl)

#DVI difference

DVI_diff<-dvi_2011 - dvi_1988
plot(DVI_diff)

#Changing the grain of our images
#A factor of 10 means10 times bigger, so we are passing from 30m pxel to 300m pixel res

p224r63_2011_res10<-aggregate(p224r63_2011, fact=10)
p224r63_2011_res100<-aggregate(p224r63_2011, fact=100)

# compare the same image at different resolution - white pixel are no more visible
par(mfrow=c(3,1))
plotRGB(p224r63_2011,r=4,g=3,b=2, stretch="Lin")
plotRGB(p224r63_2011_res10,r=4,g=3,b=2, stretch="Lin")
plotRGB(p224r63_2011_res100,r=4,g=3,b=2, stretch="Lin")





