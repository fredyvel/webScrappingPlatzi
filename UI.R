# k-means only works with numerical variables,
# so don't give the user the option to select
# a categorical variable
# vars <- setdiff(names(iris), "Species")

pageWithSidebar(
  headerPanel('Aspiradoras Amazon K-Means Clustering'),
  sidebarPanel(
    selectInput('xcol', 'X Variable', names(data)),
    selectInput('ycol', 'Y Variable', names(data), selected = names(data)[[2]]),
    numericInput('clusters', 'Cluster count', 3, min = 1, max = 9)
  ),
  mainPanel(
    plotOutput('plot1')
  )
)