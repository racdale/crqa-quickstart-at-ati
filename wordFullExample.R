#
# this text assumes you separate speakers in a transcript
# by double carriage returns (\n\n) to separate turns
# then uses odd/even line numbers to determine who is talking
# this was designed at ATI with Lena Müller to examine
# various aspects of transcript dynamics;
# LIWC example data below of the anonymized content
#

library(crqa)
library(stringi)
library(SnowballC)
library(tm)
source('functions.R')

setwd('~/Dropbox/crqa-quickstart')

fl = 'data/talkturnsTest.txt'
rawText = readChar(fl,file.info(fl)$size)
wordCode = unique(unlist(strsplit(cleanText(rawText),' ')))
turnList = unlist(strsplit(rawText,'\n\n'))

speakerS = c()
speakerI = c()

for (i in 1:length(turnList)) {  
  print(i)
  oddLine = i %% 2  
  cleanTurn = cleanText(turnList[i])
  convertedSequence = assignCodes(cleanTurn,wordCode)
  
  if (oddLine==1) {
    #print(paste('Speaker S',nchar(turnList[i])))
    speakerS = c(speakerS, convertedSequence)
    speakerI = c(speakerI, convertedSequence*0 - 1)
  } else {
    #print(paste('Speaker I',nchar(turnList[i])))
    speakerS = c(speakerS, convertedSequence*0 - 2)
    speakerI = c(speakerI, convertedSequence)    
  }  
}

plot(speakerS,type='l')
points(speakerI,type='l',col='green')
resWords = crqa(speakerI, speakerS, 1, 1, 1, 0.001, F, 2, 2, tw=0, F, F)     
plotRP(resWords$RP,'Speaker I','Speaker S')
str(resWords) # see what's in it

res = drpdfromts(speakerS, speakerI, ws = 200, datatype = "categorical")
plot(res$profile,type='l')

liwcData = read.table('data/liwc_example.txt',header=TRUE,sep='\t')
liwcData[1,]
str(liwcData)
plot(liwcData$Posemo)

functionSum = rowSums(liwcData[,7:17])
write.table(functionSum,file='data/output.txt',row.names=FALSE,col.names=FALSE)

Sindices = seq(from=1,to=length(functionSum),by=2)
Iindices = seq(from=2,to=length(functionSum),by=2)

Sfunction = 1*(functionSum>15)
Ifunction = 1*(functionSum>15)

Sfunction[Iindices] = -100
Ifunction[Sindices] = -200

plot(Sfunction,type='l')

res = drpdfromts(Sfunction, Ifunction, ws = 50, datatype = "categorical")
plot(res$profile)


