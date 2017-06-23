setwd('~/Dropbox')

# make sure to load the functions, which includes some recoding tools
source('functions.R')

library(gdata) # need this for read.xls
a = read.xls('testBook.xlsx')
person1 = a[a$person=='P1',]
person2 = a[a$person=='P2',]

# MAKING TIME SERIES FILES FOR CODE COLUMNS 
# critical point not mentioned yesterday... recode 0's (non events) separately for p1 and p2
# then save the text file for use in the ATI tools
code.p1 = person1$code.1
code.p2 = person2$code.1
code.p1[code.p1==0] = 2
code.p2[code.p2==0] = 3
write.table(file='person1code1.txt',code.p1,row.names=F,col.names=F)
write.table(file='person2code1.txt',code.p2,row.names=F,col.names=F)

# WORK WITH TEXT TO CREATE LETTER SERIES
# functions.R contains these functions for doing conversion as described
# 1: first, we need to get the list of characters from the file
uniqChars = unique(unlist(strsplit(paste(a$stuff.said),'')))
# now let's convert person 1 using this code
series.p1 = assignCharCodes(paste(person1$stuff.said),uniqChars)
series.p2 = assignCharCodes(paste(person2$stuff.said),uniqChars)
# now, let's trim to the shortest time series so we can use the square plots
minLen = min(length(series.p1),length(series.p2))
series.p1 = series.p1[1:minLen]
series.p2 = series.p2[1:minLen]
# now let's write them to two files for cross recurrence
write.table(file='person1code1.txt',series.p1,row.names=F,col.names=F)
write.table(file='person2code1.txt',series.p2,row.names=F,col.names=F)





