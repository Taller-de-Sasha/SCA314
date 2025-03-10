using Graficos
using TestItem


@testitem "Creacion de los ejes con datos en rango simétrico" begin
   inicio = -10
   fin = 10 
   divisiones = 10
   actual = Graficos.puntos_eje(inicio, fin, divisiones)
   esperado = []
   @test actual == esperado
end

@testitem "Creacion de los ejes con datos en rango asimétrico" begin
    inicio = -1
    fin = 10 
    divisiones = 10
    actual = Graficos.puntos_eje(inicio, fin, divisiones)
    esperado = []
    @test actual == esperado
 end

 @testitem "Creacion de los ejes con datos que no incluye el origen" begin
    inicio = -100
    fin = -10
    divisiones = 10
    actual = Graficos.puntos_eje(inicio, fin, divisiones)
    esperado = []
    @test actual == esperado
 end