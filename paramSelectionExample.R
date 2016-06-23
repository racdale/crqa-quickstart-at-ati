
##
# make sure to check out the help(optimizeParam) for caveats... this is still
# quite alpha version and can sometimes produce different results from hand-set
# parameters using the ATI's tools
##

NovL = read.csv('data/Nov-L.csv',header=F)$V1 # thanks to Dr. Kentaro Kodama @ ATI
NovR = read.csv('data/Nov-R.csv',header=F)$V1 # thanks to Dr. Kentaro Kodama @ ATI

par = list(lgM =  20, steps = seq(1, 6, 1), 
           radiusspan = 20, radiussample = 10, 
           normalize = 2, rescale = 1, mindiagline = 2, 
           minvertline = 2, tw = 1, whiteline = FALSE, 
           recpt = FALSE, fnnpercent = 10, typeami = "mindip")

optimizeParam(NovL, NovR, par, min.rec = 2, max.rec = 5)




