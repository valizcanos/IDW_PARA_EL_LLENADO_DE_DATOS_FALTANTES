# IDW_PARA_EL_LLENADO_DE_DATOS_FALTANTES

<p>La ponderación de distancia inversa (IDW) en un método determinista para la interpolación multivariada de un conjunto de puntos dispersos conocidos. Este método permite la creación de matrices de pesos espaciales en análisis de autocorrelación espacial.</p><br>

<p>Ya sea para estimar la cantidad de lluvia o la elevación en áreas específicas, IDW emplea  la distancia a los valores de celda conocidos.Los puntos que están más cerca de los valores conocidos se verán más influenciados que los puntos que están más lejos.</p><br>

<p>Esta librería emplea el método IDW para llenar datos faltantes de precipitación (u otras varibles medidas en estaciones climáticas). Para ello emplea la ecuación 1:</p><br>

$z_{p} = \frac{\sum_{i=1}^{n}   \left( \frac{z_i}{d_{i}^{p}} \right) }{ \sum_{i=1}^{n}   \left( \frac{1}{d_{i}^{p}} \right)} \tag{1}$<br>

<p>donde, $z_p$ es la celda a interpolar (o el valor faltante), $z_i$ son valores conocidos, $d_i$ es la distancia de los valores conocidos respectos al punto a interpolar, $p$ es la potencia del método de interpolación. </p><br>

<p> <b>Por ejemplo</b>, supongamos que tenemos el siguiente conjunto de datos de precipitación tomados de distintas estaciones climáticas para un día (mes o año) en específico (tabla 1): </p><br>

<p> <b>Tabla 1.</b> Datos de precipitación provenientes de diferentes estaciones climáticas en una fecha puntal </p> <br>

| x		| y		| z		|
|-----------|-----------|-----------|
|-76.2938   |3.2421     | 94.1      |
|-76.3356   |3.2700     | 73.8      |
|-76.2758   |3.2705     | 99.4      |
|-76.3109   |3.2702     | 83.0      |
|-76.2954   |3.3224     | **NA**    |

<p>Observen que el último registro de la tabla 1 no contiene un registro de la precipitación (z), es un valor ausente para esa longitud (x) y latitud (y) proporcionadas.</p><br>

<p>Si espacializamos (fig. 1) los registros mostrados en la tabla 1, se observa que las estaciones localizadas en las posiciones -76.3109, 3.2702 y -76.2758, 3.2705 son las más cercanas y podrían proporcinarnos la información para la imputación del dato faltante.</p><br>

<img title="Espacialización de los registros de precipitaciones" alt="Espacialización" src="/imgs/img1.png">
<p> <b>Figura 1.</b>Espacialización de los registros de precipitación </p> <br>

<p>Al aplicar la ecuación 1 implementada con la librería idwimp, para potencias (p) de 1, 2 y 3 e iteraciones (k) de 1, 2 y 3, los resultados del valor ausente serán de: </p><br>

```
library(idwimp)
```
```
x = c(-76.2938, -76.3356, -76.2758, -76.3109 , -76.2954)

y = c(3.2421, 3.2700, 3.2705, 3.2702, 3.3224)

z = c(94.1, 73.8, 99.4, 83.0, NA)
```
```
df = data.frame(x,y,z)

df = df[order(df[[1]]),]
```
```
idw(df,p = 1, k=1)
idw(df,p = 2, k=1)
idw(df,p = 3, k=1)
idw(df,p = 1, k=2)
idw(df,p = 2, k=2)
idw(df,p = 3, k=2)
idw(df,p = 1, k=3)
idw(df,p = 2, k=3)
idw(df,p = 3, k=3)

```

```
```

| x		| y		| z			|
|-----------|-----------|-----------------|
|-76.2938   |3.2421     | 94.1      	|
|-76.3356   |3.2700     | 73.8      	|
|-76.2758   |3.2705     | 99.4      	|
|-76.3109   |3.2702     | 83.0      	|
|-76.2954   |3.3224     | **85.14982**    |

| x		| y		| z			|
|-----------|-----------|-----------------|
|-76.2938   |3.2421     | 94.1      	|
|-76.3356   |3.2700     | 73.8      	|
|-76.2758   |3.2705     | 99.4      	|
|-76.3109   |3.2702     | 83.0      	|
|-76.2954   |3.3224     | **84.0756**     |

| x		| y		| z			|
|-----------|-----------|-----------------|
|-76.2938   |3.2421     | 94.1      	|
|-76.3356   |3.2700     | 73.8      	|
|-76.2758   |3.2705     | 99.4      	|
|-76.3109   |3.2702     | 83.0      	|
|-76.2954   |3.3224     | **83.48007**    |

| x		| y		| z			|
|-----------|-----------|-----------------|
|-76.2938   |3.2421     | 94.1      	|
|-76.3356   |3.2700     | 73.8      	|
|-76.2758   |3.2705     | 99.4      	|
|-76.3109   |3.2702     | 83.0      	|
|-76.2954   |3.3224     | **85.14982**    |

| x		| y		| z			|
|-----------|-----------|-----------------|
|-76.2938   |3.2421     | 94.1      	|
|-76.3356   |3.2700     | 73.8      	|
|-76.2758   |3.2705     | 99.4      	|
|-76.3109   |3.2702     | 83.0      	|
|-76.2954   |3.3224     | **84.0756**     |

| x		| y		| z			|
|-----------|-----------|-----------------|
|-76.2938   |3.2421     | 94.1      	|
|-76.3356   |3.2700     | 73.8      	|
|-76.2758   |3.2705     | 99.4      	|
|-76.3109   |3.2702     | 83.0      	|
|-76.2954   |3.3224     | **83.48007**    |

| x		| y		| z			|
|-----------|-----------|-----------------|
|-76.2938   |3.2421     | 94.1      	|
|-76.3356   |3.2700     | 73.8      	|
|-76.2758   |3.2705     | 99.4      	|
|-76.3109   |3.2702     | 83.0      	|
|-76.2954   |3.3224     | **85.14982**    |

| x		| y		| z			|
|-----------|-----------|-----------------|
|-76.2938   |3.2421     | 94.1      	|
|-76.3356   |3.2700     | 73.8      	|
|-76.2758   |3.2705     | 99.4      	|
|-76.3109   |3.2702     | 83.0      	|
|-76.2954   |3.3224     | **84.0756**     |

| x		| y		| z			|
|-----------|-----------|-----------------|
|-76.2938   |3.2421     | 94.1      	|
|-76.3356   |3.2700     | 73.8      	|
|-76.2758   |3.2705     | 99.4      	|
|-76.3109   |3.2702     | 83.0      	|
|-76.2954   |3.3224     | **83.48007**    |

<p>Los valores faltantes para el dato ausente oscilan entre 83.5 y 85.2</p><br>

<p>Para instalar la libreria <b>idwimp</b> puede compiar las siguientes líneas de código en su consola de R y de R-Studio. </p><br>

# EJEMPLO:

```
library(devtools)
install.packages("remotes")
remotes::install_github("valizcanos/IDW_PARA_EL_LLENADO_DE_DATOS_FALTANTES/idwimp")
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