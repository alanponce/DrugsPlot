
shinyServer(function(input, output) {
  
  # Load functions
  
  source('select_column.R')
  source('name_report.R')
  
  
  # Obtaining the four different graphics: 
  # (map, boxplot of consume, bar plot of consume, bar plot of samples)
  
  start_function <- reactive({
    
    select_column(data_map, data_consume, data_sample,
                   input$select_drug, input$select_drug_cycle, 
                   input$select_drug_interval, input$select_drug_genre)
    
  })
  
  # Generating the title of Rmarkdown report
  
  name_report2 <- reactive({
    
    name_report(input$select_drug, input$select_drug_cycle, input$select_drug_interval, 
                input$select_drug_genre)
    
    
  })
  
  # OUTPUT - MAP
  
  output$map <- renderPlot({
    
    start_function()[[1]]
    
  })
  
  # OUTPUT - BAR PLOT OF SAMPLE USED
  
  output$sample <- renderPlot({
    
    start_function()[[2]]
  })
  
  # OUTPUT - BAR PLOT OF CONSUME
  
  output$map_numeric <- renderPlot({
    
    start_function()[[3]]
  })
  
  # OUTPUT - INTERACTIVE BOXPLOT
  
  output$map_boxplot <- renderPlotly({
    
    box_graphic <- start_function()[[4]]
    
    p <- ggplotly(box_graphic)
    q <- plotly_build(p)
    
    # Filtering countries with available information in that condition selected
    
    drug_result_2 <- filter(data_consume, Country %in% c(as.character(data_sample$Country)))
    
    # Assignment of the label Country and Percentage of consume to every point of Boxplot.
    
    q$x$data[1][[1]]$text <- paste0("Country: ", as.character(drug_result_2$Country),
                                    "<br>", "Percentage: ", q$x$data[1][[1]]$y, "%")
    q
    
  })
  
  output$downloadData <- downloadHandler(
    filename = "selected_data.csv",
    
    content = function(file) {
      name_down <- paste(input$select_drug, input$select_drug_cycle, 
                         input$select_drug_interval, input$select_drug_genre, sep = "_")
      data_down <- select(drug_result_2, Country, get(name_down))
      colnames(data_down)[2] <- name_report2()
      write.csv(data_down , file)
    }
  )
  
  output$downloadData2 <- downloadHandler(
    filename = "drugsplot_report.html",
    
    content = function(file) {
      
      out <- render('drugsplot_report.Rmd', html_pretty(), "drugsplot_report.html")
      file.rename(out, file)
    }
  )
  
  
})
