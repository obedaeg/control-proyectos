#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)
library(ggplot2)
library(gplots)
source('montecarlo.R')
source('curvas.R')


# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
    
    observeEvent(input$run,{
        df <- mc.simular(input$simulations, rv$df)
        output$tbl_simulacion <- DT::renderDataTable(df, 
                                                     options=list(leghtChange=FALSE))
        output$distPlot <- renderPlot({
            
            # generate bins based on input$bins from ui.R
            plot(df$total, main="Simluacion de Montecarlo", sub=paste0("Tiempo Esperado del proyecto: ", mean(df$total)),
                 xlab="Simulaciones", ylab="Tiempo",)
            lines(df$total)
            abline(h=mean(df$total), color="blue")
        })
    })
    
    rv <- reactiveValues(df=data.frame("actividad" =c(), "tp" = c(), "te" =c(), "to"  =c()))
    
    append_data <- eventReactive(input$add_button,{
        tmp <- data.frame("actividad" = paste0("actividad ", nrow(rv$df)+1), 
                          "tp" = as.numeric(input$time_pesimist), 
                          "te" =as.numeric(input$time_expected), "to"  = as.numeric(input$time_optimist))
        rv$df <- rbind(rv$df, tmp)
    })
    
    output$tbl_activities <- DT::renderDataTable(append_data(),
                                                 options=list(leghtChange=FALSE))
    
    
    observeEvent(input$ca_run,{
        df <- ca.curva_aprendizaje(input$ca_tasa_aprendizaje, input$ca_unidades_a_calcular, input$ca_tiempo_primera_unidad)
        
        output$ca_tbl_tiempos <- DT::renderDataTable(df, 
                                                     options=list(leghtChange=FALSE))
        output$ca_plot <- renderPlot({
            
            # generate bins based on input$bins from ui.R
            df %>%  ggplot(aes(x = unidad, y = tiempo)) + 
                geom_point() +
                geom_line()
        })
    })
    
    
    
    

    
})
