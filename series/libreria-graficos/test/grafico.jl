using TestItem

@testitem "Construcción de Grafico" begin
    using Graficos:Grafico, Serie

    # Test de la construcción de un objeto Grafico
    data = [(10,10),(200,200),(400,400)]
    serie = Serie(data, "blue", "label") #whisky?
    grafico = Grafico([serie])

    @test grafico.series[1].data == data
    @test grafico.series[1].color == "blue"
    @test grafico.series[1].label == "label"
end
