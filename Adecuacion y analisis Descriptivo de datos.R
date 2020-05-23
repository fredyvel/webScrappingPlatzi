aspiradoras<-as.data.frame(res)
View(aspiradoras)
str(aspiradoras$`Peso del Producto`)
#procesado de peso
aspiradoras$`Peso del Producto`<-as.character(aspiradoras$`Peso del Producto`)
aspiradoras$`Peso del Producto`<-gsub(" Kg","",aspiradoras$`Peso del Producto`)
aspiradoras$`Peso del Producto`<-gsub(",",".",aspiradoras$`Peso del Producto`)
aspiradoras$`Peso del Producto`<-gsub("-1",NA,aspiradoras$`Peso del Producto`)
aspiradoras$`Peso del Producto`<-as.numeric(aspiradoras$`Peso del Producto`)

pesomedio<-mean(aspiradoras$`Peso del Producto`,na.rm = TRUE)
aspiradoras$`Peso del Producto`[is.na(aspiradoras$`Peso del Producto`)]<-pesomedio
hist(aspiradoras$`Peso del Producto`)
summary(aspiradoras$`Peso del Producto`)

#procesado de volumen
aspiradoras$Volumen <-as.character(aspiradoras$Volumen)
aspiradoras$Volumen<-gsub(" litros","",aspiradoras$Volumen)
aspiradoras$Volumen<-gsub(",",".",aspiradoras$Volumen)
aspiradoras$Volumen<-gsub("-1",NA,aspiradoras$Volumen)
aspiradoras$Volumen<-as.numeric(aspiradoras$Volumen)

pesomedioVol<-mean(aspiradoras$Volumen,na.rm = TRUE)
aspiradoras$Volumen[is.na(aspiradoras$Volumen)]<-pesomedioVol
hist(aspiradoras$Volumen)
summary(aspiradoras$Volumen)

class(aspiradoras$Opiniones)
aspiradoras$Opiniones<-as.character(aspiradoras$Opiniones)
aspiradoras$Opiniones<-gsub(" valoraciones","",aspiradoras$Opiniones)
aspiradoras$Opiniones<-gsub(" valoración","",aspiradoras$Opiniones)
aspiradoras$Opiniones<-gsub(",","",aspiradoras$Opiniones)
aspiradoras$Opiniones<-as.numeric(aspiradoras$Opiniones)
aspiradoras$Opiniones[is.na(aspiradoras$Opiniones)]<-mean(aspiradoras$Opiniones,na.rm = TRUE)
hist(aspiradoras$Opiniones)

class(aspiradoras$Precio)
aspiradoras$Precio<-as.character(aspiradoras$Precio)
aspiradoras$Precio<-gsub("€","",aspiradoras$Precio)
aspiradoras$Precio<-trimws(gsub(",",".",aspiradoras$Precio))
aspiradoras$Precio<-as.numeric(aspiradoras$Precio)
