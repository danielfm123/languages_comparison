import pandas as pd
import numpy as np
import time

class Timer:    
    def __enter__(self):
        self.start = time.process_time_ns()
        return self

    def __exit__(self, *args):
        self.end = time.process_time_ns()
        self.interval = (self.end - self.start)/1000000000


datos = pd.read_feather('dataset_test.feater')

results = list()
for n in range(100):
    with Timer() as t:
        foo = datos.groupby(['categoria']).aggregate(np.mean)
    results.append(t.interval)

print(np.mean(results))

def fico(n,contador = 2, ant = 1, antant = 0):
  if(n <= 1):
    return n
  if(n == contador):
    return ant + antant
  else:
    return fico(n,contador+1,ant + antant,ant)

results = list()
for n in range(100):
    with Timer() as t:
        foo = fico(100)
    results.append(t.interval)

print(np.mean(results)*1000)

mat = np.random.rand(1000,1000)

results = list()
for n in range(30):
    with Timer() as t:
        res = np.linalg.svd(mat)
    results.append(t.interval)

print(np.mean(results)*1000)

import itertools
results = list()
for n in range(30):
  with Timer() as t:
    for i,j in itertools.product(range(1000),range(1000)):
      mat[i,j] = i+j
  results.append(t.interval)

print(np.mean(results)*1000)
