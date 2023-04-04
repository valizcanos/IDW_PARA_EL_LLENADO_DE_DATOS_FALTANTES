# IDW_PARA_EL_LLENADO_DE_DATOS_FALTANTES

<p>La ponderación de distancia inversa (IDW) en un método determinista para la interpolación multivariada de un conjunto de puntos dispersos conocidos. Este método permite la creación de matrices de pesos espaciales en análisis de autocorrelación espacial.</p><br>

<p>Ya sea para estimar la cantidad de lluvia o la elevación en áreas específicas, IDW emplea  la distancia a los valores de celda conocidos.Los puntos que están más cerca de los valores conocidos se verán más influenciados que los puntos que están más lejos.</p><br>

<p>Esta librería emplea el método IDW para llenar datos faltantes de precipitación. Para ello emplea la ecuación 1:</p><br>

$z_{p} = \frac{\sum_{i=1}^{n}   \left( \frac{z_i}{d_{i}^{p}} \right) }{ \sum_{i=1}^{n}   \left( \frac{1}{d_{i}^{p}} \right)} \tag{1}$<br>

<p>donde, $z_p$ es la celda a interpolar (o el valor faltante), $z_i$ son valores conocidos, $d_i$ es la distancia de los valores conocidos respectos al punto a interpolar, $p$ es la potencia del método de interpolación. </p>

# EJEMPLO:
```
library(devtools)
install_github("valizcanos/IDW_PARA_EL_LLENADO_DE_DATOS_FALTANTES")
```
```
library(idwimp)
```

```
datos = idwimp::patiaMissing

```

```
llenarDatosAusentes = idw(datos,2,2)
plot(llenarDatosAusentes[[3]], type = "l", col = "blue")
lines(datos[[3]], col="red")
```