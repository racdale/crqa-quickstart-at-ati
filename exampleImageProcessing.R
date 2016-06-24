imgFile = "Timeline2.jpg"
library(jpeg)
img = readJPEG(imgFile)
# let's make darker regions have the higher numbers
img = abs(img-1)
# let's take the sum of these pixel darkness scores
# across the long dimension (timeline)
longDimension = which.max(dim(img))
columnPixelation = apply(img,longDimension,sum)
plot(columnPixelation,type='l')
write.table(columnPixelation,file=paste(imgFile,'dynamics.txt',sep='.'),row.names=F,col.names=F)