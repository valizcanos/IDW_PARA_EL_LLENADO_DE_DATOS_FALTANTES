#' @name idw
#' @aliases idw
#' @title idw function
#' @description Function to fill missing values using idwimp package
#' @param data Data Frame with columns: x,y,z. x: longitudes, y: latitudes, and z precipitation values
#' @param p Power of the function, by default is 1
#' @param k Number of iterations by default is 1
#' @return Return a Data Frame
#' @examples
#'
#' #Example 1:
#' #precipitation measured in different weather stations
#' prec = c(259.6716, 262.9709, 288.2743, 307.5199, 328.9999)
#' #Longitudes of weather stations
#' lon = c(-77.925, -77.875, -77.825, -77.775, -77.725)
#' #Latitudes of weather stations
#' lat = c(2.474999, 2.474999, 2.474999, 2.474999, 2.474999)
#' #Create gap
#' precGap = c(259.6716, 262.9709, NA, 307.5199, 328.9999)
#' df = data.frame(lon,lat,precGap)
#' filled = idw(df,2,2)
#' plot(filled$precGap, type="l", col="red")
#' lines(prec, col="blue")
#'
#' #Example 2:
#'
#' data("patiaMissing")
#' filledGapValues = idw(data = patiaMissing, p= 2, k=2)
#' #plot(filledGapValues$filledGapValues, type = "l", col = "blue")
#' #lines(patiaMissing$Prec, col="red")
#'
#' @export


idw = function(data,p=1, k=1){
  x1 = (data[[1]]*73) %*% t(data[[1]]*73)
  x2 = matrix( rep(t(data[[1]]*73), length(data[[1]])), ncol = length(data[[1]]) )
  Mx = x1/x2
  Mx = abs((Mx-x2)**2)

  y1 = (data[[2]]*111) %*% t(data[[2]]*111)
  y2 = matrix( rep(t(data[[2]]*111), length(data[[2]])), ncol = length(data[[2]]) )
  My = y1/y2
  My = abs((My-y2)**2)

  Euclides = round((sqrt(Mx+My)*1000), digits = 5)

  for(iter in 1:k){

    nullValues = which(is.na(data[[3]]))
    if( length(nullValues) == 0 ){
      break()
    }
    for(i in 1:length(nullValues)){
      if( is.na(data[nullValues[i]-1,3]) && is.na(data[nullValues[i]+1,3]) ){
        data[nullValues[i],3] = NA
      }else if(!is.na(data[nullValues[i]-1,3]) && is.na(data[nullValues[i]+1,3])){
        data[nullValues[i],3] = ((data[nullValues[i]-1,3])/(Euclides[nullValues[i]-1,nullValues[i]])^(p)) / (1/(Euclides[nullValues[i]-1,nullValues[i]])^(p))
      }else if(is.na(data[nullValues[i]-1,3]) && !is.na(data[nullValues[i]+1,3])){
        data[nullValues[i],3] = ((data[nullValues[i]+1,3])/(Euclides[nullValues[i]+1,nullValues[i]])^(p)) / (1/(Euclides[nullValues[i]+1,nullValues[i]])^(p))
      }else if(!is.na(data[nullValues[i]-1,3]) && !is.na(data[nullValues[i]+1,3])){
        data[nullValues[i],3] = ( ((data[nullValues[i]-1,3])/(Euclides[nullValues[i]-1,nullValues[i]])^(p)) + ((data[nullValues[i]+1,3])/(Euclides[nullValues[i]+1,nullValues[i]])^(p)) +
          (mean((data[nullValues[i]-1,3]),(data[nullValues[i]+1,3]))/(Euclides[nullValues[i]-1,nullValues[i]+1])^(p)) ) /
          (  (1/(Euclides[nullValues[i]-1,nullValues[i]])^(p)) + (1/(Euclides[nullValues[i]+1,nullValues[i]])^(p)) +
             (1/(Euclides[nullValues[i]-1,nullValues[i]+1])^(p))  )
      }else if(is.na(data[nullValues[i],3]) && nullValues[i]-1 == 0){
        data[nullValues[i],3] = ((data[nullValues[i]+1,3])/(Euclides[nullValues[i]+1,nullValues[i]])^(p)) / (1/(Euclides[nullValues[i]+1,nullValues[i]])^(p))
      }else if(is.na(data[nullValues[i],3]) && i+1 > nrow(data)){
        data[nullValues[i],3] = ((data[nullValues[i]-1,3])/(Euclides[nullValues[i]-1,nullValues[i]])^(p)) / (1/(Euclides[nullValues[i]-1,nullValues[i]])^(p))
      }
    }

  }

  return(data)
}


