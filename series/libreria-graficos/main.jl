

using Graficos


data = [(0,0),(0,1)]
Graficos.template(data) |> Graficos.mostrar


data = [(0,0),(1,0)]
Graficos.template(data) |> Graficos.mostrar

d2 = escalear(data)
