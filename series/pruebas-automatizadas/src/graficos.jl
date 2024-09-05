using Plots
using PruebasA


function graficar(f, puntos)
    x = PruebasA.en_x(puntos)
    # x2 = -1.0:0.1:2.0
    xmin, xmax = extrema(x)
    x2 = range(xmin, xmax, 100)
    scatter(x2, f.(x2), label="muestra")
    scatter!(x, f.(x), label="Puntos de interpolación")
end