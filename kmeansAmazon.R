data<-res_limpio
data<-data[-1]
data<-scale(data)
mycluster<-kmeans(data,3,nstart = 5, iter.max = 30)
mycluster$withinss
wss<-(nrow(data)-1)*sum(apply(data,2,var))
for(i in 2:20) wss[i]<-sum(kmeans(data,centers = i)$withinss)

plot(1:20,wss,type='b',xlab="Numero de Cluster",ylab="withniss group")

mycluster<-kmeans(data,8,nstart = 5, iter.max = 30)
