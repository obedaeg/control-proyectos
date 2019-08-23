mc.get_time <- function(df){
  df <- as.integer(df)
  mn <- (df[1] + 4*df[2] + df[3])/6
  s <- abs((df[3] - df[1])/6)
  
  time <- rnorm(1, mean=mn, sd=s)
  
  return(time)
}

mc.simular <- function(n, df){
  if(nrow(df) ==0) return(data.frame())
  
  result <<- data.frame()  
  sapply(1:n, function(x){
    
    times <- apply(df[,2:4], mc.get_time, MARGIN=1)
    result <<- rbind(result, c(times, sum(times)))
  })
  
  
  colnames(result) <- c(paste0("actividad_", 1:ncol(result[,-1])), "total")
  return(result)
  
}

