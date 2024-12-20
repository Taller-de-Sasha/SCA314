using Test
using TestItems
using PruebasA

@testsnippet Setup begin
interpolaciones = [ 
                    PruebasA.interpolacion_constante, 
                    PruebasA.interpolacion_lineal
                    ]
end
            
@testitem "Interpolación falla con colecciones vacias" setup=[Setup] begin
    # data = []
    @testset for data in [ ([],), ([],[]), (Dict(),) ], interp in interpolaciones
         @test_throws AssertionError interp(data...)
    end
end

@testitem "Interpolación falla con colecciones desordenadas" setup=[Setup] begin
    @testset for data in [ ([(0.0, 0.0), (-10.0, 1.0)],) ], interp in interpolaciones
         @test_throws AssertionError interp(data...)
    end
end


@testitem "Interpolación falla con colecciones desparejas" setup=[Setup] begin
    @testset for data in [ ([0.0,0.1], [0.1] ) ], interp in interpolaciones
         @test_throws AssertionError interp(data...)
    end
end

@testitem "Interpolación falla con colecciones desparejas" setup=[Setup] begin
    @testset for data in [ ([0.0,0.1], [1.0, NaN] ), ([(NaN, 1.0), (0.0, NaN)],) ], interp in interpolaciones
        @test_throws AssertionError interp(data...)
    end
end

@testitem "Interpolación falla con colecciones desparejas" setup=[Setup] begin
    @testset for data in [ ([0.0,0.0], [0.1, 0.2] ) ], interp in interpolaciones
         @test_throws AssertionError interp(data...)
    end
end

# @testitem "Interpolación falla con colecciones desparejas" setup=[Setup] begin
#     @testset for data in [ ([0.0,0.1], [0.1] ) ], interp in interpolaciones
#         #  @test_throws AssertionError interp(data...)
#         f = interp(data...)
#         @test f(0.0) == 0.0
#     end
# end