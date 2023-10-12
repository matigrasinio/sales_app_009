library(shiny)
source("utils.R")

ui <- shinydashboardPlus::dashboardPage(
  options = list(sidebarExpandOnHover = TRUE),
  header = shinydashboardPlus::dashboardHeader(
    title = "Sales App" |> shiny::h3(class = "dropdown", style = "display: inline;")
  ),
  sidebar = shinydashboardPlus::dashboardSidebar(
    minified = TRUE, collapsed = FALSE,
    shiny::selectInput("store", "Stroe", choices = 1:3, selected = 1)
  ),
  body = shinydashboard::dashboardBody(

  ),
  title = "DashboardPage"
)

server <- function(input, output, session) {

  res_data <- reactiveVal(NULL)

  observeEvent(input$store, {
    res_data(read_data(input$store))
  }, ignoreNULL = TRUE)

}

shinyApp(ui, server, options = list(port = 8888, host = "0.0.0.0"))
