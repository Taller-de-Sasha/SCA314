include("src/graficos.jl")
using PruebasA

# puntos = [(-1, 1), (0, 0), (1, 1), (2, 0)]

puntos = [(0,0), (0,1), (1,2)]
f = PruebasA.interpolacion_constante(puntos)
g = PruebasA.interpolacion_lineal(puntos)

y = g(1)

graficar(f, puntos)
graficar(g, puntos)


println("Completo")

xs = collect(-1:0.2:1)
ys = [rand() for _ in xs] 
    
data = Dict(zip(xs, ys))