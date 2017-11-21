
#####LIBRERIAS A EMPLEAR#####
library(readxl) ##### Leer hoja de excel, dado el caso los datos esten en ese formato
library(hydroGOF)##### Evalua los errores

setwd("UBICACIÓN DE SUS DATOS")

##########################################################################################################################################
##### NOTA: A MANERA DE EJEMPLO, SE SUPONDRÁ QUE SE CUENTAN CON UNA SERIE DE DATOS DE PRECIPITACIÓN DIARIA PARA DIFERENTES ESTACIONES#####
##### NOTA: A MANERA DE EJEMPLO, SE SUPONDRÁ QUE SE CUENTAN CON 34 ESTACIONES Y UN PERIODO DE TIEMPO DE 8460 DÍAS#####
##########################################################################################################################################

>PRECIPITACION ##### DATAFRAME QUE CONTENDRÁ LOS DATOS DE PRECIPITACIÓN DE CADA ESTACIÓN EN ORDEN CRONOLÓGICO
>PRECIPITACION$FECHA <- NULL ##### DESCARTAR LOS DATOS DE FECHAS

>DISTANCIAS ##### MATRIZ CON LA DISTANCIA EUCLIDEA EXISTENTE ENTRE CADA ESTACIÓN
colnames(DISTANCIAS) <- c("EST1", "EST2",...,"EST34") ### DADO EL CASO LA MATRIZ DE DISTANCIAS NO TENGA EL NOMBRE DE LAS ESTACIONES
rownames(DISTANCIAS) <- c("EST1", "EST2",...,"EST34") ### DADO EL CASO LA MATRIZ DE DISTANCIAS NO TENGA EL NOMBRE DE LAS ESTACIONES

W <- DISTANCIAS^2 ### REPRESENTA EL CUÁDRADO DE LAS DISTANCIAS EUCLIDEAS
W <- as.data.frame(W) ### TRANSFORMA LA MATRIZ EN UN DATAFRAME
Wj <- rowSums(W) ### ESTIMA LA SUMA ACUMULADA DE W PARA CADA ESTACIÓN
Wj <- as.data.frame(Wj) ### TRANSFORMA LA MATRIZ EN UN DATAFRAME

Pt <- t(PRECIPITACION) ### TRANSPONE LA MATRIZ DE DATOS DE PRECIPITACIÓN
i <- seq(1:8460) ###SECUENCIA DE DÍAS
j <- seq(1:34)  ###SECUENCIA DE ESTACIONES

IDW_EST1 = matrix(data=NA, nrow=1, ncol=8460)
for(x in i){IDW_EST1[,x] = ( sum(Pt[,x]*W["EST1"], na.rm = TRUE)/Wj[1,])}

IDW_EST2 = matrix(data=NA, nrow=1, ncol=8460)
for(x in i){IDW_EST2[,x] = ( sum(Pt[,x]*W["EST2"], na.rm = TRUE)/Wj[2,])}

IDW_EST3 = matrix(data=NA, nrow=1, ncol=8460)
for(x in i){IDW_EST3[,x] = ( sum(Pt[,x]*W["EST3"], na.rm = TRUE)/Wj[3,])}

.
.
.
IDW_EST34 = matrix(data=NA, nrow=1, ncol=8460)
for(x in i){IDW_EST34[,x] = ( sum(Pt[,x]*W["EST34"], na.rm = TRUE)/Wj[34,])}


IDW <- rbind("IDW_EST1", "IDW_EST2", "IDW_EST3", ... , "IDW_EST34")
IDW <- as.data.frame(IDW)
IDW <- round(IDW, digits = 3) ### REDONDEA LOS DIGÍTOS DADO EL CASO CONTENGA MUCHOS DECIMALES

mae(PRECIPITACION, IDW, na.rm=TRUE) ###ERROR MEDIO ABSOLUTO
me(PRECIPITACION, IDW, na.rm=TRUE) ###ERROR MEDIO 
mse(PRECIPITACION, IDW, na.rm=TRUE) ###ERROR MEDIO CUADRATICO
nrmse(PRECIPITACION, IDW, na.rm=TRUE, norm = "sd") ###ERROR MEDIO NORMALIZADO
br2(PRECIPITACION, IDW, na.rm=TRUE) ###COEFICIENTE DE DETERMINACION R2
cp(PRECIPITACION, IDW, na.rm=TRUE) ###COEFICIENTE DE PERSISTENCIA
d(PRECIPITACION, IDW, na.rm=TRUE) ###INDICE DE SIMILITUD

IDW[!is.na(PRECIPITACION)] <- PRECIPITACION[!is.na(PRECIPITACION)] ### REEMPLAZA LOS VALORES AUSENTES "NA" CON LOS VALORES ESTIMADOS




