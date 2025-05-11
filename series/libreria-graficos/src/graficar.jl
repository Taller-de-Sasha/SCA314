
serie(data) = Serie(collect(map(x -> (Float64(x[1]), Float64(x[2])), data)))
graficar(data::Vector{Tuple{Float64, Float64}}) = Grafico([serie(data)])
graficar(data) = Grafico([serie(data)])



# interfaz de Plots.jl
plot() = throw(ArgumentError("No se puede graficar sin datos."))
plot(::Int) = throw(ArgumentError("No se puede graficar sin datos."))

plot(xs::Vector{<:Number}) = graficar(zip(1:length(xs), xs))
plot(xs::Vector{<:Number}, ys::Vector{<:Number}) = graficar(zip(xs, ys))
plot(xs::Vector{<:Number}, f::Function) = graficar(zip(xs, f.(xs)))
plot(f::Function, xs::Vector{<:Number}) = graficar(zip(xs, f.(xs)))
plot(f::Function, range::AbstractRange) = graficar(map(x -> (x, f(x)), range))
plot(f::Function, x0::Number, x1::Number) = graficar(map(x -> (x, f(x)), x0:0.05:x1))
plot(f::Function) = plot(f, -5, 5)

plot(M::Matrix{<:Number}) = Grafico(collect(map(x-> serie(zip(1:size(M, 1), x)), eachcol(M))))

plot(fs::Vector{<:Function}, range::AbstractRange) = Grafico(collect(map(f -> serie(map(x -> (x, f(x)), range)), fs)))
plot(fs::Vector{<:Function}, x0::Number, x1::Number) = plot(fs, x0:0.05:x1)

plot(range::AbstractRange, ys::Vector{Any}) = error("Todavía no está implementado.") #graficar(map(f -> map(x -> (x, f(x)), range), ys))