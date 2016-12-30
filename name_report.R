

name_report <- function(name_drug, name_cycle, name_interval, name_genre) {

  if (name_drug == "can") {name_drug <- "cannabis"}
  if (name_drug == "coc") {name_drug <- "cocaine"}
  if (name_drug == "amp") {name_drug <- "amphetamines"}
  if (name_drug == "ecs") {name_drug <- "ecstasy"}
  if (name_drug == "lsd") {name_drug <- "lsd"}
  if (name_drug == "any") {name_drug <- "any illegal drugs"}
  if (name_drug == "alc") {name_drug <- "alcohol"}
  if (name_drug == "tob") {name_drug <- "tobacco"}
  
  if (name_cycle == "life") {name_cycle <- "lifetime"}
  if (name_cycle == "year") {name_cycle <- "last year"}
  if (name_cycle == "month") {name_cycle <- "last month"}

  if (name_interval == "all") {name_interval <- "(15-64 yr.)"}
  if (name_interval == "young") {name_interval <- "(15-34 yr.)"}
  if (name_interval == "15") {name_interval <- "(15-24 yr.)"}
  if (name_interval == "25") {name_interval <- "(25-34 yr.)"}
  if (name_interval == "35") {name_interval <- "(35-54 yr.)"}
  if (name_interval == "45") {name_interval <- "(45-54 yr.)"}
  if (name_interval == "55") {name_interval <- "(55-64 yr.)"}
  
  if (name_genre == "fe") {name_genre <- "female"}
  if (name_genre == "ma") {name_genre <- "male"}
  if (name_genre == "to") {name_genre <- "total"}
  
  name_result <- paste("Consume of", name_drug, "in", name_cycle, 
                       "in", name_genre, "population", name_interval)
  
  return(name_result)
}