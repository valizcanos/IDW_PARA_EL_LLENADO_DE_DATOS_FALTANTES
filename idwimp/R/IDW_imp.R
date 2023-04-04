#' idwimp package
#' Contains IDW function to fill gap precipitation values
#' @docType package
#' @author Victor Augusto Lizcano Sandoval \email{valizcanos@gmail.com} \url{https://github.com/valizcanos/IDW_PARA_EL_LLENADO_DE_DATOS_FALTANTES}
#' @name idwimp
#' @examples
#' prec = c(259.6716, 262.9709, 288.2743, 307.5199, 328.9999) #precipitation measured in different weather stations
#' lon = c(-77.925, -77.875, -77.825, -77.775, -77.725) #Longitudes of weather stations
#' lat = c(2.474999, 2.474999, 2.474999, 2.474999, 2.474999) #Latitudes of weather stations
#' precGap = c(259.6716, 262.9709, NA, 307.5199, 328.9999) #Create gap
#' df = data.frame(lon,lat,precGap)
#' filled = idw(df,2,2)
#' plot(filled$precGap, type="l", col="red")
#' lines(prec, col="blue")
NULL
