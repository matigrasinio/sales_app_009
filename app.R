library(shiny)

ui <- shinydashboardPlus::dashboardPage(
  options = list(sidebarExpandOnHover = TRUE),
  header = shinydashboardPlus::dashboardHeader(
    title = "Sales App" |> shiny::h3(class = "dropdown", style = "display: inline;")
  ),
  sidebar = shinydashboardPlus::dashboardSidebar(
    minified = TRUE, collapsed = FALSE

  ),
  body = shinydashboard::dashboardBody(

  ),
  title = "DashboardPage"
)

server <- function(input, output, session) {

  res_data <- reactiveVal(NULL)

}

shinyApp(ui, server, options = list(port = 8888, host = "0.0.0.0"))
