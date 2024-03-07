## Eduard Martinez
## Update: 05-04-2024

## limpiar entonro
rm(list=ls())

## instalar/llamar pacman
require(pacman)

## usar la función p_load de pacman para instalar/llamar las librerías de la clase
p_load(tidyverse, ## manipular/limpiar conjuntos de datos.
       rio, ## para leer/escribir archivos desde diferentes formatos. 
       skimr, ## skim: describir un conjunto de datos
       janitor) ##  tabyl: frecuencias relativas


## **[1.] Operador pipe (%>%)**

### Veamos un ejemplo:
df = as_tibble(x = women)
db <- as.data.frame(mtcars)

#seleccionar usando posicion
db2 <- db[,1:3]

db2 <- db[,c("mpg","vs")]


#seleccionar usando select
db2 <- select(.data = db,mpg,vs,carb)

#seleccionar usando select (eliminar una variable)
db2 <- select(.data = db,-mpg)

#seleccionar usando select (mantener grupo de variables)
db2 <- select(.data =db,mpg:vs)

#seleccionar usando select (mantener grupo de variables por nombre, variables con c)
colnames(db) #veo los nombres de las variables

starts_with <- dplyr::starts_with
db2 <- select(db,starts_with("c"))
db2 <- select(db,-ends_with("t"))
db2 <- select(db,contains("carb"))


## filtrar obsevaciones
# una condicion
db2 <- dplyr::filter(.data = db, vs==1) #db2 ahora tiene filtrada
tabyl(db$vs) #saco cuantos usan motor en v
db2 <- dplyr::filter(.data = db, vs==1 & am==1)


## Otra forma de hacerlo es emplear el operador pipe `%>%`:  

db2 <- mutate(.data=db, aleatorio=rnorm(nrow(db)))
db2 <- select(.data=db2, vs, am,aleatorio)

select <- dplyr::select

db2 <- filter(.data=db2, vs==1 & am==1)

#ejemplo dplyr (pipe es %>% o |>)
db3 <- mutate(.data=db, aleatorio=rnorm(nrow(db))) |> 
  select(vs,am,aleatorio) %>% filter(vs==1 & am==1)

#bono
db4 <- select(.data=db2, vs, am,aleatorio) |> 
  filter(vs==1 & am==1) %>% mutate(aleatorio=rnorm(nrow(db2)))


## Con `%>%` no es necesario mencionar el objeto en cada nueva transformación. Además, las líneas de código se redujeron a la mitad.

### Veamos otro ejemplo:

## Intente reescribir el siguiente código usando el operador `%>%`:
df <- import("https://www.datos.gov.co/resource/epsv-yhtj.csv")
df <- as_tibble(df)
df <- select(df, -cod_ase_)
df <- mutate(df,ifelse(is.na(estrato),1,estrato))


## **[2.] Combinar conjuntos de datos (adicionar filas/columnas)**

### **2.1 Agregar observaciones**

## Generar conjuntos de datos para hacer la aplicación:
set.seed(0117) # Fijar semilla
obs_1 = tibble(id = 100:105 , 
               age = runif(6,18,25) %>% round() , 
               height = rnorm(6,170,10) %>% round())

obs_2 = tibble(id = 106:107 , 
               age = runif(2,40,50)  %>% round() , 
               height = rnorm(2,165,8) %>% round() , 
               name = c("Lee","Bo"))

## Inspeccionar los datos:


## Combinar el conjunto de datos (bind_rows): 

obs <- bind_rows(obs_1,obs_2) #pega usando el nombre de las variables

obs_1 <- obs_1 |> select(age,id,height) #ejemplo reordenando nombres
obs <- bind_rows(obs_1,obs_2) #no importa si las columnas estan en desorden


### **2.2 Adicionar variables a un conjunto de datos**
db_1 <- tibble(id = 102:105 , income = runif(4,1000,2000) %>% round())
db_2 <- tibble(id = 103:106 , age = runif(4,30,40)  %>% round())

## Inspeccionar los datos:


## Combinar el conjunto de datos (bind_cols): 
print("Algo salió mal! la función bind_cols() no tiene en cuenta el identificador de cada observación.") 

### **2.3 Adicionar variables a un conjunto de datos:** `join()`

## Puede adicionar variables a un conjunto de datos usando la familia de funciones de `join()`:
data_1 <- tibble(Casa=c(101,201,201,301),
              Visita=c(2,1,2,1),
              Sexo=c("Mujer","Mujer","Hombre","Hombre"))
data_2 <- tibble(Casa=c(101,101,201,201),
              Visita=c(1,2,1,2),
              Edad=c(23,35,7,24),
              Ingresos=c(500000,1000000,NA,2000000))

#### **Ejemplo: left_join()**


#### **Ejemplo: right_join()**


#### **Ejemplo: inner_join()**


#### **Ejemplo: full_join()**


#### **Ejemplo: Join sin identificador único**


### **3.4 Chequear valores unicos**
df_1 <- tibble(Hogar=1,Visita=1,Sexo=1)
df_2 <- tibble(Hogar=1,Visita=1,Edad=1,Ingresos=1)

## Coincidencia en variables:

## unique


