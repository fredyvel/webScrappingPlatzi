install.packages("rvest")
library("rvest")
url<-"https://www.imdb.com/title/tt0451279/?ref_=nv_sr_1?ref_=nv_sr_1"
pagina_web<-read_html(url)
class(pagina_web)
pagina_web
selector<-".ratingValue > strong:nth-child(1) > span:nth-child(1)"
nodo<-html_node(pagina_web,selector)
nodo_texto<-html_text(nodo)
nodo_texto
selector_tabla<-".cast_list"
nodo_tabla<-html_node(pagina_web,selector_tabla)
nodo_tabla_texto<-html_table(nodo_tabla)
View(nodo_tabla_texto)

https://twitter.com/search?q=banruralgt&src=typed_query

url<-"https://twitter.com/search?q=banruralgt&src=typed_query"
scrape_linkedin <- function(user_url) {
  linkedin_url <- "http://linkedin.com/"
  pgsession <- html_session(linkedin_url) 
  pgform <- html_form(pgsession)[[1]]
  filled_form <- set_values(pgform,
                            session_key = username, 
                            session_password = password)