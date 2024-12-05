include("src/graficos.jl")
using PruebasA

# puntos = [(-1, 1), (0, 0), (1, 1), (2, 0)]

puntos = [(-1, 2), (0,0), (1,3)]


# xs = PruebasA.en_x(puntos)
# ys = PruebasA.en_y(puntos)

f = PruebasA.interpolacion_lineal(puntos)

y = f(1)

graficar(f, puntos)
# graficar(interpolaciones[2], puntos)


println("Completo")