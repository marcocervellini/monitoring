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


