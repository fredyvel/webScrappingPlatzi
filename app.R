install.packages("plumber")
library(plumber)
r<-plumb("/Users/fredyvelasquez/Projects\ R/webScrappingPlatzi/Plumber.R")
r$run(port=8000)
