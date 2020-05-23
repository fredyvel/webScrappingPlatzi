library(stringr)
# asigna el link
url<-"https://www.laliga.com/laliga-santander/clubes"
pagina<-read_html(url)
#usa el selector donde esta el link de cada club
selector<-"a:nth-child(1)"
nodo<-html_nodes(pagina,selector)
nodo_links<-html_attr(nodo,"href")
nodo_links<-nodo_links[which(str_match(nodo_links,"/clubes/")=="/clubes/")]
url_club<-paste0("https://www.laliga.com",nodo_links)
dameLinksJugador<-function(url_club){
  print(url_club)
  selector_jugador<-"a:nth-child(1)"
  pagina_club<-read_html(url_club)
  nodo<-html_nodes(pagina_club, selector_jugador)
  nodo_text<-html_text(nodo)
  nodo_jugador<-html_attr(nodo, "href")
  nodo_jugador<-nodo_jugador[which(str_match(nodo_jugador,"/jugador/")=="/jugador/")]
  nodo_jugador
}
link_jugadores<-sapply(url_club[1:18],dameLinksJugador)
class(link_jugadores)
link_jugadores<-unlist(link_jugadores)

Vect_jugadores<-as.vector(link_jugadores)
Vect_jugadores<-paste0("https://www.laliga.com",Vect_jugadores)
Vect_jugadores
url_jugador<-Vect_jugadores[[1]]
datos_jugadores<-function(url_jugador)
{
  pagina_jugador<-read_html(url_jugador)
  
  # nombreJugador  
  selct_NomJug<-".bRpWYQ" 
  nodo<-html_node(pagina_jugador, selct_NomJug)
  textJugador<-html_text(nodo)
  return(textJugador)
#
#  selct_NomClub<-"p:nth-child(1)"

#  nodo<-html_node(pagina_jugador, selct_NomClub)
#  text_club<-html_text(nodo)
#  text_club
}

nombreJugadores<-sapply(Vect_jugadores,datos_jugadores)

