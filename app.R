library(shiny)
library(dplyr)
library(shinydashboard)
library(gridExtra)
library(grid)
library(ggplot2)

source("data/clean_data.R")

gender_options <- c("No Filter", "Female", "Male")
senior_options <- c("No Filter", "is Senior Citizen", "is not Senior Citizen")
relationship_options <- c("No Filter", "has Partner", "Single")
dep_options <- c("No Filter", "has Dependents", "no Dependents")
serv_options <- c("No Filter", "Yes", "No")

ui <- fluidPage(
  
  dashboardPage(
    dashboardHeader(title = "Filters"),
    dashboardSidebar( width = 160,
                      sidebarMenu(style = "position: fixed; width:150px;",
                                  selectInput("gender", 
                                              label = "Gender:",
                                              choices = c(gender_options), 
                                              selected = "No Filter"),
                                  selectInput("senior", 
                                              label = "Senior Citizen:",
                                              choices = c(senior_options), 
                                              selected = "No Filter"),
                                  selectInput("relationship", 
                                              label = "Relationship Status:",
                                              choices = c(relationship_options), 
                                              selected = "No Filter"),
                                  selectInput("dependents", 
                                              label = "Dependents:",
                                              choices = c(dep_options), 
                                              selected = "No Filter")
                      )

    ),
    
    dashboardBody(
      fluidRow(
        box(title = "Cutomer Demographic Size", width = NULL, solidHeader = TRUE, status = "primary", color = "#286192",
            fluidRow(
              box(align = "center",
                  title = NULL, 
                  width = 12,
                  status = NULL,
                  box(width = NULL, plotOutput("plot1", height = "150px")))
            ),
            fluidRow(
              column(width = 4,
                     box(title = "All Customers", width = NULL, solidHeader = TRUE, status = "primary",
                         box(title = "Number of Customers", width = NULL, status = "primary", infoBoxOutput("customerCountNoFilter")),
                         box(title = "Percent of Total Customers", width = NULL, status = "primary", infoBoxOutput("percentTotalNoFilter"))
                     )),
              column(width = 4,
                     box(title = "Customers Stayed", width = NULL, solidHeader = TRUE, status = "success",
                         box(title = "Number of Customers", width = NULL, status = "success", infoBoxOutput("customerCountStayed")),
                         box(title = "Percent of Total Customers", width = NULL, status = "success", infoBoxOutput("percentTotalStayed"))
                     )),
              column(width = 4,
                     box(title = "Customers Left", width = NULL, solidHeader = TRUE, status = "warning",
                         box(title = "Number of Customers", width = NULL, status = "warning", infoBoxOutput("customerCountChurn")),
                         box(title = "Percent of Total Customers", width = NULL, status = "warning", infoBoxOutput("percentTotalChurn"))
                     ))
            )
      )),
      fluidRow(
        box(title = "Demographic Spending", width = NULL, solidHeader = TRUE, status = "primary",
            fluidRow(
              tabBox(width = NULL, title = "Billing", side = "right",
                     tabPanel("Contract Type",
                              fluidRow(
                                box(width = NULL, title = NULL, status = NULL, plotOutput("plot3"))
                              )
                     ),
                     tabPanel("Payment Methods",
                              fluidRow(
                                box(width = NULL, title = NULL, status = NULL, plotOutput("plot4"))
                              )
                     ),
                      tabPanel("Paperless Billing",
                               fluidRow(
                                  box(width = NULL, title = NULL, status = NULL, plotOutput("plot6"))
                                )
                     )
                )
            ),
            fluidRow(
              tabBox(width = NULL, title = "Charges", side = "right",
                     tabPanel("Monthly Charges",
                              fluidRow(
                                box(width = NULL, title = NULL, status = NULL, plotOutput("plot9"))
                              )
                     ),
                     tabPanel("Total Charges",
                              fluidRow(
                                box(width = NULL, title = NULL, status = NULL, plotOutput("plot8"))
                              )
                     )
              )
            ),
        column(width = 4,
               box(title = "All Customers", width = NULL, solidHeader = TRUE, status = "primary",
                   box(title = "Total Monthly Charges", width = NULL, status = "primary", infoBoxOutput("totalMonthlyChargesNoFilter")),
                   box(title = "Average Monthly Charges", width = NULL, status = "primary", infoBoxOutput("avgMonthlyChargesNoFilter"))               )),
        column(width = 4,
               box(title = "Customers Stayed", width = NULL, solidHeader = TRUE, status = "success",
                   box(title = "Total Monthly Charges", width = NULL, status = "success", infoBoxOutput("totalMonthlyChargesStayed")),
                   box(title = "Average Monthly Charges", width = NULL, status = "success", infoBoxOutput("avgMonthlyChargesStayed"))               )),
        column(width = 4,
               box(title = "Customers Left", width = NULL, solidHeader = TRUE, status = "warning",
                   box(title = "Total Monthly Charges", width = NULL, status = "warning", infoBoxOutput("totalMonthlyChargesChurn")),
                   box(title = "Average Monthly Charges", width = NULL, status = "warning", infoBoxOutput("avgMonthlyChargesChurn"))               ))
      )),
      fluidRow(
        box(title = "Demographic Tenure", width = NULL, solidHeader = TRUE, status = "primary",
            fluidRow(
              tabBox(width = NULL, title = "Tenure", side = "right",
                     tabPanel("Histogram",
                              fluidRow(
                                box(width = 12, title = "Months with Company", plotOutput("plot2"))
                              )
                     ),
                     tabPanel("Density Chart",
                              fluidRow(
                                box(width = 12, title = "Months with Company", plotOutput("plot5"))
                              )
                     )
              )
            ),
            fluidRow(
              column(width = 4,
                     box(title = "All Customers", width = NULL, solidHeader = TRUE, status = "primary",
                         box(title = "Average Number of Months with Company", width = NULL, status = "primary", infoBoxOutput("avgMonthsNoFilter"))
                     )),
              column(width = 4,
                     box(title = "Customers Stayed", width = NULL, solidHeader = TRUE, status = "success",
                         box(title = "Average Number of Months with Company", width = NULL, status = "success", infoBoxOutput("avgMonthsStayed"))
                     )),
              column(width = 4,
                     box(title = "Customers Left", width = NULL, solidHeader = TRUE, status = "warning",
                         box(title = "Average Number of Months with Company", width = NULL, status = "warning", infoBoxOutput("avgMonthsChurn"))
                     ))
            )
        )),
      fluidRow(
        box(title = "Entertainment Services", width = NULL, solidHeader = TRUE, status = "primary",
            fluidRow(
              tabBox(width = NULL, title = "Type of Service", side = "right",
                     tabPanel("Internet Service",
                              fluidRow(
                                box(width = 12, title = "Internet Service", plotOutput("plot10"))
                              )
                     ),
                     tabPanel("Phone Service",
                              fluidRow(
                                box(width = 12, title = "Phone Service", plotOutput("plot11"))
                              )
                     ),
                     tabPanel("Streaming Service",
                              fluidRow(
                                box(width = 12, title = "Streaming Service", plotOutput("plot12"))
                              )
                     )
              )
            )
        ))
    )
   )
 )

