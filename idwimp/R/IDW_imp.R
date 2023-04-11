#' idwimp package
#' Contains IDW function to fill gap precipitation values
#' @docType package
#' @description idwimp is a package that uses the IDW method to fill in missing precipitation data (or other variables measured at weather stations).
#' @author Victor Augusto Lizcano Sandoval \email{valizcanos@gmail.com} \url{https://github.com/valizcanos/IDW_PARA_EL_LLENADO_DE_DATOS_FALTANTES}
#' @name idwimp
#' @examples
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
NULL
