url<-"https://www.amazon.es/s?k=aspiradora&__mk_es_ES=%C3%85M%C3%85%C5%BD%C3%95%C3%91&ref=nb_sb_noss"
selector<-"div.sg-col-4-of-24:nth-child(8) > div:nth-child(1) > span:nth-child(1) > div:nth-child(1) > div:nth-child(1) > div:nth-child(3) > h2:nth-child(1) > a:nth-child(1)"
pagina<-read_html(url)
pagina
nodo<-html_node(pagina,selector)
nodo
nodo_texto<-html_text(nodo)
nodo_links<-html_attr(nodo,"href")
nodo_links
url_completa<-paste0("www.amazon.es",nodo_links)
url_completa

https://www.amazon.es/s?k=aspiradora&page=2&__mk_es_ES=%C3%85M%C3%85%C5%BD%C3%95%C3%91&qid=1589692311&ref=sr_pg_2
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

paginas[3]
test<-dameLinksPagina(paginas[3])

linksAsp<-sapply(paginas, dameLinksPagina)
class(linksAsp)
lista<-unlist(linksAsp)
vlink<-as.vector(lista)
length(vlink)
vlinkAspiradora<-paste0("https://www.amazon.es/", vlink)
vlinkAspiradora[1]

url<-"https://www.amazon.es/dp/B07ZJ5VRZR/ref=sspa_dk_detail_1?psc=1&pd_rd_i=B07ZJ5VRZR&pd_rd_w=EdzFa&pf_rd_p=af12bbbd-c74b-4d8c-ad16-2ed2a7b363ab&pd_rd_wg=p7RoI&pf_rd_r=JDW0KJWD3R140X6MMEFB&pd_rd_r=c614e8bf-bbd9-452f-9402-4bc64a71fafe&spLa=ZW5jcnlwdGVkUXVhbGlmaWVyPUFBSlAwMjY4RVk3RFomZW5jcnlwdGVkSWQ9QTA4NzI5ODYyRUJJMEgyS0Q0WVU1JmVuY3J5cHRlZEFkSWQ9QTAwNTMzODAzNzBFNzRJOTdZUFQzJndpZGdldE5hbWU9c3BfZGV0YWlsJmFjdGlvbj1jbGlja1JlZGlyZWN0JmRvTm90TG9nQ2xpY2s9dHJ1ZQ=="
selectorNombre<-"#productTitle"
pagina_web<-read_html(url)
nombre_nodo<-html_node(pagina_web,selectorNombre)
nombre_texto<-html_text(nombre_nodo)
nombre_texto

opiniones<-"#acrCustomerReviewText"
opiniones_nodo<-html_node(pagina_web,opiniones)
opiniones_texto<-html_text(opiniones_nodo)
opiniones_texto

precio<-"#priceblock_ourprice"
precio_nodo<-html_node(pagina_web,precio)
precio_texto<-html_text(precio_nodo)
precio_texto

tabla<-"div.column:nth-child(1) > div:nth-child(1) > div:nth-child(2) > div:nth-child(1) > div:nth-child(1) > table:nth-child(1)"
tabla_nodo<-html_node(pagina_web,tabla)
tabla_tab<-html_table(tabla_nodo)
class(tabla_tab)

val<-tabla_tab$X2
val
res_tabla<-data.frame(t(val))
res_tabla
tabla_name<-tabla_tab$X1
colnames(res_tabla) <-tabla_name
str(res_tabla)
resultado_aspiradoras<-c(nombre_texto,precio_texto,opiniones_texto,as.character(res_tabla$`Peso del producto`),as.character(res_tabla$Potencia),as.character(res_tabla$`Dimensiones del producto`),as.character(res_tabla$Capacidad))

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
  if(length(res_tabla)==0)
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
url<-"https://www.amazon.es//Hmeian-Aspiradora-Aspirada-Inal%C3%A1mbrica-Inoxidable/dp/B07YKQGFTR/ref=sr_1_23?__mk_es_ES=%C3%85M%C3%85%C5%BD%C3%95%C3%91&dchild=1&keywords=aspiradora&qid=1589947330&sr=8-23"
resu<-getArticulo(url)
resultados_datos<-sapply(vlinkAspiradora,getArticulo)
res<-t(resultados_datos)
dim(res)
mis_aspiradoras<-as.data.frame(res)
colnames(res)<-c("Nombre","Precio","Opiniones","Peso del Producto","Dimensiones del Producto","Volumen","Potencia")
rownames(res)<-c(1:100)
View(res)