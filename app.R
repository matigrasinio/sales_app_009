library(shiny)
source("utils.R")

ui <- shinydashboardPlus::dashboardPage(
  options = list(sidebarExpandOnHover = TRUE),
  header = shinydashboardPlus::dashboardHeader(
    title = "Sales App" |> shiny::h3(class = "dropdown", style = "display: inline;")
  ),
  sidebar = shinydashboardPlus::dashboardSidebar(
    minified = TRUE, collapsed = FALSE,
    shiny::selectInput("store", "Store", choices = 1:3, selected = 1),
    shiny::selectInput("department", "Department", choices = 1:3, selected = 1),
    shiny::selectInput(
      "variables", "Variables",
      choices = c("Date", "Temperature", "Fuel_Price", "CPI", "Unemployment", "IsHoliday", "Weekly_Sales", "Name"),
      selected = c("Date", "Weekly_Sales"), multiple = TRUE
    )
  ),
  body = shinydashboard::dashboardBody(
    shiny::textOutput("title"),
    shiny::tableOutput("sales_data")
  ),
  title = "DashboardPage"
)

server <- function(input, output, session) {

  res_data <- reactiveVal(NULL)

  output$title <- renderText({
    data_header(input$store, input$department)
  })

  observeEvent(input$store, {
    res_data(read_data(input$store))
  }, ignoreNULL = TRUE)

  output$sales_data <- renderTable({
    req(input$department)

    tbl_data <- res_data()

    tbl_data[tbl_data$Dept == input$department, ] |>
      subset_data(input$variables)
  })
}

shinyApp(ui, server, options = list(port = 8888, host = "0.0.0.0"))
