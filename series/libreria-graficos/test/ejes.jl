using Graficos
using TestItem


@testitem "Creacion de los ejes con datos en rango simétrico" begin
   inicio = -5
   fin = 10 
   divisiones = 5
   actual = Graficos.puntos_eje(divisiones, x->x)
   esperado = [0.0, 0.25, 0.5, 0.75, 1.0]
   @test actual == esperado
end

@testitem "Creacion de los ejes con datos en rango asimétrico" begin
    inicio = -1
    fin = 10 
    divisiones = 10
    actual = Graficos.puntos_eje(divisiones, x->x)
    esperado = []
    @test actual == esperado
 end

 @testitem "Creacion de los ejes con datos que no incluye el origen" begin
    inicio = -100
    fin = -10
    divisiones = 10
    actual = Graficos.puntos_eje(divisiones, x->x)
    esperado = []
    @test actual == esperado
 end