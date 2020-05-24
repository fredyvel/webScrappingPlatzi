aspiradoras<-as.data.frame(resClean)
#View(aspiradoras)
#str(aspiradoras$`Peso del Producto`)
#procesado de peso
aspiradoras$`Peso del Producto`<-as.character(aspiradoras$`Peso del Producto`)
aspiradoras$`Peso del Producto`<-gsub(" Kg","",aspiradoras$`Peso del Producto`)
aspiradoras$`Peso del Producto`<-gsub(",",".",aspiradoras$`Peso del Producto`)
aspiradoras$`Peso del Producto`<-gsub("-1",NA,aspiradoras$`Peso del Producto`)
aspiradoras$`Peso del Producto`<-as.numeric(aspiradoras$`Peso del Producto`)

pesomedio<-mean(aspiradoras$`Peso del Producto`,na.rm = TRUE)
aspiradoras$`Peso del Producto`[is.na(aspiradoras$`Peso del Producto`)]<-pesomedio
#hist(aspiradoras$`Peso del Producto`)
#summary(aspiradoras$`Peso del Producto`)

#procesado de volumen
aspiradoras$Volumen <-as.character(aspiradoras$Volumen)
aspiradoras$Volumen<-gsub(" litros","",aspiradoras$Volumen)
aspiradoras$Volumen<-gsub(",",".",aspiradoras$Volumen)
aspiradoras$Volumen<-gsub("-1",NA,aspiradoras$Volumen)
aspiradoras$Volumen<-as.numeric(aspiradoras$Volumen)

pesomedioVol<-mean(aspiradoras$Volumen,na.rm = TRUE)
aspiradoras$Volumen[is.na(aspiradoras$Volumen)]<-pesomedioVol
hist(aspiradoras$Volumen)
#summary(aspiradoras$Volumen)

#class(aspiradoras$Opiniones)
aspiradoras$Opiniones<-as.character(aspiradoras$Opiniones)
aspiradoras$Opiniones<-gsub(" valoraciones","",aspiradoras$Opiniones)
aspiradoras$Opiniones<-gsub(" valoración","",aspiradoras$Opiniones)
aspiradoras$Opiniones<-gsub(",","",aspiradoras$Opiniones)
aspiradoras$Opiniones<-as.numeric(aspiradoras$Opiniones)
aspiradoras$Opiniones[is.na(aspiradoras$Opiniones)]<-mean(aspiradoras$Opiniones,na.rm = TRUE)
#hist(aspiradoras$Opiniones)

#class(aspiradoras$Precio)
aspiradoras$Precio<-as.character(aspiradoras$Precio)
aspiradoras$Precio<-gsub("€","",aspiradoras$Precio)
aspiradoras$Precio<-gsub(",",".",aspiradoras$Precio)
aspiradoras$Precio<-trimws(gsub("â¬","",aspiradoras$Precio))
aspiradoras$Precio<-str_sub(aspiradoras$Precio, 1, str_length(aspiradoras$Precio)-1)
aspiradoras$Precio<-as.numeric(aspiradoras$Precio)
aspiradoras$Precio[is.na(aspiradoras$Precio)]<-mean(aspiradoras$Precio,na.rm=TRUE)

aspiradoras$Potencia<-as.character(aspiradoras$Potencia)
aspiradoras$Potencia<-gsub(" vatios","",aspiradoras$Potencia)
aspiradoras$Potencia<-gsub("-1",NA,aspiradoras$Potencia)
aspiradoras$Potencia<-as.numeric(aspiradoras$Potencia)
aspiradoras$Potencia[is.na(aspiradoras$Potencia)]<-mean(aspiradoras$Potencia,na.rm=TRUE)

aspiradoras$`Dimensiones del Producto`<-as.character(aspiradoras$`Dimensiones del Producto`)
aspiradoras$`Dimensiones del Producto`<-gsub(" cm", "", aspiradoras$`Dimensiones del Producto`)
aspiradoras$`Dimensiones del Producto`<-gsub(",", ".", aspiradoras$`Dimensiones del Producto`)
library(stringr)
dimen<-str_split_fixed(aspiradoras$`Dimensiones del Producto`," x ", n=3)

res_limpio<-cbind(aspiradoras, dimen)
res_limpio<-res_limpio[,-5]
