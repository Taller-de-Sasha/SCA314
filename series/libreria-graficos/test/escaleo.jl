using Graficos
using TestItem


@testitem "Si hay un único punto en la data" begin
    data = [(400,400)]
    esperado = [(190,190)]
    # testear que esto vale para cualquier punto (x,y)
    @test Graficos.escalear(data) == esperado
end

@testitem "Si hay solo dos puntos en la data con el mismo x" begin
    data = [(0,0), (0, 1)]
    esperado = [(0,0), (0,400)]
    @test Graficos.escalear(data) == esperado
end

@testitem "Si hay solo dos puntos en la data con el mismo y" begin
    data = [(0,0), (1, 0)]
    esperado = [(0,0), (400,0)]
    @test Graficos.escalear(data) == esperado
end