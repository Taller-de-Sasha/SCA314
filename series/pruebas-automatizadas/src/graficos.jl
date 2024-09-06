using Plots
using PruebasA


function graficar(f, puntos)
    x = PruebasA.en_x(puntos)
    # x2 = -1.0:0.1:2.0
    xmin, xmax = extrema(x)
    x2 = range(xmin, xmax, 100)
    scatter(x2, f.(x2), ms=2, label="muestra")
    scatter!(x, f.(x), ms=5, ma=0.5, mc=:black, label="Puntos de interpolación")
    plot!(legend=:outerbottom, legendcolumns=2)
end