include("src/graficos.jl")
using PruebasA

# puntos = [(-1, 1), (0, 0), (1, 1), (2, 0)]

puntos = [(-1, 2), (0,0), (1,3)]


xs = PruebasA.en_x(puntos)
ys = PruebasA.en_y(puntos)

@which PruebasA.interpolacion_lineal(puntos)
g = PruebasA.interpolacion_lineal(xs, ys)

y = f(1)

graficar(f, puntos)
graficar(g, puntos)


println("Completo")