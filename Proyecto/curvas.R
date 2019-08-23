ca.curva_aprendizaje <- function(tasa, unidad, tiempo){
  units <- c(1:unidad)
  b <- log10(tasa/100)/log10(2)
  dataset <- data.frame(unidad = c(), tiempo = c())
  for(unit in units){
    yx <- tiempo * (unit^b)
    aux_df <- data.frame(unidad = unit, tiempo = yx)
    dataset <- rbind(dataset, aux_df)
  }
  return(dataset)
}


