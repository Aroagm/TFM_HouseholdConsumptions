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

temp = list.files(path = data_path,pattern="^residential[0-6].csv$", full.names = TRUE)
myfiles = lapply(temp, read.delim, sep=",")

prices_cluster = read.csv(paste(data_path,"/Cluster_prices.csv", sep=""))

temp_w = list.files(path = data_path,pattern="^residential[0-6]_w",full.names = TRUE)
recomm_w = lapply(temp_w, read.delim, sep=",")

temp_d = list.files(path = data_path,pattern="^residential[0-6]_d",full.names = TRUE)
recomm_d = lapply(temp_d, read.delim, sep=",")

#Function to show the use pattern

use_pattern <- function(df, appliance,day_type){
  #Create a column to know if it is a weekday(1), saturday(2) or sunday(3)
  df$day_type<-ifelse(as.POSIXlt(df$Datetime)$wday <= 4,1,
                      ifelse(as.POSIXlt(df$Datetime)$wday ==5 ,2,3))
  col_name <- paste(appliance,"_dif", sep="")
  data_filter <- df[df[, col_name]!= 0, ]
  data_out <- data_filter[data_filter[, 'day_type']== day_type, ]  %>%
    group_by(Hour) %>%
    summarize(total.count=n())
  return(plot(data_out,type="l", main = "Yearly use pattern \nfor the type of day selected"))
}

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel(h1("Household Consumptions Recommendations", align="center")),
  
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
                 ))),
                 
                 selectInput("day_type",
                             h3("Choose the type of day"),
                             choices = c("Weekday" = 1,
                                        "Saturday" = 2,
                                        "Sunday" = 3)
                             ),
                 sliderInput("hour_num",
                             h3("Select the hour", align="center"),
                             min = 0,
                             max = 23,
                             value = 0)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(h3(textOutput("data_app"),align="center"),
                 fluidRow(column(width= 6,plotOutput("plot")),
                          column(width= 6,plotOutput("plot2"))),
                 fluidRow(column(width=12,h3(textOutput("day_var")))
                          )
    )
  )
)


# Define server logic required to draw a histogram
server <- function(input, output) {

  
  #Consumption plot
  v <- reactiveValues(data = myfiles[[1]]$dishwasher)
  
  observeEvent(input$dishwasher, {
    v$data <- myfiles[[input$house_num]]$dishwasher
  })
  
  observeEvent(input$washingmachine, {
    v$data <- myfiles[[input$house_num]]$washingmachine
  })  
  
  output$plot <- renderPlot({
    if (is.null(v$data)) return()
    plot(myfiles[[input$house_num]]$Date,v$data, 
         main = paste("Energy Consumption  \nfor the house",input$house_num),
         xlab = "Date",
         ylab = "Energy (kWh)" )
    
  })
  
  #Name of the appliance depending on selection
  name_app <- reactiveValues(data2 = "dishwasher")
  
  observeEvent(input$dishwasher, {
    name_app$data2 <- paste("dishwasher")
  })
  
  observeEvent(input$washingmachine, {
    name_app$data2 <- paste("washingmachine")
  })
  
  output$data_app <- renderText({paste("Data visualization for the",name_app$data2)
  })
  
  #use patter plot
  output$plot2 <- renderPlot({use_pattern(myfiles[[input$house_num]], name_app$data2,input$day_type)
    
  })
  

  #construction of data extraction for recomm 
  #select dataframe depending on appliance
  df_recomm <- reactiveValues(data2 = recomm_d[[1]])
  
  observeEvent(input$dishwasher, {
    df_recomm$data2 <- recomm_d[[input$house_num]]

  })
  
  observeEvent(input$washingmachine, {
    df_recomm$data2 <- recomm_w[[input$house_num]]

  })
  
  output$day_var <- renderText({col_besth <- paste("Best_h", input$day_type, sep="")
                                col_savings <- paste("Final_Savings", input$day_type, sep="")
                                df_recomm<- df_recomm$data2
                                value_type <- df_recomm[[col_besth]][df_recomm$Hour==input$hour_num]
                                value_savings <- df_recomm[[col_savings]][df_recomm$Hour==input$hour_num]
                                value_text <- if (value_type == 0) {paste("There is no recommendation for that hour since the use in the previous/next hour does not imply savings")} else 
                                  if (value_type == 1) {paste("If the use of the", name_app$data2, "is changed to the previous hour, the savings would be", value_savings ,"for the whole year")} else 
                                    paste("If the use of the", name_app$data2, "is changed to the next hour, the savings would be", as.integer(value_savings) ,"for the whole year")
                                value_text
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
