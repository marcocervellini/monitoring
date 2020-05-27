
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
install.packages("sf")


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
library(sf)

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


###############################################################################################################################################################################
#### 10th lesson 2020_04_24 - Ecosystem Services, RS in R : 

data(copNDVI)
plot(copNDVI)
copNDVI <- reclassify(copNDVI, cbind(253:255, NA))
levelplot(copNDVI)
copNDVI10<-aggregate(copNDVI, fact=10)
levelplot(copNDVI10)
copNDVI100<-aggregate(copNDVI, fact=100)
levelplot(copNDVI100)

# DVI and deforestation

defor1 <- brick("defor1_.jpg")
defor2 <- brick("defor2_.jpg")

## defor1
## band1: NIR, defor1_.1 (see "names" if you script "defor1")
## band2: red, defor1_.2
## band3: green

# plotRGB(defor1, r=1, g=2, b=3, strech="Lin")
# plotRGB(defor2, r=1, g=2, b=3, stretch="Lin")

par(mfrow=c(1,2))
plotRGB(defor1, r=1, g=2, b=3, stretch="Lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="Lin")

dvi1<- defor1$defor1_.1 - defor1$defor1_.2

## defor2
## band1: NIR, defor2_.1 (see "names" if you script "defor1")
## band2: red, defor2_.2
## band3: green

dvi2<- defor2$defor2_.1 - defor2$defor2_.2

cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # specifying a color scheme
par(mfrow=c(1,2))
plot(dvi1, col=cl)
plot(dvi2, col=cl)

difdvi <- dvi1 - dvi2

dev.off()
cld <- colorRampPalette(c('blue','white','red'))(100) 
plot(difdvi, col=cld)
# all the red part has loss in vegetation
hist(difdvi)
# a lot of values over "0" so a great amount of lost vegetation and biomass

  
###############################################################################################################################################################################
#### 11th lesson 2020_05_06 - Raster PCA in R :

library(vegan)
library(RStoolbox)
library(raster)
library(ggplot2)


setwd("C:/RStudio/lab_monit")
p224r63_2011 <- brick("p224r63_2011_masked.grd")
plot(p224r63_2011)

#b1: blue
#b2: green
#b3: red
#b4: NIR
#b5: SWIR
#b6: thermal infrared
#b7: SWIR
#b8: panchromatic

plotRGB(p224r63_2011, r=5, g=4, b=3, stretch="Lin")
ggRGB(p224r63_2011,5,4,3)

p224r63_1988 <- brick("p224r63_1988_masked.grd")
plotRGB(p224r63_1988, r=5, g=4, b=3, stretch="Lin")

par(mfrow=c(1,2))
plotRGB(p224r63_1988, r=5, g=4, b=3, stretch="Lin")
plotRGB(p224r63_2011, r=5, g=4, b=3, stretch="Lin")

names(p224r63_2011)
plot(p224r63_2011$B1_sre, p224r63_2011$B3_sre)

dev.off()

# decrease the resolution
#2011

p224r63_2011_res <- aggregate(p224r63_2011, fact=10)

p224r63_2011_pca <- rasterPCA(p224r63_2011_res)


plot(p224r63_2011_pca$map)


cl <- colorRampPalette(c('dark grey','grey','light grey'))(100)

plot(p224r63_2011_pca$map,col=cl)

summary(p224r63_2011_pca$model)

pairs(p224r63_2011)

plotRGB(p224r63_2011_pca$map, r=1, g=2, b=3, stretch="Lin")

# 1988

p224r63_1988_res <- aggregate(p224r63_1988, fact=10)
p224r63_1988_pca <- rasterPCA(p224r63_1988_res) 
plot(p224r63_1988_pca$map, col=cl)

summary(p224r63_1988_pca$model)

pairs(p224r63_1988)

# difference

difpca <- p224r63_2011_pca$map - p224r63_1988_pca$map

plot(difpca)

cldif <- colorRampPalette(c('blue','black','yellow'))(100)

plot(difpca$PC1,col=cldif)

###############################################################################################################################################################################
#### 12th lesson 2020_05_08 - faPAR in R : 

library(raster)
library(rasterVis)
library(rasterdiv)

plot(copNDVI)

copNDVI <- reclassify(copNDVI, cbind(253:255, NA))
levelplot(copNDVI)
  
setwd("C:/RStudio/lab_monit")

faPAR10 <- raster("faPAR10.tif")
levelplot(faPAR10)

pdf("copNDVI.pdf")
levelplot(copNDVI)
dev.off()

pdf("faPAR.pdf")
levelplot(faPAR10)

save.image("faPAR.RData")
dev.off()

###############################################################################################################################################################################
#### 13th lesson 2020_05_13 - Toybits in R : 
# plot seems not to work....
library(raster)

toy <- raster(ncol=2, nrow=2, xmn=1, xmx=2, ymn=1, ymx=2)
toy
values(toy) <- c(1.13,1.44,1.55,3.4)

plot(toy)
text(toy, digits=2)

toy2bits <- stretch(toy,minv=0,maxv=3)

storage.mode(toy2bits[]) = "integer" #to make shure the images are stored as integer values

plot(toy2bits)
text(toy2bits, digits=2)

toy4bits <- stretch(toy,minv=0,maxv=15)
storage.mode(toy4bits[]) = "integer"

plot(toy4bits)
text(toy4bits, digits=2)

toy8bits <- stretch(toy,minv=0,maxv=255)
storage.mode(toy8bits[]) = "integer"

plot(toy8bits)
text(toy8bits, digits=2)

#plot alltogether

par(mfrow=c(1,4))

plot(toy)
text(toy, digits=2)

plot(toy2bits)
text(toy2bits, digits=2)

plot(toy4bits)
text(toy4bits, digits=2)

plot(toy8bits)
text(toy8bits, digits=2)

dev.off()


library(rasterdiv)

rm(list = ls())

plot(copNDVI)

load("faPAR.RData")

writeRaster(copNDVI, "copNDVI.tif")
  
###############################################################################################################################################################################
#### 14th lesson 2020_05_15 -  : No lesson

###############################################################################################################################################################################
#### 15th lesson 2020_05_20 - PAR and DVI - linear regression in R : 

library(raster)
library(rasterdiv)
library(sf)

# example of linear regression
erosion <- c(12, 14, 16, 24, 26, 40, 55, 67)
hm <- c(30, 100, 150, 200, 260, 340, 460, 600)
plot(erosion, hm, col="red", pch=19,cex=2, xlab="erosion", ylab="heavy metals")
model1 <- lm(hm  ~ erosion)
summary(model1)
abline(model1)

setwd("C:/RStudio/lab_monit")
faPAR10 <- raster("faPAR10.tif")
plot(faPAR10)

# removing water data
copNDVI <- reclassify(copNDVI, cbind(253:255, NA))
#number of cell in the raster, you need just to write the name
copNDVI
plot(copNDVI)

# to call st_* functions
random.points <- function(x,n) # x=raster file and n= number of cells
{
  lin <- rasterToContour(is.na(x))
  pol <- as(st_union(st_polygonize(st_as_sf(lin))), 'Spatial') # st_union to dissolve geometries
  pts <- spsample(pol[1,], n, type = 'random')
}

pts <- random.points(faPAR10,1000)
plot(pts)
#perchè si vedono solo i 1000 punti random e non il raster sotto????

#extracting the random points for the two raster
copNDVIp <- extract(copNDVI,pts)
faPAR10p <- extract(faPAR10,pts)

# observe the values
copNDVIp
faPAR10p

model2 <- lm(faPAR10p ~ copNDVIp)
summary(model2)
model2

plot(copNDVIp,faPAR10p, col="green", xlab="biomass", ylab="photosynthesis")
abline(model2, col="red")
  
  
###############################################################################################################################################################################
#### 16th lesson 2020_05_22 - Standard deviation using raster in R - moving windows (I don't have access to the file snt_r10) : 
    
install.packages("raster")
install.packages("rstoolbox")
library(raster)
library(rstoolbox)

snt <- brick("snt_r10.tif")
plot(snt)
plotRGB(snt,3,2,1, stretch="lin")
#Infrared on the top of the red to observe better vegetation
plotRGB(snt,4,3,2, stretch="lin")
pairs(snt)
sntpca <- rasterPCA(snt)
sntpca
summary(sntpca$model)
#70% of variance explained bi the PCA1
plot(sntpca$map)
# a graphical output to observe the variety of the pixels
plotRGB(sntpca$map, 1, 2, 3, stretch="lin")
  
#set the moving windows
# the matrix is built with values "1" not to impact on the calculation
window <- matrix(1, nrow = 5, ncol = 5)
window
#standard deviation in a map with the PCA1
sd_snt <- focal(sntpca$map$PC1, w=window, fun=sd)
cl <- colorRampPalette(c('dark blue','green','orange','red'))(100) # 
plot(sd_snt, col=cl)

par(mfrow=c(1,2))
plotRGB(snt,4,3,2, stretch="lin", main="original image") 
plot(sd_snt, col=cl, main="diversity")
#Using the moving windows and funcrion="standard deviation"
#we are going to highlight the differences between border 
#(remember that the result of the moving windows is graphically
#represented by the value of standard deviation in the focal cental pixel)
  
###############################################################################################################################################################################
#### 17th lesson 2020_05_27 - Standard deviation using raster in R - moving windows (I don't have access to the file cladonia____) : 
  
library(raster)
library(rstoolbox)

clad <- brick("cladonia_stellaris_calaita.JPG")
plotRGB(clad, 1,2,3, stretch="lin")
cladpca <- rasterPCA(clad)
cladpca
summary(cladpca)
plotRGB(cladpca$map, 1, 2, 3, stretch="lin")
# "1" doesn't impact the calculation, but why????
window <- matrix(1, nrow = 3, ncol = 3)
window
#To understand $map and $PC! see results running cladpca
sd_clad <- focal(cladpca$map$PC1, w=window, fun=sd)
# To accelerate we can aggregate and then run the movingwindow with the new aggregated file
PC1_agg <- aggregate(cladpca$map$PC1, fact=10)
sd_clad <- focal(PC1_agg, w=window, fun=sd)
par(mfrow=c(1,2))
cl <- colorRampPalette(c('yellow','violet','black'))(100) #
plot(sd_clad, col=cl)
plot(sd_clad_agg, col=cl)
  
#Probably wrong
  
# plot the calculation
par(mfrow=c(1,2))
cl <- colorRampPalette(c('yellow','violet','black'))(100) #
plot()
plotRGB(clad, 1,2,3, stretch="lin")
plot(sd_clad, col=cl)
# plot(sd_clad_agg, col=cl)

 

 


 




