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


