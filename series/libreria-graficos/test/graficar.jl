using TestItem

@testitem "Test interfaz  de Plots" begin
    using Graficos:plot, Grafico

    funciones = [
        (() -> plot(rand(10))),                               # 1 series... x = 1:10
        (() -> plot(rand(10,5))),                             # 5 series... x = 1:10
        (() -> plot(rand(10), rand(10))),                     # 1 series
        # (() -> plot(rand(10,5), rand(10))   ),                # 5 series... y is the same for all
        (() -> plot(sin, rand(10))     ),                     # y = sin.(x)
        (() -> plot(rand(10), sin)     ),                     # same... y = sin.(x)
        (() -> plot([sin,cos], 0:0.1:π)     ),                # 2 series, sin.(x) and cos.(x)
        (() -> plot([sin,cos], 0, π)     ),                   # sin and cos on the range [0, π]
        # (() -> plot(1:10, Any[rand(10), sin])    ),           # 2 series: rand(10) and map(sin,x)
    ]

    @testset for f in funciones
        grafico = f()
        @test grafico isa Grafico
    end
end

@testitem "Test métodos en la interfaz de Plots que Graficos no handlea" begin
    using Graficos:plot
    funciones = [
        () -> plot(),                                   # empty Plot object   XX: En Graficos no tiene sentido crear un gráfico vacío, almenos por ahora.
        () -> plot(4)                                      # initialize with 4 empty series XX: Igual que el anterion, no tiene sentido un gráfico vacío
    ]

    @testset for f in funciones
        @test_throws ArgumentError f()
    end
end

@testitem "Test metodos de multiples series" begin
    using Graficos:plot, Grafico
    @testset for f in 1:10
        n_cols = rand(1:100)
        m = rand(10, n_cols)
        grafico = plot(m)
        @test length(grafico.series) == n_cols
    end
end