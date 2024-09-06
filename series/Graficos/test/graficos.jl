using Graficos

@testset "Test1" begin
    data = [(10,10),(200,200),(400,400)]
    svg = Graficos.template(data, "blue");

    esperado = read(open(joinpath(@__DIR__,"datos_pruebas","scatter.svg")),String)

    @test svg == esperado
end
