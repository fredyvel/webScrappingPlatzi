library(plumber)
r<-plumb("/Users/fredyvelasquez/Projects\ R/webScrappingPlatzi/Aspiradoras_plumber.R")
r$run(port = 8000)
data[1,]

# http://localhost:8000/getCluster?Precio=0.3433720&Opiniones=2.2462361&Peso=0.3701881&Volumen=-0.5747263&Potencia=1.6242480&Alto=-1.5689065&Ancho=0.5940881&Profundidad=3.3004163
#GET "http://127.0.0.1:8000/getCluster?Profundidad=4.3004163&Ancho=1.5940881&Alto=2.5689065&Potencia=2.6242480&Volumen=1.5747263&Peso=1.3701881&Opiniones=1.2462361&Precio=3.3433720"