using Graficos
using TestItem


@testsnippet Setups begin
    function escribir_resultado(resultado, nombre_archivo)
        mkpath(dirname(nombre_archivo))
        open(nombre_archivo, "w") do io
            write(io, resultado)
        end
    end
end    

@testitem "Test interfaz de Graficos" setup=[Setups] begin
    const sobre_escribir_resultados = false
    @testset "Test1" begin
        data = [(10,10),(200,200),(400,400)]
        svg = Graficos.template(data, "blue");

        path = joinpath(@__DIR__,"datos_pruebas","scatter.svg")

        if sobre_escribir_resultados
            escribir_resultado(svg, path)
            @test sobre_escribir_resultados == false
        end

        esperado = read(open(path),String)

        @test svg == esperado
    end
end

@testitem "Test ejemplos funciones" setup=[Setups] begin
    const sobre_escribir_resultados = false

    funciones = [
        ( x-> -x+1, "lineal" ),
        ( x -> x*x-3, "cuadratica" ),
        ( x -> exp(4x)-2, "exponencial"),
        ( x -> 3sin(x/5), "seno"),
        ( x -> max(x-1, 0), "maximo")
        ]

        @testset for (f, nombre) in funciones
            path = joinpath(@__DIR__,"datos_pruebas", "ejemplos", "$nombre.svg")
            svg = Graficos.plot(f)

            if sobre_escribir_resultados
                escribir_resultado(svg, path)
                @test sobre_escribir_resultados == false
            end
            @test svg == read(open(path),String)
        end

end


