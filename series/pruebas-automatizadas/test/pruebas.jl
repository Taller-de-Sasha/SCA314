using Test
using TestItems
using PruebasA
using OrderedCollections

puntos = [(-1, 1), (0, 0), (1, 1), (2, 0)]
puntos2 = [(-1, 1), (0, 0), (1, 1), (2, 0), (3, 2)]

@testitem "Interpolacion coincide en puntos" begin

    function verificar_interpolacion_coincide_en_puntos_de_interpolacion(puntos, f)
        @testset for (x, y) in puntos
            @test f(x) == y
        end
    end

    generar_pares_aleatorios(n) = sort([randn(2) for _ in 1:n])
    
    @testset for f in [PruebasA.interpolacion_constante, PruebasA.interpolacion_lineal], i in 1:10
            p = generar_pares_aleatorios(10)
            fn = f(p)
            verificar_interpolacion_coincide_en_puntos_de_interpolacion(p, fn)
    end
end

@testitem "Probar Interpolacion Constante" begin
    puntos = [(-1, 1), (0, 0), (1, 1), (2, 0)]
    f = PruebasA.interpolacion_constante(puntos)
    @test f(0.5) == 0.0
end

@testitem "Probar Interpolacion Lineal" begin
    puntos = [(-1, 2), (0, 0), (1, 3), (2, -1)]
    # puntos = [(-1, 2), (0, 0), (1, 2)]
    f = PruebasA.interpolacion_lineal(puntos)
    @test f(0.5) == 1.5
    @test f(0.333) ≈ 1.0 atol=0.01
    @test f(-0.5) == 1.0
    @test f(1.5) == 1.0
    @test f(2.0) == -1
    @test f(-1) == 2
end

@testitem "Probar Inicializacion de Interpolacion con X,Y" begin
    xs = collect(-1:0.2:1)
    ys = [rand() for _ in xs] 
    
    @testset for interp in [PruebasA.interpolacion_constante, PruebasA.interpolacion_lineal]
        f = interp(xs, ys)
        @test f(xs[4]) == ys[4]
    end
end


@testitem "Probar Inicializacion de Interpolacion con {x_i=>y_i}" begin
    xs = collect(-1:0.2:1)
    ys = [rand() for _ in xs] 
    
    data = sort(Dict(zip(xs, ys)))

    @testset for interp in [PruebasA.interpolacion_constante, PruebasA.interpolacion_lineal]
        f = interp(data)
        @test f(xs[4]) == ys[4]
    end
end