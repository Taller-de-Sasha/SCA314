using Graficos
using TestItem

@testitem "Si hay un único punto en la data" begin
    data = [(400,400)]
    esperado = [(0.5,0.5)]
    # testear que esto vale para cualquier punto (x,y)
    @test Graficos.escalear_a_unitario(data) == esperado
end

@testitem "Si hay solo dos puntos en la data con el mismo x" begin
    data = [(0,0), (0, 10)]
    esperado = [(0,0), (0,1)]
    @test Graficos.escalear_a_unitario(data) == esperado
end

@testitem "Si hay solo dos puntos en la data con el mismo y" begin
    data = [(0,0), (10, 0)]
    esperado = [(0,0), (1,0)]
    @test Graficos.escalear_a_unitario(data) == esperado
end

@testitem "Si hay solo dos puntos" begin
    data = [(0,0), (10, 20)]
    esperado = [(0,0), (1,1)]
    @test Graficos.escalear_a_unitario(data) == esperado
end

@testitem "Los extremos" begin
    data = [(0,0), (10, 20), (1000,200)] 
    escaleada = Graficos.escalear_a_unitario(data)
    @test minimum(escaleada) == (0,0)
    @test maximum(escaleada) == (1,1)
end

@testitem "Los extremos aparecen cruzados" begin
    data = [(0,0), (10, 20), (50,10)] 
    escaleada = Graficos.escalear_a_unitario(data)
    @test escaleada == [(0.0,0.0), (0.2, 1.0), (1.0, 0.5)]
end


@testitem "Escaleo" begin
    @testset "Escaleo1" begin
        ancho, alto = 400, 600
        data = [(0,0), (10, 20), (50,10)] 
        escaleada = Graficos.escalear(data, ancho, alto)
        @test escaleada == [(0.0,0.0), (80.0, 600.0), (400.0, 300.0)]
    end
end

