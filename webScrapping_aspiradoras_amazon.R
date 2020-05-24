install.packages("rvest")
library("rvest")

library(stringr)
pag<-"s?k=aspiradora&page=2&__mk_es_ES=%C3%85M%C3%85%C5%BD%C3%95%C3%91&qid=1559659201&ref=sr_pg_2"
lista_paginas<-c(1:10)
pag<-str_replace(pag, "page=2", paste0("page=",lista_paginas))
pag<-str_replace(pag, "sr_pg_2", paste0("sr_pg_",lista_paginas))

paginas<-paste0("https://www.amazon.es/", pag)

dameLinksPagina<-function(url){
  selector<-"div > div:nth-child(1) > div > div > div:nth-child(1) > h2 > a"
  pagina<-read_html(url)
  nodo<-html_nodes(pagina, selector)
  nodo_text<-html_text(nodo)
  nodo_links<-html_attr(nodo, "href")
  nodo_links
  
}

linksAsp<-sapply(paginas, dameLinksPagina)
lista<-unlist(linksAsp)
vlink<-as.vector(lista)
length(vlink)
vlinkAspiradora<-paste0("https://www.amazon.es/", vlink)
vlinkAspiradora[1]


getArticulo<-function(url){
  print(url)
  # nombre del producto
  
  selectorNombre<-"#productTitle"
  pagina_web<-read_html(url)
  nombre_nodo<-html_node(pagina_web,selectorNombre)
  nombre_texto<-trimws(html_text(nombre_nodo))
  
  # comentarios del producto
  opiniones<-"#acrCustomerReviewText"
  opiniones_nodo<-html_node(pagina_web,opiniones)
  opiniones_texto<-trimws(html_text(opiniones_nodo))
  
  #precio del producto
  precio<-"#priceblock_ourprice"
  precio_nodo<-html_node(pagina_web,precio)
  precio_texto<-trimws(html_text(precio_nodo))
  
  #tabla de descripciones del producto
  tabla<-"div.column:nth-child(1) > div:nth-child(1) > div:nth-child(2) > div:nth-child(1) > div:nth-child(1) > table:nth-child(1)"
  tabla_nodo<-html_node(pagina_web,tabla)
  if(!is.na(tabla_nodo)) 
  {
    tabla_tab<-html_table(tabla_nodo)
    val<-tabla_tab$X2
    val
    res_tabla<-data.frame(t(val))
    tabla_name<-tabla_tab$X1
    colnames(res_tabla) <-tabla_name
   
  }
  col<-c("Peso de Producto","Dimensiones de Producto","Volumen","Potencia")
  if(is.na(tabla_nodo))
  {
    #no hay detalles todo a  -1
    mitab<-data.frame(colnames(col))  
    mitab<-rbind(mitab,c("-1","-1","-1","-1"))
    colnames(mitab)<-col
      }else {
    # Evaluar cad uno de los atributos
        zero<-matrix("-1",ncol=4,nrow=1)
        dfzeroz<-as.data.frame(zero)
        colnames(dfzeroz)<-col
        peso<-as.character(res_tabla$`Peso del producto`)
        if(length(peso)==0) peso<-"-1"
        dime<-as.character(res_tabla$`Dimensiones del producto`)
        if(length(dime)==0) dime<-"-1"
        potencia<-as.character(res_tabla$Potencia)
        if(length(potencia)==0) potencia<-"-1"
        volumen<-as.character(res_tabla$Capacidad)
        if(length(volumen)==0) volumen<-"-1"
        dfzeroz$`Peso de Producto`<-peso
        dfzeroz$`Dimensiones de Producto`<-dime
        dfzeroz$Potencia<-potencia
        dfzeroz$Volumen<-volumen
        mitab<-dfzeroz
        colnames(mitab)<-col
    
      }
  articulo<-c(nombre_texto,precio_texto,opiniones_texto,as.character(mitab$`Peso de Producto`[1]),as.character(mitab$`Dimensiones de Producto`[1]),as.character(mitab$Volumen[1]),as.character(mitab$Potencia[1]))
  
  articulo
}
# vlinkAspiradora[83]
# url<-"https://www.amazon.es//BABIFIS-Esterilizar-Anti-%C3%A1caros-Eliminaci%C3%B3n-aspiradoras/dp/B086PDBRPH/ref=sr_1_3?__mk_es_ES=%C3%85M%C3%85%C5%BD%C3%95%C3%91&dchild=1&keywords=aspiradora&qid=1590277392&sr=8-3"
# getArticulo(url)
# vlinkAspiradora2<-sapply(vlinkAspiradora,trimws)
# View(vlinkAspiradora2)
resultados_datos<-sapply(vlinkAspiradora2,getArticulo)

res<-t(resultados_datos)
# View(res)
dim(res)

colnames(res)<-c("Nombre","Precio","Opiniones","Peso del Producto","Dimensiones del Producto","Volumen","Potencia")
# !is.na(res[1:160,1])
resClean<-res[!is.na(res[,1]),]
#View(res[,1])
#length(resClean[,1])
rownames(resClean)<-c(1:length(resClean[,1]))
View(resClean)
