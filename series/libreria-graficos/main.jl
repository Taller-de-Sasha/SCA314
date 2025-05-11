

using Graficos


data = [(0,0),(0,1),(1,1),(1,0),(0.9,0.9)]
Graficos.template(data) |> Graficos.mostrar


data = map(x -> (x, x^2), -10:0.1:10)
Graficos.template(data) |> Graficos.mostrar

d2 = escalear(data)

g=Graficos.plot(rand(10,3))