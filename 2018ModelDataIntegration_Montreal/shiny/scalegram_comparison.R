library(shiny)
library(scalegram)

ui <- fluidPage(
  actionButton("go", "Go"),
  numericInput("n", "Number of observations", 1000),
  sliderInput(inputId = "ar",
              step = 0.01,
              label = "Lag-1 autocorrelation coefficient:",
              min = 0,
              max = 1,
              value = 0.3),
  sliderInput(inputId = "H",
              step = 0.01,
              label = "Hurst coefficient:",
              min = 0,
              max = 1,
              value = 0.75),
  plotOutput("scalegram")
)

server <- function(input, output) {
  randomVals_wn <- eventReactive(input$go, {
    rnorm(input$n)
  })

  randomVals_ar <- eventReactive(input$go, {
    arima.sim(model = list(ar = input$ar), n = input$n)
  })

  randomVals_fgn <- eventReactive(input$go, {
    FGN::SimulateFGN(input$n, input$H)
  })


  output$scalegram <- renderPlot({
    aa <- scalegram::scalegram(randomVals_wn())
    bb <- scalegram::scalegram(randomVals_fgn())
    dd <- scalegram::scalegram(randomVals_ar())
    aa$sg_plot$plot +
      geom_line(data = bb$sg_df, col = "dark red") +
      geom_point(data = bb$sg_df, col = "dark red") +
      geom_line(data = dd$sg_df, col = "dark orange") +
      geom_point(data = dd$sg_df, col = "dark orange")
  })
}

shinyApp(ui, server)

