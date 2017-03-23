### let's use a look up table to clean special characters
cleanSpecialChars = function(text) {
  specialChars = c('\x92')
  substitution = c('\'')
  for (i in 1:length(specialChars)) {
    text = gsub(specialChars[i],substitution[i],text)
  }
  return(text)
}

### assign a code with an existing list of words (indices used)
assignCodes = function(cleanTurn,wordCode) {
  series = c()
  for (word in unlist(strsplit(cleanTurn,' '))) {
    series = c(series, which(word==wordCode))
  }
  return(series)
}

cleanText = function(rawText) {
  rawText = Corpus(VectorSource(rawText))    
  # eliminate extra whitespace; requires tm
  rawText = tm_map(rawText, stripWhitespace)
  rawText = tm_map(rawText, tolower)
  # eliminate punctuation
  removepunct = function(x) { return(gsub("[[:punct:]]","",x)) }
  rawText = tm_map(rawText, removepunct)[[1]]  
  return(rawText)
}

# uses crqa
plotRP = function(RP,xlab,ylab) {
  ij = which(RP==1,arr.ind=T)
  plot(ij[,1],ij[,2],cex=.25,xlab=xlab,ylab=ylab,pch=14)
}

# splits by null character to get characters ("letters")
makeCharacterSequence = function(fl,numbersToFile=NULL) {
  rawText = readChar(fl,file.info(fl)$size)
  chars = unlist(strsplit(rawText, ""))
  uniqChars = unique(chars)
  charSeries = as.vector(sapply(chars,function(x) {
    which(x == uniqChars)
  }))
  if (!is.null(numbersToFile)) {
    write.table(charSeries,file=numbersToFile,row.names=F,col.names=F)
  }
  return(charSeries)
} 

# this function tokenizes with the space character; 
# you could also improve it by utilizing any white space,
# or tokenizer like MC_tokenizer, etc.
makeWordSequence = function(fl,trimPunctuation=FALSE,stemWords=FALSE,numbersToFile=NULL,isUrl=FALSE) {
  if (!isUrl) { # it's a file name
    rawText = readChar(fl,file.info(fl)$size)
  } else { # it's a url, get the file
    rawText = getURL(fl, ssl.verifypeer = FALSE)
  }
    
  if (trimPunctuation) {
    rawText = Corpus(VectorSource(rawText))    
    # eliminate extra whitespace; requires tm
    rawText = tm_map(rawText, stripWhitespace)
    # eliminate punctuation
    removepunct = function(x) { return(gsub("[[:punct:]]","",x)) }
    rawText = tm_map(rawText, removepunct)[[1]]
  }  
  if (stemWords) {
    words = wordStem(unlist(strsplit(tolower(stri_unescape_unicode(rawText)), ' ')))       
  } else {
    words = unlist(strsplit(tolower(stri_unescape_unicode(rawText)), ' '))                   
  }
                   
  uniqWords = unique(words)
  
  wordSeries = as.vector(sapply(words,function(x) {
    which(x == uniqWords)
  }))
  
  if (!is.null(numbersToFile)) {
    write.table(wordSeries,file=numbersToFile,row.names=F,col.names=F)
  }    
  return(wordSeries)
}



