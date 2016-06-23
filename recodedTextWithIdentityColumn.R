
# the following contains a complete example of how to extract and recode
# text from a transcript format that looks like this:
# c: here is some text from a consultant
# t: here is yet more text that is a transcription of a teacher
# this will extract and recode the data in a couple of ways to be
# explained in person. enjoy!
# (thanks to Dr. Courtenay A. Barrett for the setup and sample data)

install.packages('crqa')
library(crqa)

setwd('~/Dropbox/crqa-quickstart') # navigate on your computer; if windows, C:\... etc.

# this file contains a set of functions that I share with you via GitHub
# source runs the functions.R 
# https://github.com/racdale/crqa-quickstart-at-ati
source('functions.R')

fl = 'data/Dyad 1.txt' # location and name for the file name we want to import
rawText = readChar(fl,file.info(fl)$size) # let's first load in the raw data
# split up the text by space and get all unique words
wordCode = unique(unlist(strsplit(cleanText(cleanSpecialChars(rawText)),' '))) 

# now let's break up the transcript by line
# we use the \r\n character because this means "newline" in windows
turns = unlist(strsplit(cleanSpecialChars(rawText),"\r\n"))

C_sequence = c() # this initializes our vector
T_sequence = c()
# let's LOOP through all the turns and convert into two time series
for (i in 1:length(turns)) {
  cleanTurn = cleanText(turns[i]) # let's clean this turn
  identity = substr(cleanTurn,1,1) # let's get the identity of the speaker
  fullTurnText = substr(cleanTurn,3,nchar(cleanTurn)) # get just the content of the turn
  if (identity=='c') {
    C_sequence = c(C_sequence,assignCodes(fullTurnText,wordCode))
    T_sequence = c(T_sequence,0*assignCodes(fullTurnText,wordCode)-1) 
    # since C is talking, blot out T
  } else {
    C_sequence = c(C_sequence,0*assignCodes(fullTurnText,wordCode)-2)
    T_sequence = c(T_sequence,assignCodes(fullTurnText,wordCode))     
    # since T is talking, blot out C
  }
}

# let's plot who's talking by color, with word codes
plot(C_sequence,type='l')
points(T_sequence,type='l',col='green')

# if you wanted simply to store the C/T 
# time series, you can do this, and then use the ATI tools that 
# we used during the workshop:
write.table(C_sequence,file='data/Consultant_Sequence.txt',row.names=FALSE,col.names=FALSE)
write.table(T_sequence,file='data/Teacher_Sequence.txt',row.names=FALSE,col.names=FALSE)

# this uses crqa; for parameters see help(crqa)
resWords = crqa(C_sequence, T_sequence, 1, 1, 1, 0.001, F, 2, 2, tw=0, F, F)     
plotRP(resWords$RP,'Speaker I','Speaker S') # let's plot the CRP
str(resWords) # see what's in it; all the RQA measures!

# example of doing diagonal recurrence profile
res = drpdfromts(C_sequence, T_sequence, ws = 300, datatype = "categorical")
plot(res$profile,type='l')




