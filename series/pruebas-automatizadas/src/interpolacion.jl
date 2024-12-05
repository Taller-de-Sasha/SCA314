function interpolacion(puntos)
    d = Dict(puntos)
    f(x) = haskey(d,x) ? d[x] : 0
    f
end

segundo(par) = par[2]
en_x(p) = map(first, p)
en_y(p) = map(segundo, p)

divivir(p) = (en_x(p),en_y(p))


function interpolacion_constante(puntos)
    xs = en_x(puntos)
    ys = en_y(puntos)
    function indice_de(i) 
         indice = findfirst(i .== xs)
         if !isnothing(indice)
            return indice
         end
         findfirst(abs.(diff(i .> xs)) .> 0)
    end
    f(x) = ys[indice_de(x)] 
    f
end


function crear_interpolacion_entre_pares(xs, ys)
    x1, x2 = xs
    y1, y2 = ys
    m(x) = (x-x1)/(x2-x1)
    punto_intermedio(m) = y1*(1-m) + m*y2
    interp(x) = punto_intermedio(m(x))
    interp
end

function crear_interpolaciones(xs,ys)
interpolaciones = []

for i in 1:length(xs)-1
    xx = xs[i:i+1] 
    yy = ys[i:i+1]
    f = crear_interpolacion_entre_pares(xx, yy)
    push!(interpolaciones, f)
end

interpolaciones
end

function interpolacion_lineal(puntos)
    # puntos = [(0,0), (1,1)]
    xs = en_x(puntos)
    ys = en_y(puntos)

    interpolaciones = crear_interpolaciones(xs,ys)

    function indice_de(i) 
        indice = findfirst(i .== xs)
        if !isnothing(indice)
           if indice == 1
            return 1
           end
           return indice - 1
        end
        findfirst(abs.(diff(i .> xs)) .> 0)
    end

    f(x) = interpolaciones[indice_de(x)](x)

    f
end