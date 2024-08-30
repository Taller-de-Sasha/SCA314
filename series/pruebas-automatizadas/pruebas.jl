using Test
include("interpolacion.jl")


puntos = [(-1, 1), (0, 0), (1, 1), (2, 0)]
puntos2 = [(-1, 1), (0, 0), (1, 1), (2, 0), (3, 2)]


function verificar_interpolacion_coincide_en_puntos_de_interpolacion(puntos, f)
    @testset for (x, y) in puntos
        @test f(x) == y
    end
end

generar_pares_aleatorios(n) = [randn(2) for _ in 1:n]

@testset for f in [interpolacion, interpolacion_constante]
    @testset for i in 1:1
        p = generar_pares_aleatorios(10)
        fn = f(p)
        verificar_interpolacion_coincide_en_puntos_de_interpolacion(p, fn)
    end
end