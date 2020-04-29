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
