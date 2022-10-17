library(shiny)
library(shinythemes)
library(tidyverse)

data <- read_csv('bodyfat3.csv', col_select = BODYFAT)

# Define UI for application that draws a histogram
ui <- fluidPage(
    theme = shinytheme("cerulean"),
    shinyFeedback::useShinyFeedback(),
    # Application title
    titlePanel("Body Fat Calculator"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            numericInput(
                "num_weight", "Weight: ", 200, min=100, max=400
            ),
            numericInput(
                "num_abdomen", "Abdomen: ", 90, min=60, max=150
            ),
            numericInput(
                "num_wrist","Wrist: ", 19, min=12, max=25
            ),
            actionButton("calculate", "Calculate", class="btn-primary"),
            tags$div(
                class = "jumbotron",
                span( textOutput('txt'), style="color:blue;font-size:20px" )
            )
            #textOutput('txt')
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput('plot')
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    
    get_bodyfatper <- eventReactive(input$calculate, {
        #input$num_weight
        a <- input$num_weight
        weight_check <- a>0
        shinyFeedback::feedbackWarning("num_weight", !weight_check, "Weight can't be non-positive!")

        b <- input$num_wrist
        wrist_check <- b>0
        shinyFeedback::feedbackWarning("num_wrist", !wrist_check, "Wrist size can't be non-positive!")

        c <- input$num_abdomen
        abdomen_check <- b>0
        shinyFeedback::feedbackWarning("num_abdomen", !abdomen_check, "Abdomen size can't be non-positive!")

        result <- -24.28103 + 0.87553*c - 1.22982*b - 0.03892*a
        return (result)
    })
    output$txt <- renderText({ 
        r <- get_bodyfatper()
        paste(r,"%")
    })
    output$plot <- renderPlot({ 
        r <- get_bodyfatper()
        ggplot(data, aes(BODYFAT)) +
            geom_histogram(bins=30) +
            geom_vline(xintercept=r, color='red') +
            geom_text(aes(x=r,label="You are here",y=5), color='red', angle=90, vjust=-1) +
            labs(y='COUNT')
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
