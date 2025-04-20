using Graficos
using TestItem


@testitem "Creacion de los ejes con datos en rango simétrico" begin
   divisiones = 5
   rango=(min=-5, max=10)
   actual = Graficos.puntos_eje(divisiones, rango, x->x)
   esperado = [(-5.0, -5.0), (-1.25, -1.25), (2.5, 2.5), (6.25, 6.25), (10.0, 10.0)]
   @test actual == esperado
end

@testitem "Creacion de los ejes con datos en rango asimétrico" begin
    divisiones = 10
    rango=(min=-1, max=10)
    actual = Graficos.puntos_eje(divisiones, rango, x->x)
    esperado = [(-1.0, -1.0), 
                (0.2222222222222222, 0.2222222222222222),
                (1.4444444444444444, 1.4444444444444444),
                (2.6666666666666665, 2.6666666666666665), 
                (3.888888888888889, 3.888888888888889), 
                (5.111111111111111, 5.111111111111111), 
                (6.333333333333333, 6.333333333333333),
                (7.555555555555555, 7.555555555555555), 
                (8.777777777777779, 8.777777777777779),
                (10.0, 10.0)]
    @test actual == esperado
 end

 @testitem "Creacion de los ejes con datos que no incluye el origen" begin
    divisiones = 10
    rango=(min=-100, max=-10)
    actual = Graficos.puntos_eje(divisiones, rango, x->x)
    esperado = [(-100.0, -100.0), (-90.0, -90.0), (-80.0, -80.0), 
                (-70.0, -70.0), (-60.0, -60.0), (-50.0, -50.0), 
                (-40.0, -40.0), (-30.0, -30.0), (-20.0, -20.0), (-10.0, -10.0)]
    @test actual == esperado
 end