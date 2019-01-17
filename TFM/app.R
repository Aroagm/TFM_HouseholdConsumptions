#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(tidyverse)
library(shiny)

#Load all the dataset contains in data
data_path = "./data"

temp = list.files(path = data_path,pattern="^residential",full.names = TRUE)
myfiles = lapply(temp, read.delim, sep=",")

prices_cluster = read.csv(paste(data_path,"/Cluster_prices.csv", sep=""))

# use_pattern <- function(df_in, appliance){
#   col_name <- paste(appliance,"_dif", sep="")
#   data_out <- df_in[df_in[, col_name]!= 0, ]%>% 
#     group_by(Hour) %>%
#     summarize(total.count=n())
#   
#   return(plot(data_out,type="l"))
# }  

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Household Consumptions Recommendations"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(sliderInput("house_num",
                               h3("Select the house", align="center"),
                               min = 1,
                               max = 6,
                               value = 1),
                   
         h3("Home appliance", align = "center"),
         
         fluidRow(column(3,actionButton("dishwasher", img(src = "dishwasher.jpg",
                                                  height = "120px")
                  )),
         
                  column(3, offset= 2, actionButton("washingmachine", img(src = "washingmachine.jpg",
                                                                      height = "120px")
                  )))
         
      ),
      
      # Show a plot of the generated distribution
      mainPanel(h3(textOutput("selected_var"),
                   plotOutput("plot"))

      )
   ))

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  # text to display house number
  output$selected_var <- renderText({ 
    paste("Data for residential house ",input$house_num, " is displayed")
  })
  
  #plot with
  v <- reactiveValues(data = NULL)
  
  observeEvent(input$dishwasher, {
    v$data <- myfiles[[input$house_num]]$dishwasher
  })
  
  observeEvent(input$washingmachine, {
    v$data <- myfiles[[input$house_num]]$washingmachine
  })  
  
  output$plot <- renderPlot({
    if (is.null(v$data)) return()
    plot(myfiles[[input$house_num]]$Date,v$data)

  })
}

# Run the application 
shinyApp(ui = ui, server = server)

