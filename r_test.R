library(tidyverse)
library(data.table)
library(feather)
library(microbenchmark)

datos = read_feather('dataset_test.feater')

microbenchmark(
      datos %>% 
        group_by(categoria) %>% 
        summarise(valor = mean(valor))
)

dt = datos %>% as.data.table()
microbenchmark(
    dt[,list(valor = mean(valor)),by='categoria']
)

  setkey(dt,categoria)
microbenchmark(
  dt[,list(valor = mean(valor)),by='categoria']
)
  
fico = function(n,contador = 2, ant = 1, antant = 0){
  if(n <= 1){return(n)}
  if(n == contador){
    return(ant + antant)
  }else{
    return(
      fico(n,contador+1,ant + antant,ant)
    )
  }
}

microbenchmark(
  fico(100)
)

mat = matrix(runif(1000*1000),nrow=1000)
microbenchmark(svd(mat))
  
  microbenchmark({
    for(i in 1:1000){
      for(j in 1:1000){
        mat[i,j] = i+j
      }
    }  
  },times = 10)
