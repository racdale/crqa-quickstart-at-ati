# Sliding joint recurrence plot (JRP) example
#
# Coded by Rick Dale, Jun. 21st, 2018 for Cincinnati ATI
#
# Please cite:
# Coco, M. I., & Dale, R. (2014). Cross-recurrence quantification analysis of 
# categorical and continuous time series: an R package. Frontiers in 
# Quantitative Psychology and Measurement, 5. 
# http://cognaction.org/rdmaterials/php.cv/pdfs/article/coco_dale_2014.pdf

library(crqa)

plot_rp = function(RP,xlab='i',ylab='j',cex=.1) { # plots the RP from crqa output
  if (!is.matrix(RP)) { RP = as.matrix(RP) }
  ij = which(RP==1,arr.ind=T)
  plot(ij[,1],ij[,2],cex=cex,xlab=xlab,ylab=ylab,pch=16) 
}


# build some lorenz time series with subtly different parameters
dt = 0.01
sigma = 10
b = 8/3
numsteps = 1000
plots = T
lorenz_1 = lorenzattractor(numsteps, dt, sigma, r = 28, b, plots)
lorenz_2 = lorenzattractor(numsteps, dt, sigma, r = 31, b, plots)

# do crqa for first lorenz
res_1 = crqa(lorenz_1[, 1], lorenz_1[, 1], delay = 5, embed = 3, 
             rescale = 1, radius = 5, normalize = 0, 
             minvertline = 2, mindiagline = 2, tw = 1, whiteline = F, 
             recpt = F)

# build first lorenz RP
RP_1 = as.matrix(res_1$RP) # convert into numeric non-sparse matrix
plot_rp(res_1$RP)

# do the same for second lorenz
res_2 = crqa(lorenz_2[, 1], lorenz_2[, 1], delay = 5, embed = 3, 
             rescale = 1, radius = 5, normalize = 0, 
             minvertline = 2, mindiagline = 2, tw = 1, whiteline = F, 
             recpt = F)

RP_2 = as.matrix(res_2$RP) # convert into numeric non-sparse matrix
plot_rp(res_2$RP)

# JRP = simply the multiplication of the two
JRP = (RP_1*RP_2)

# how we feed in JRP matrix into crqa function
JRP_res = crqa(JRP, delay = 1, embed = 1, rescale = 1, radius = 5, normalize = 0, 
               minvertline = 2, mindiagline = 2, tw = 1, whiteline = F, recpt = T)
# note recpt parameter = T

# let's plot the JRP, too
plot_rp(JRP_res$RP)

# sliding JRP = shift them relative to each other
# can we find an "optimal product" that overlaps the regimes
# of the lorenz equations under unique parameters...?
n = nrow(RP_1) # size of RP
k_max = round(n/10) # only look for a small # of alignments... 1/10th of length of RP 
s_JRP_results = data.frame(lag=0,RR=JRP_res$RR,DET=JRP_res$DET) # initialize with lag (alignment) of 0 - regular JRP
for (k in 2:k_max) {
  
  print(k)

  # shift 2 back
  new_RP_1 = RP_1[,k:n][k:n,]
  new_RP_2 = RP_2[,1:(n-k+1)][1:(n-k+1),]
  new_JRP = (new_RP_1*new_RP_2)
  JRP_res = crqa(new_JRP, delay = 1, embed = 1, rescale = 1, radius = 5, normalize = 0, 
       minvertline = 2, mindiagline = 2, tw = 1, whiteline = F, recpt = T)
  
  s_JRP_results = rbind(s_JRP_results,data.frame(lag=-k,RR=JRP_res$RR,DET=JRP_res$DET))
  
  # shift 1 back
  new_RP_2 = RP_2[,k:n][k:n,]
  new_RP_1 = RP_1[,1:(n-k+1)][1:(n-k+1),]
  new_JRP = (new_RP_1*new_RP_2)
  JRP_res = crqa(new_JRP, delay = 1, embed = 1, rescale = 1, radius = 5, normalize = 0, 
                 minvertline = 2, mindiagline = 2, tw = 1, whiteline = F, recpt = T)
  
  s_JRP_results = rbind(s_JRP_results,data.frame(lag=k,RR=JRP_res$RR,DET=JRP_res$DET))
  
}

plot(RR~lag,data=s_JRP_results,type='p')







