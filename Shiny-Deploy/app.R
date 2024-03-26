# load libraries
library(shiny)
library(ggplot2)

# user interface
ui <- fluidPage(
    titlePanel("Dynamic Histogram with Shiny"),
    # sidebar 
    sidebarLayout(
        sidebarPanel(
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 10)
        ),
        # show a plot 
        mainPanel(
            plotOutput("distPlot")
        )
    )
)

# server
server <- function(input, output) {
    output$distPlot <- renderPlot({
        # bins 
        bins <- seq(min(mtcars$mpg), max(mtcars$mpg), length.out = input$bins + 1)
        
        # plot 
        ggplot(mtcars, aes(x=mpg)) +
            geom_histogram(breaks=bins, col="black", fill="blue") +
            theme_minimal() +
            labs(title="Histogram of MPG", x="MPG", y="Frequency")
    })
}

# Run the application
shinyApp(ui = ui, server = server)