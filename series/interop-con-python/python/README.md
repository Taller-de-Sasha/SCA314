
Para hacer un profiling, en una consola de IPython ejecutar:

```sh
cd python
ipython
```

```python
%run experimento.py
```

```python
%%prun -s cumulative -q -l 20 -T prunX
n_pasos = 100
tamanio_grilla = 64 #128
simulacion_(n_pasos,tamanio_grilla)
```
