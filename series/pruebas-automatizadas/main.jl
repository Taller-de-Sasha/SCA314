using PruebasA
include("src/graficos.jl")

puntos = [(-1, 1), (0, 0), (1, 1), (2, 0)]

f = PruebasA.interpolacion(puntos)
g = PruebasA.interpolacion_constante(puntos)

y = f(10)

graficar(f, puntos)