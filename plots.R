library(tidyverse)
library(readODS)



# Agregacion
data = read_ods('benchmarks.ods')
data = mutate(data, Libreria = replace_na(Libreria, 'nativo'))
data = data %>% filter(Lenguaje == 'Julia' | Fecha == '04/01/20')

aux = filter(data, Tarea == 'Agregacion') %>% 
  mutate(Lenguaje = if_else(Lenguaje == 'Julia', paste(Lenguaje,Fecha), Lenguaje ))

ggplot(aux,aes(Libreria,Miliseconds,fill = Lenguaje)) + geom_histogram(stat = 'identity',position = 'dodge')
ggsave('agregacion.png')


# Fibonachi
data = read_ods('benchmarks.ods')
data = mutate(data, Libreria = replace_na(Libreria, 'nativo'))
# data = data %>% filter(Lenguaje == 'Julia' | Fecha == '04/01/20')

aux = filter(data, Tarea == 'fibonacci') %>% 
  # mutate(Lenguaje =  paste(Lenguaje,Fecha) ) %>% 
  mutate(Nanoseconds = Miliseconds*1000,
         Picoseconds = Nanoseconds*1000,
         log_Picoseconds = log(Picoseconds,10))

ggplot(aux,aes(Lenguaje,log_Picoseconds,fill = Fecha)) + geom_histogram(stat = 'identity',position = 'dodge')
ggsave('fibonacci_log.png')

ggplot(aux,aes(Lenguaje,Picoseconds,fill = Fecha)) + geom_histogram(stat = 'identity',position = 'dodge')
ggsave('fibonacci.png')

# SDV
data = read_ods('benchmarks.ods')
data = mutate(data, Libreria = replace_na(Libreria, 'nativo'))
# data = data %>% filter(Lenguaje == 'Julia' | Fecha == '04/01/20')

aux = filter(data, Tarea == 'svd')

ggplot(aux,aes(Lenguaje,Miliseconds,fill = Fecha)) + geom_histogram(stat = 'identity',position = 'dodge')
ggsave('svd.png')

# Llenado
data = read_ods('benchmarks.ods')
data = mutate(data, Libreria = replace_na(Libreria, 'nativo'))
# data = data %>% filter(Lenguaje == 'Julia' | Fecha == '04/01/20')

aux = filter(data, Tarea == 'fill_mat')

ggplot(aux,aes(Lenguaje,Miliseconds,fill = Fecha)) + geom_histogram(stat = 'identity',position = 'dodge')
ggsave('fill.png')
