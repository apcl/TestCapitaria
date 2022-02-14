# TestCapitaria
  A continuación se detalla la implementación paso a paso para chequear el test propuesto por Capitaria.
## Tecnología utilizada
Para esta solución se utilizaron las siguientes tecnologías:
- SQL SERVER 2017
- .NET 4.8 con MVC
- EntityFramework 6.0
## Modelo de datos
Para la implementación de la base de datos es necesario realizar la importación del archivo COLEGIO.bak, ubicado en la carpeta SQLSERVER. Este archivo contiene la estructura de la base de datos y algunos datos de prueba.

El esquema de esta base de datos es el siguiente:
![ScreenShot](https://github.com/apcl/TestCapitaria/blob/main/SQL%20SERVER/Diagrama%20de%20BDD%20COLEGIO.png)

## SQL
Para las consultas SQL, las respuestas de estas se encuentran en el archivo Respuestas SQL.sql ubicado en la carpeta SQLSERVER. Se detallan las 5 respuestas a las 5 preguntas.

## Diseño de software
### Backend
Para implementar la aplicación web será necesaria la utilización de un servidor web IIS.

Un ajuste importante a realizar es en el archivo Web.config ubicado en la carpeta APLICACIÓN WEB - .NET4.8 MVC, ya que se debe modificar la conexión a la base de datos. Para esto es necesario editar el connectionStrings ubicado al final del archivo.

Se debe reemplazar lo siguiente:
- data source = SERVIDOR DE BDD
- user id = USUARIO DE BDD
- password = CONTRASEÑA

Es necesario copiar el contenido de la carpeta APLICACIÓN WEB - .NET4.8 MVC a la ubicación donde se publicará este (carpeta dentro del servidor web).

Una vez realizadas estas acciones, se está en condición de probar la aplicación.

### Frontend
...continuar