server <- function(input, output) {
  
  rv = reactiveValues()
  rv$dataset=dataset
  
  observe({
    rv$dataset = dataset %>% filter(if(input$gender == 'No Filter'){gender %in% gender_options} else {gender == input$gender}) %>%
      filter(if(input$senior == 'No Filter'){SeniorCitizen %in% senior_options} else {SeniorCitizen == input$senior}) %>%
      filter(if(input$relationship == 'No Filter'){Partner %in% relationship_options} else {Partner == input$relationship}) %>%
      filter(if(input$dependents == 'No Filter'){Dependents %in% dep_options} else {Dependents == input$dependents}) 

    rv$churn = filter(rv$dataset, Churn == 'Churn')
    rv$stayed = filter(rv$dataset, Churn == 'Stayed')

    rv$dim = dim(rv$dataset)
    rv$dimStayed = dim(rv$stayed)
    rv$dimChurn = dim(rv$churn)
  })
  
  output$customerCountNoFilter <- renderInfoBox({
    x = format(rv$dim[1], big.mark = ",")
    infoBox("Customer Count", x,
      color = "light-blue",
      icon = icon("users")
    )
  })
  output$customerCountStayed <- renderInfoBox({
    x = format(rv$dimStayed[1], big.mark = ",")
    infoBox("Customer Count", x,
            color = "green",
            icon = icon("users")
    )
  })
  output$customerCountChurn <- renderInfoBox({
    x = format(rv$dimChurn[1], big.mark = ",")
    infoBox("Customer Count",x,
            color = "orange",
            icon = icon("users")
    )
  })
  output$percentTotalNoFilter <- renderInfoBox({
    x = format(round(rv$dim[1]/dim(dataset)*100, 2))
    infoBox( "Percent of Customers", paste(x, "%"),
             color = "light-blue",
             icon = icon("percentage")
    )
  })
  output$percentTotalStayed <- renderInfoBox({
    x = format(round(rv$dimStayed[1]/dim(dataset)*100, 2))
    infoBox( "Percent of Customers", paste(x, "%"),
             color = "green",
             icon = icon("percentage")
    )
  })
  output$percentTotalChurn<- renderInfoBox({
    x = format(round(rv$dimChurn[1]/dim(dataset)*100, 2))
    infoBox( "Percent of Customers", paste(x, "%"),
             color = "orange",
             icon = icon("percentage")
    )
  })
  output$totalMonthlyChargesNoFilter <- renderInfoBox({
    x = format(round(sum(rv$dataset$MonthlyCharges),2), big.mark = ",")
    infoBox( "Total Monthly", paste("$",x),
             color = "light-blue",
             icon = icon("dollar-sign")
    )
  })
  output$totalMonthlyChargesStayed <- renderInfoBox({
    x = format(round(sum(rv$stayed$MonthlyCharges),2), big.mark = ",")
    infoBox( "Total Monthly", paste("$",x),
             color = "green",
             icon = icon("dollar-sign")
    )
  })
  output$totalMonthlyChargesChurn <- renderInfoBox({
    x = format(round(sum(rv$churn$MonthlyCharges),2), big.mark = ",")
    infoBox( "Total Monthly", paste("$",x),
             color = "orange",
             icon = icon("dollar-sign")
    )
  })
  output$avgMonthlyChargesNoFilter <- renderInfoBox({
    x = format(round(mean(rv$dataset$MonthlyCharges),2))
    infoBox("Average Monthly", paste("$",x),
             color = "light-blue",
             icon = icon("dollar-sign")
    )
  })
  output$avgMonthlyChargesStayed <- renderInfoBox({
    x = format(round(mean(rv$stayed$MonthlyCharges),2))
    infoBox("Average Monthly", paste("$",x),
            color = "green",
            icon = icon("dollar-sign")
    )
  })
  output$avgMonthlyChargesChurn <- renderInfoBox({
    x = format(round(mean(rv$churn$MonthlyCharges),2))
    infoBox("Average Monthly", paste("$",x),
            color = "orange",
            icon = icon("dollar-sign")
    )
  })
  output$avgMonthsNoFilter <- renderInfoBox({
    x = format(round(mean(rv$dataset$tenure),2))
    infoBox("Avg Months", paste(x, "months"),
             color = "light-blue",
            icon = icon("calendar-alt")
    )
  })
  output$avgMonthsStayed <- renderInfoBox({
    x = format(round(mean(rv$stayed$tenure),2))
    infoBox("Avg Months", paste(x, "months"),
            color = "green",
            icon = icon("calendar-alt")
    )
  })
  output$avgMonthsChurn <- renderInfoBox({
    x = format(round(mean(rv$churn$tenure),2))
    infoBox("Avg Months", paste(x, "months"),
            color = "orange",
            icon = icon("calendar-alt")
    )
  })
  
### Plots  
  output$plot1 <- renderPlot({

    plot1 <- ggplot(rv$dataset, aes(x = Churn, fill = Churn)) +
      geom_bar(position = "dodge", fill = c("#f0ad4e", "#5cb85c"), color = c("#ba7412", "#376e37")) +
      coord_flip() +
      geom_text(aes(label = paste(round(..count../nrow(rv$dataset)*100,2), "%")),
                stat = "count",
                position = 'dodge',
                hjust = -0.5,
                size = 3,
                inherit.aes = TRUE) +
      theme_minimal() +
      theme(legend.position = "none",
            axis.title=element_blank(),
            panel.border=element_blank())

    plot1
    })
  
  output$plot2 <- renderPlot({
    bar_fills <- c("orange", "#5cb85c")
    plot2 <- ggplot(rv$dataset, aes(x=tenure, fill= Churn))+
      geom_histogram(stat = 'bin',
                     bins = 50,
                     position = "dodge") +
      scale_fill_manual(values = bar_fills,
                        guide = "none") +
      xlab('Number of Months') +
      ylab('') +
      theme_minimal()
    plot2
  })
  # 
  output$plot3 <- renderPlot({

    p1 <- ggplot(rv$dataset, aes(x=Contract, fill = factor(Contract)))+
      geom_bar(position = "dodge",  fill = c("#5b94c5","#337ab7","#286192"), color = "#1e496d") +
      coord_flip() +
      geom_text(aes(label = paste(round(..count../nrow(rv$dataset)*100,2), "%")),
                stat = "count", position = "dodge", hjust = -0.1) +
      labs(title = "All Customers", fill = '')+
      theme_minimal() +
      theme(legend.position = "none",
            axis.ticks=element_blank(),
            axis.title=element_blank(),
            panel.grid=element_blank(),
            panel.border=element_blank())
    p2 <- ggplot(rv$stayed, aes(x=Contract, fill = factor(Contract)))+
      geom_bar(position = "dodge", fill = c("#7cc67c", "#5cb85c", "#499349"), color = ("#376e37")) +
      coord_flip() +
      geom_text(aes(label = paste(round(..count../nrow(rv$stayed)*100,2), "%")),
                stat = "count", position = "dodge",hjust = -0.1) +
      labs(title = "Customers Stayed", fill = '')+
      theme_minimal() +
      theme(legend.position = "none",
            axis.text.x = element_text(size = 10),
            axis.ticks=element_blank(),
            axis.title=element_blank(),
            panel.grid=element_blank(),
            panel.border=element_blank())
    p3 <- ggplot(rv$churn, aes(x=Contract, fill = factor(Contract)))+
      geom_bar(position = "dodge", fill = c("#f3bd71","#f0ad4e", "#d89b46"), color = "#ba7412") +
      coord_flip() +
      geom_text(aes(label = paste(round(..count../nrow(rv$churn)*100,2), "%")),
                stat = "count", position = "dodge", hjust = -0.1) +
      labs(title = "Customers Left", fill = '')+
      theme_minimal() +
      theme(legend.position = "none",
            axis.ticks=element_blank(),
            axis.title=element_blank(),
            panel.grid=element_blank(),
            panel.border=element_blank())
    plot3 <- grid.arrange(p1, p2, p3, ncol = 1)
    plot3
  })
  
  output$plot4 <- renderPlot({
    
    p1 <- ggplot(rv$dataset, aes(x=PaymentMethod, fill = factor(PaymentMethod)))+
      geom_bar(position = "dodge",  fill = c("#99bcdb","#5b94c5","#337ab7","#286192"), color = "#1e496d") +
      coord_flip() +
      geom_text(aes(label = paste(round(..count../nrow(rv$dataset)*100,2), "%")),
                stat = "count", position = "dodge", hjust = -0.1) +
      labs(title = "All Customers", fill = '')+
      theme_minimal() +
      theme(legend.position = "none",
            axis.ticks=element_blank(),
            axis.title=element_blank(),
            panel.grid=element_blank(),
            panel.border=element_blank())
    p2 <- ggplot(rv$stayed, aes(x=PaymentMethod, fill = factor(PaymentMethod)))+
      geom_bar(position = "dodge", fill = c("#addbad","#7cc67c", "#5cb85c", "#499349"), color = ("#376e37")) +
      coord_flip() +
      geom_text(aes(label = paste(round(..count../nrow(rv$stayed)*100,2), "%")),
                stat = "count", position = "dodge",hjust = -0.1) +
      labs(title = "Customers Stayed", fill = '')+
      theme_minimal() +
      theme(legend.position = "none",
            axis.text.x = element_text(size = 10),
            axis.ticks=element_blank(),
            axis.title=element_blank(),
            panel.grid=element_blank(),
            panel.border=element_blank())
    p3 <- ggplot(rv$churn, aes(x=PaymentMethod, fill = factor(PaymentMethod)))+
      geom_bar(position = "dodge", fill = c("#f7d6a6","#f3bd71","#f0ad4e", "#d89b46"), color = "#ba7412") +
      coord_flip() +
      geom_text(aes(label = paste(round(..count../nrow(rv$churn)*100,2), "%")),
                stat = "count", position = "dodge", hjust = -0.1) +
      labs(title = "Customers Left", fill = '')+
      theme_minimal() +
      theme(legend.position = "none",
            axis.ticks=element_blank(),
            axis.title=element_blank(),
            panel.grid=element_blank(),
            panel.border=element_blank())
    plot4 <- grid.arrange(p1, p2, p3, ncol = 1)
    plot4
  })

  output$plot5 <- renderPlot({
    bar_fills <- c("orange", "#5cb85c")
    plot5 <- ggplot(rv$dataset, aes(tenure, fill = Churn)) +
      geom_density(aes(alpha = 1/100)) +
      scale_fill_manual(values = bar_fills,
                        guide = "none") +
      xlab('Number of Months') +
      theme_minimal()

    plot5
  })
  
  output$plot6 <- renderPlot({
    
    p1 <- ggplot(rv$dataset, aes(x=PaperlessBilling, fill = factor(PaperlessBilling)))+
      geom_bar(position = "dodge",  fill = c("#337ab7","#286192"), color = "#1e496d") +
      coord_flip() +
      geom_text(aes(label = paste(round(..count../nrow(rv$dataset)*100,2), "%")),
                stat = "count", position = "dodge", hjust = -0.1) +
      labs(title = "All Customers", fill = '')+
      theme_minimal() +
      theme(legend.position = "none",
            axis.ticks=element_blank(),
            axis.title=element_blank(),
            panel.grid=element_blank(),
            panel.border=element_blank())
    p2 <- ggplot(rv$stayed, aes(x=PaperlessBilling, fill = factor(PaperlessBilling)))+
      geom_bar(position = "dodge", fill = c("#5cb85c", "#499349"), color = ("#376e37")) +
      coord_flip() +
      geom_text(aes(label = paste(round(..count../nrow(rv$stayed)*100,2), "%")),
                stat = "count", position = "dodge",hjust = -0.1) +
      labs(title = "Customers Stayed", fill = '')+
      theme_minimal() +
      theme(legend.position = "none",
            axis.text.x = element_text(size = 10),
            axis.ticks=element_blank(),
            axis.title=element_blank(),
            panel.grid=element_blank(),
            panel.border=element_blank())
    p3 <- ggplot(rv$churn, aes(x=PaperlessBilling, fill = factor(PaperlessBilling)))+
      geom_bar(position = "dodge", fill = c("#f0ad4e", "#d89b46"), color = "#ba7412") +
      coord_flip() +
      geom_text(aes(label = paste(round(..count../nrow(rv$churn)*100,2), "%")),
                stat = "count", position = "dodge", hjust = -0.1) +
      labs(title = "Customers Left", fill = '')+
      theme_minimal() +
      theme(legend.position = "none",
            axis.ticks=element_blank(),
            axis.title=element_blank(),
            panel.grid=element_blank(),
            panel.border=element_blank())
    plot6 <- grid.arrange(p1, p2, p3, ncol = 1)
    plot6
  })
  
  output$plot7 <- renderPlot({
    
    p1 <- ggplot(rv$dataset, aes(x=PaperlessBilling, fill = factor(PaperlessBilling)))+
      geom_bar(position = "dodge",  fill = c("#337ab7","#286192"), color = "#1e496d") +
      coord_flip() +
      geom_text(aes(label = paste(round(..count../nrow(rv$dataset)*100,2), "%")),
                stat = "count", position = "dodge", hjust = -0.1) +
      labs(title = "All Customers", fill = '')+
      theme_minimal() +
      theme(legend.position = "none",
            axis.ticks=element_blank(),
            axis.title=element_blank(),
            panel.grid=element_blank(),
            panel.border=element_blank())
    p2 <- ggplot(rv$stayed, aes(x=PaperlessBilling, fill = factor(PaperlessBilling)))+
      geom_bar(position = "dodge", fill = c("#5cb85c", "#499349"), color = ("#376e37")) +
      coord_flip() +
      geom_text(aes(label = paste(round(..count../nrow(rv$stayed)*100,2), "%")),
                stat = "count", position = "dodge",hjust = -0.1) +
      labs(title = "Customers Stayed", fill = '')+
      theme_minimal() +
      theme(legend.position = "none",
            axis.text.x = element_text(size = 10),
            axis.ticks=element_blank(),
            axis.title=element_blank(),
            panel.grid=element_blank(),
            panel.border=element_blank())
    p3 <- ggplot(rv$churn, aes(x=PaperlessBilling, fill = factor(PaperlessBilling)))+
      geom_bar(position = "dodge", fill = c("#f0ad4e", "#d89b46"), color = "#ba7412") +
      coord_flip() +
      geom_text(aes(label = paste(round(..count../nrow(rv$churn)*100,2), "%")),
                stat = "count", position = "dodge", hjust = -0.1) +
      labs(title = "Customers Left", fill = '')+
      theme_minimal() +
      theme(legend.position = "none",
            axis.ticks=element_blank(),
            axis.title=element_blank(),
            panel.grid=element_blank(),
            panel.border=element_blank())
    plot7 <- grid.arrange(p1, p2, p3, ncol = 1)
    plot7
  })
  output$plot8 <- renderPlot({
    plot8 <- ggplot(rv$dataset, aes(Churn %in% c("Stayed", "Churn"))) +
      geom_point(aes(x = tenure, y = TotalCharges, color= Churn)) +
      scale_color_manual(values =  c("orange", "#5cb85c")) +
      xlab("Months with company")+
      ylab("Total Charges (USD)") +
      theme_minimal()
    plot8
  })
  output$plot9 <- renderPlot({
    plot9 <- ggplot(rv$dataset, aes(Churn %in% c("Stayed", "Churn"))) +
      geom_point(aes(x = tenure, y = MonthlyCharges, color= Churn)) +
      scale_color_manual(values =  c("orange", "#5cb85c")) +
      xlab("Months with company")+
      ylab("Monthly Charges (USD)") +
      theme_minimal()
    plot9
  })
  output$plot10 <- renderPlot({
    
    p1 <- ggplot(rv$dataset, aes(x=InternetService, fill = factor(InternetService)))+
      geom_bar(position = "dodge",  fill = c("#99bcdb","#5b94c5","#286192"), color = "#1e496d") +
      coord_flip() +
      geom_text(aes(label = paste(round(..count../nrow(rv$dataset)*100,2), "%")),
                stat = "count", position = "dodge", hjust = -0.1) +
      labs(title = "All Customers", fill = '')+
      theme_minimal() +
      theme(legend.position = "none",
            axis.ticks=element_blank(),
            axis.title=element_blank(),
            panel.grid=element_blank(),
            panel.border=element_blank())
    p2 <- ggplot(rv$stayed, aes(x=InternetService, fill = factor(InternetService)))+
      geom_bar(position = "dodge",fill = c("#addbad","#7cc67c", "#499349"), color = ("#376e37")) +
      coord_flip() +
      geom_text(aes(label = paste(round(..count../nrow(rv$stayed)*100,2), "%")),
                stat = "count", position = "dodge",hjust = -0.1) +
      labs(title = "Customers Stayed", fill = '')+
      theme_minimal() +
      theme(legend.position = "none",
            axis.text.x = element_text(size = 10),
            axis.ticks=element_blank(),
            axis.title=element_blank(),
            panel.grid=element_blank(),
            panel.border=element_blank())
    p3 <- ggplot(rv$churn, aes(x=InternetService, fill = factor(InternetService)))+
      geom_bar(position = "dodge", fill = c("#f7d6a6","#f3bd71","#d89b46"), color = "#ba7412") +
      coord_flip() +
      geom_text(aes(label = paste(round(..count../nrow(rv$churn)*100,2), "%")),
                stat = "count", position = "dodge", hjust = -0.1) +
      labs(title = "Customers Left", fill = '')+
      theme_minimal() +
      theme(legend.position = "none",
            axis.ticks=element_blank(),
            axis.title=element_blank(),
            panel.grid=element_blank(),
            panel.border=element_blank())
    plot10 <- grid.arrange(p1, p2, p3, ncol = 1)

    plot10
  })
  output$plot11 <- renderPlot({
    p1 <- ggplot(rv$dataset, aes(x=PhoneServ, fill = factor(PhoneServ)))+
      geom_bar(position = "dodge",  fill = c("#99bcdb","#5b94c5","#286192"), color = "#1e496d") +
      coord_flip() +
      geom_text(aes(label = paste(round(..count../nrow(rv$dataset)*100,2), "%")),
                stat = "count", position = "dodge", hjust = -0.1) +
      labs(title = "All Customers", fill = '')+
      theme_minimal() +
      theme(legend.position = "none",
            axis.ticks=element_blank(),
            axis.title=element_blank(),
            panel.grid=element_blank(),
            panel.border=element_blank())
    p2 <- ggplot(rv$stayed, aes(x=PhoneServ, fill = factor(PhoneServ)))+
      geom_bar(position = "dodge",fill = c("#addbad","#7cc67c", "#499349"), color = ("#376e37")) +
      coord_flip() +
      geom_text(aes(label = paste(round(..count../nrow(rv$stayed)*100,2), "%")),
                stat = "count", position = "dodge",hjust = -0.1) +
      labs(title = "Customers Stayed", fill = '')+
      theme_minimal() +
      theme(legend.position = "none",
            axis.text.x = element_text(size = 10),
            axis.ticks=element_blank(),
            axis.title=element_blank(),
            panel.grid=element_blank(),
            panel.border=element_blank())
    p3 <- ggplot(rv$churn, aes(x=PhoneServ, fill = factor(PhoneServ)))+
      geom_bar(position = "dodge", fill = c("#f7d6a6","#f3bd71","#d89b46"), color = "#ba7412") +
      coord_flip() +
      geom_text(aes(label = paste(round(..count../nrow(rv$churn)*100,2), "%")),
                stat = "count", position = "dodge", hjust = -0.1) +
      labs(title = "Customers Left", fill = '')+
      theme_minimal() +
      theme(legend.position = "none",
            axis.ticks=element_blank(),
            axis.title=element_blank(),
            panel.grid=element_blank(),
            panel.border=element_blank())
    plot11 <- grid.arrange(p1, p2, p3, ncol = 1)
    plot11
  })
  output$plot12 <- renderPlot({
    p1 <- ggplot(rv$dataset, aes(x=Streaming, fill = factor(Streaming)))+
      geom_bar(position = "dodge",  fill = c("#99bcdb","#5b94c5","#337ab7","#286192"), color = "#1e496d") +
      coord_flip() +
      geom_text(aes(label = paste(round(..count../nrow(rv$dataset)*100,2), "%")),
                stat = "count", position = "dodge", hjust = -0.1) +
      labs(title = "All Customers", fill = '')+
      theme_minimal() +
      theme(legend.position = "none",
            axis.ticks=element_blank(),
            axis.title=element_blank(),
            panel.grid=element_blank(),
            panel.border=element_blank())
    p2 <- ggplot(rv$stayed, aes(x=Streaming, fill = factor(Streaming)))+
      geom_bar(position = "dodge",fill = c("#addbad","#7cc67c", "#5cb85c", "#499349"), color = ("#376e37")) +
      coord_flip() +
      geom_text(aes(label = paste(round(..count../nrow(rv$stayed)*100,2), "%")),
                stat = "count", position = "dodge",hjust = -0.1) +
      labs(title = "Customers Stayed", fill = '')+
      theme_minimal() +
      theme(legend.position = "none",
            axis.text.x = element_text(size = 10),
            axis.ticks=element_blank(),
            axis.title=element_blank(),
            panel.grid=element_blank(),
            panel.border=element_blank())
    p3 <- ggplot(rv$churn, aes(x=Streaming, fill = factor(Streaming)))+
      geom_bar(position = "dodge",fill = c("#f7d6a6","#f3bd71","#f0ad4e", "#d89b46"), color = "#ba7412") +
      coord_flip() +
      geom_text(aes(label = paste(round(..count../nrow(rv$churn)*100,2), "%")),
                stat = "count", position = "dodge", hjust = -0.1) +
      labs(title = "Customers Left", fill = '')+
      theme_minimal() +
      theme(legend.position = "none",
            axis.ticks=element_blank(),
            axis.title=element_blank(),
            panel.grid=element_blank(),
            panel.border=element_blank())
    plot12 <- grid.arrange(p1, p2, p3, ncol = 1)
    plot12
  })
}

# Run the application 
shinyApp(ui, server)

