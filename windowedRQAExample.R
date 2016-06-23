#
# thank you to Dr. Kentaro Kodama for the sample data
# sample code: Rick Dale, for ATI 2016 in Cincinnati
#

NovL = read.csv('data/Nov-L.csv',header=F)$V1
NovR = read.csv('data/Nov-R.csv',header=F)$V1
# reflect left and right hand positions of a novice balance participant

# sample rate 120hz, so window size 4 seconds, window step .5 seconds
# parameters determined by Dr. Kodama
resNov = wincrqa(NovL, NovR, windowstep=30,windowsize=480, 
                 delay=100, embed=4, rescale=1, radius=25, 
                 normalize=2, mindiagline=2, minvertline=2, tw=1, whiteline=F, trend=F) 

# the clumns of the data matrix resNov$crq is the same as listed, in order, in help(crqa)
plot(resNov$crq[,1],xlab='Window (4s)',ylab='RR',type='b')
plot(resNov$crq[,2],xlab='Window (4s)',ylab='DET',type='b')


