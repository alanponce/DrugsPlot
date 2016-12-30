select_column <- function(map_result_mod, map_data, sample_result,
                          type_drug, type_cycle, type_age, type_genre) {
  
  Value <- paste(type_drug, type_cycle, type_age , type_genre , sep = "_")
  
  map_data2 <- map_data %>%
    select(id, get(Value))
  map_result <- left_join(map_result_mod, map_data2, "id" )
  Value_sample <- paste(type_drug, type_cycle, type_age , sep = "_")
  
  # MAP WITH CONSUME INFORMATION
  
  map <- ggplot() +
    geom_polygon(data = map_result, 
                 aes(x = long, y = lat, group = group, 
                     fill =  get(Value)), 
                 color = "black", size = 0.25) + 
    coord_map() +
    theme_classic() +
    theme(axis.line=element_blank(),
          axis.text.x=element_blank(),
          axis.text.y=element_blank(),
          axis.ticks=element_blank(),
          axis.title.x=element_blank(),
          axis.title.y=element_blank()) +
    scale_y_continuous(limits=c(34,71)) +
    scale_x_continuous(limits=c(-10,45)) +
    scale_fill_gradient(low = "steelblue",  high = "red") +
    labs(fill = "Percentage (%)") +
    scale_fill_distiller(palette = "Spectral")
  
  # BAR PLOT WITH SAMPLE INFORMATION
  
  sample <- ggplot(data = sample_result, aes(x = factor(Country), 
                                             y = as.numeric(as.character(get(Value_sample))), 
                                             fill = as.numeric(as.character(get(Value_sample))))) +
    theme(axis.text.x = element_text(angle = 90, hjust = 1, size = 12), legend.position="none",
          axis.title.x = element_text(size = 16), axis.title.y = element_text(size = 16)) +
    geom_bar(stat="identity") +
    xlab("Country") +
    ylab("Sample size") +
    scale_fill_distiller(palette = "Accent")
  
  map_data <- filter(map_data, Country %in% c(as.character(sample_result$Country)))
  
  # BAR PLOT WITH CONSUME INFORMATION
  
  map_numeric <- ggplot(data = map_data, aes(x = factor(Country), 
                                             y = get(Value), fill = get(Value))) +
    theme(axis.text.x = element_text(angle = 90, hjust = 1, size = 12),
          axis.title.x = element_text(size = 16), axis.title.y = element_text(size = 16)) +
    geom_bar(stat="identity") +
    scale_y_continuous(limits=c(0,100)) +
    xlab("Country") +
    ylab("Percentage (%)") +
    labs(fill = "Percentage (%)") +
    scale_fill_distiller(palette = "Spectral")
  
  # BOXPLOT WITH CONSUME INFORMATION
  
  map_boxplot <- ggplot(data = map_data, aes(x = factor(""), 
                                             y = get(Value))) +
    theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
    geom_point(fill = "white", color = "black", shape=21) +
    geom_boxplot(fill = "steelblue", color = "black") +
    theme(legend.position="none", axis.text.x = element_text(angle = 90, hjust = 1, size = 12),
          axis.title.x = element_text(size = 15)) +
    scale_y_continuous(limits=c(0,100)) +
    ylab("Percentage (%)") +
    xlab("")
  
  
  result <- list("MAP" = map, "SAMPLE" = sample, "MAP_NUMERIC" = map_numeric,
                 "MAP_BOXPLOT" = map_boxplot)
  
  return(result)
}