library(shiny)
library(shinythemes)
library(tidyverse)
library(DT)

data <- read_csv('bodyfat_out.csv', col_select = BODYFAT)
bodyfat_ref <- read_csv('BodyFat_reference.csv', col_select = c(Description, Women, Men))

# Define UI for application that draws a histogram
ui <- fluidPage(
    theme = shinytheme("cerulean"),
    shinyFeedback::useShinyFeedback(),
    # Application title
    titlePanel("Body Fat Calculator"),
    
    sidebarLayout(
        sidebarPanel(
            numericInput(
                "num_abdomen", "Abdomen(cm): ", 90, min=60, max=150
            ),
            actionButton("calculate", "Calculate", class="btn-primary"),
            tags$div(
                class = "jumbotron",
                span( textOutput('txt'), style="color:blue;font-size:20px" )
            ),
        ),

        mainPanel(
           plotOutput('plot'),
           dataTableOutput('bodyfat_ref')
        ),
    ),
    hr(),
    tags$div(
        class = "footer",
        HTML('Developed by: 
             <br> Amy Qin: qin58@wisc.edu 
             <br> Chao-Sheng Wu: cwu377@wisc.edu
             <br> Maxwell Schleck: mschleck98@wisc.edu')
    )
)

server <- function(input, output) {
    
    get_bodyfatper <- eventReactive(input$calculate, {
        # a <- input$num_weight
        # weight_check <- a>0
        # shinyFeedback::feedbackWarning("num_weight", !weight_check, "Weight can't be non-positive!")
        # 
        # b <- input$num_wrist
        # wrist_check <- b>0
        # shinyFeedback::feedbackWarning("num_wrist", !wrist_check, "Wrist size can't be non-positive!")

        c <- input$num_abdomen
        abdomen_check <- c>0
        shinyFeedback::feedbackWarning("num_abdomen", !abdomen_check, "Abdomen size can't be non-positive!")

        result <- -37.54 + 0.61*c #- 1.22982*b - 0.03892*a
        
        # Body fat percentage should be between 0~100
        if (result<=0){
            result <-0
        } else if (result>=100){
            result <- 100
        }
        return (result)
    })
    output$txt <- renderText({ 
        r <- get_bodyfatper()
        paste("Body Fat: ", r, "%", sep="")
    })
    output$plot <- renderPlot({ 
        r <- get_bodyfatper()
        ggplot(data, aes(BODYFAT)) +
            geom_histogram(bins=30) +
            geom_vline(xintercept=r, color='red') +
            geom_text(aes(x=r,label="You are here",y=5), color='red', angle=90, vjust=-1) +
            labs(y='COUNT', x="BodyFat %")
    })
    
    output$bodyfat_ref <- renderDataTable(bodyfat_ref, 
                                          rownames = FALSE,
                                          caption = 'The American Council on Ecercise Body Fat Categorization',
                                          options = list(dom = 't'))
}

# Run the application 
shinyApp(ui = ui, server = server)
