#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    tabsetPanel(
        tabPanel("Simulacion de Montecarlo", # Application title
                 # Application title
                 titlePanel("Simulacion de Montecarlo"),
                 
                 # Sidebar with a slider input for number of bins
                 sidebarLayout(
                     sidebarPanel(
                         "Actividades",
                         numericInput("time_pesimist", "Tiempo Pesimista:" , value=1, min = 1, max = 100, step = 1),
                         numericInput("time_expected", "Tiempo Esperado:" , value=2, min = 1, max = 100, step = 1),
                         numericInput("time_optimist", "Tiempo Optimista:" , value=3, min = 1, max = 100, step = 1),
                         actionButton("add_button", "Agregar"),
                         
                         numericInput("simulations", "Simulaciones:" , value=100, min = 1, max = 100000, step = 100),
                         actionButton("run", "Correr Simulacion"),
                         DT::dataTableOutput("tbl_activities")
                         
                     ),
                     
                     # Show a plot of the generated distribution
                     mainPanel(
                         DT::dataTableOutput("tbl_simulacion"),
                         plotOutput("distPlot")
                         
                     )
                 )
        ),
        tabPanel("Curvas de Aprendizaje", # Application title
                 # Application title
                 titlePanel("Curvas de Aprendizaje"),
                 
                 # Sidebar with a slider input for number of bins
                 sidebarLayout(
                     sidebarPanel(
                         numericInput("ca_tasa_aprendizaje", "Tasa de Aprendizaje:" , value=1, min = 1, max = 100, step = 1),
                         numericInput("ca_tiempo_primera_unidad", "Tiempo Primera Unidad:" , value=1, min = 1, max = 1000000, step = 1),
                         numericInput("ca_unidades_a_calcular", "Unidades a Calcular:" , value=1, min = 1, max = 300, step = 1),
                         actionButton("ca_run", "Calcular")
                         
                         
                     ),
                     
                     # Show a plot of the generated distribution
                     mainPanel(
                         DT::dataTableOutput("ca_tbl_tiempos"),
                         plotOutput("ca_plot")
                         
                     )
                 )
        )
    )
))
