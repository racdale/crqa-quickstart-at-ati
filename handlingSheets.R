
library(crqa)

setwd('~/Downloads/')
source('functions.R')

fileRoot = 'filtered_TACT+15Mission1'

mySheet = read.csv(paste('filtered_TACT+15Mission1','csv',sep='.'))

write.table(file=paste(fileRoot,'column.1','txt',sep='.'),mySheet[,1],row.names=FALSE,col.names=FALSE)

resID = crqa(mySheet[,1], mySheet[,1], 1, embed=5, 1, 0.001, F, 2, 2, tw=0, F, F)     

plotRP(resID$RP,'Time','Time')

# example windowed recurrence
res = wincrqa(mySheet[,1], mySheet[,1], windowstep=10,windowsize=50, 
              delay=1, embed=2, rescale=1, radius=.001, 
              normalize=0, mindiagline=2, minvertline=2, tw=1, whiteline=FALSE, trend=FALSE) 

# crqwin contains a list of measures across windows 1 = RR; 2 = DET, etc.
plot(res$crqwin[,1],xlab='Window',ylab='RR',type='b')

plot(res$crqwin[,2],xlab='Window',ylab='DET',type='b')

### let's unfold this into "real time"
realTimeTalkers = as.numeric(unlist(apply(mySheet,1,function(x) {
  rep(x['DIS.ID.NAME'],ceil(as.numeric(x['PTT.DURATION'])))
})))

plot(realTimeTalkers,type='l')

resRealTime = crqa(realTimeTalkers, realTimeTalkers, 1, embed=5, 1, 0.001, F, 2, 2, tw=0, F, F)     
plotRP(resRealTime$RP,'Time (s)', 'Time (s)')

res = wincrqa(realTimeTalkers,realTimeTalkers, windowstep=15,windowsize=30, 
              delay=1, embed=5, rescale=1, radius=.001, 
              normalize=0, mindiagline=2, minvertline=2, tw=1, whiteline=FALSE, trend=FALSE) 

# crqwin contains a list of measures across windows 1 = RR; 2 = DET, etc.
plot(res$crqwin[,1],xlab='Window',ylab='RR',type='b')
plot(res$crqwin[,2],xlab='Window',ylab='DET',type='b')



