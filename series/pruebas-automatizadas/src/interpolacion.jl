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