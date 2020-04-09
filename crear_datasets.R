library(tidyverse)
library(feather)
library(purrr)

n_categorias = 1000
n_registros = 10^7

categorias = map_chr(1:n_categorias,~paste(sample(letters,5,replace = T),collapse = ""))

dataset = data.frame(
  categoria = sample(categorias,n_registros,replace = T),
  valor = runif(n_registros)
)

write_feather(dataset,'dataset_test.feater')
