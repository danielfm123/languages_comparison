using Queryverse
using Feather
using DataFrames
using Random

n_categorias = 1000
n_registros = 10^7

categorias = [randstring(5) for x in 1:n_categorias]

dataset = DataFrame(
    categoria = rand(categorias,n_registros),
    valor = rand(n_registros)
)

#save("dataset_test.feater",datos)
Feather.write("dataset_test_jl.feather",dataset)
# save("dataset_test_jl.feater",dataset)
