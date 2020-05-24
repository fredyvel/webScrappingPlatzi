data<-res_limpio
data<-data[-1]
data<-scale(data)
mycluster<-kmeans(data,3,nstart = 5, iter.max = 30)
mycluster$withinss
wss<-(nrow(data)-1)*sum(apply(data,2,var))
for(i in 2:20) wss[i]<-sum(kmeans(data,centers = i)$withinss)

plot(1:20,wss,type='b',xlab="Numero de Cluster",ylab="withniss group")

mycluster<-kmeans(data,8,nstart = 5, iter.max = 30)

install.packages("fmsb")
library(fmsb)
par(mfrow=c(2,4))
plotCentros<-function(centro){
dat<-as.data.frame(t(mycluster$centers[centro,]))
dat<-rbind(rep(5,10),rep(-1.5,10),dat)
radarchart(dat)
}
sapply(c(1:8),plotCentros)
class(data)
write.csv(data,"/Users/fredyvelasquez/Projects\ R/webScrappingPlatzi/data.csv", row.names = FALSE)

mycluster$centers
