puntos = [(-1,1),(0,0),(1,1),(2,0)]
puntos2 = [(-1,1),(0,0),(1,1),(2,0), (3,2)]

f(x) = (x == 0) || (x == 2) ? 0 : 1
g(x) = x

h(x) = g(x) + f(x)


function verificar(puntos, f, nombre)
    for (x,y) in puntos
        println(x, " $nombre: ", f(x) == y )
    end
end

verificar(puntos, f, "f")
verificar(puntos2, f, "f")

verificar(puntos, g, "g")
verificar(puntos, h, "h")

function interpolacion(puntos)
    d = Dict(puntos)
    f(x) = haskey(d,x) ? d[x] : 0
    f
end

f1 = interpolacion(puntos)

verificar(puntos, f1, "f1")

f2 = interpolacion(puntos2)

verificar(puntos, f2, "f1")

generar_pares_aleatorios(n) =  [randn(2) for _ in 1:n]

for _ in 1:10

p = generar_pares_aleatorios(1000)
fn = interpolacion(p)
verificar(p, fn, "fn")

end