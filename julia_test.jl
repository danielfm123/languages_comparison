using Pkg

using Queryverse
using Feather
using DataFrames
using Statistics
using BenchmarkTools
using Distributed
using LinearAlgebra
using SharedArrays
#using IndexedTables
using JuliaDB



datos = Feather.read("dataset_test.feater")  |> DataFrame
tabla = load("dataset_test.feater") |> @filter(_[:categoria] == "owhkm")

#Queryverse
@benchmark result = datos |> @groupby(_.categoria) |> @map({categoria = key(_),promedio = mean(_.valor)}) |> DataFrame
#DataFrame
@benchmark result = aggregate(datos,:categoria,[mean])
@benchmark result = by(datos,:categoria,x->(promedio = mean(x.valor)))

#JuliaDB
indexed = table(datos)
@benchmark JuliaDB.groupby(mean, indexed, :categoria, select =:valor)

#Manual
function agrupar()
  results = []
  for slice in groupby(datos,:categoria)
    push!(results,(promedio = slice.categoria[1], valor =  mean(slice.valor)))
  end
  DataFrame(results)
end

@benchmark result = agrupar()


function fico(n::Int64,contador::Int64 = 2, ant::Int64 = 1, antant::Int64 = 0)
  if n <= 1
    return n
  end
  if n == contador
    return ant + antant
  else
    return fico(n,contador+1,ant + antant,ant)
  end
end

function fico(n,contador = 2, ant = 1, antant = 0)
  if n <= 1
    return n
  end
  if n == contador
    return ant + antant
  else
    return fico(n,contador+1,ant + antant,ant)
  end
end

@benchmark fico(100)

BLAS.set_num_threads(8)
mat = rand(1000,1000)
@benchmark svd(mat)

function rellenar()
  for i in 1:1000
    for j in 1:1000
      global mat[i,j] = i+j
    end
  end
end

@benchmark rellenar()
