
function interpolacion_constante(puntos)
    xs = _en_x(puntos)
    ys = _en_y(puntos)
    interp = _interpolacion_constante(xs,ys)
    interp
end

function interpolacion_constante(xs, ys)
    interp = _interpolacion_constante(xs,ys)
    interp
end

function interpolacion_lineal(puntos)
    xs = _en_x(puntos)
    ys = _en_y(puntos)

    interp = _interpolacion_lineal(xs, ys)
    interp
end

function  interpolacion_lineal(xs, ys)
    interp = _interpolacion_lineal(xs, ys)
    interp
end

_segundo(par) = par[2]

_en_x(p) = map(first, p)
_en_y(p) = map(_segundo, p)

_en_x(d::Dict) = collect(keys(d))
_en_y(d::Dict) = collect(values(d))

_divivir(p) = (_en_x(p), _en_y(p))

function _interpolacion_constante(xs, ys)
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

function _crear_interpolacion_entre_pares(xs, ys)
    x1, x2 = xs
    y1, y2 = ys
    m(x) = (x - x1) / (x2 - x1)
    punto_intermedio(m) = y1 * (1 - m) + m * y2
    interp(x) = punto_intermedio(m(x))
    interp
end

function _crear_interpolaciones(xs, ys)
    interpolaciones = []

    for i in 1:length(xs)-1
        xx = xs[i:i+1]
        yy = ys[i:i+1]
        f = _crear_interpolacion_entre_pares(xx, yy)
        push!(interpolaciones, f)
    end

    interpolaciones
end

function _interpolacion_lineal(xs, ys)
    interpolaciones = _crear_interpolaciones(xs, ys)

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
