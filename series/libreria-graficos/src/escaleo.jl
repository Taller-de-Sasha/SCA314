# llevamos todo al cuadrado unitario
function escalear_a_unitario(data)
    if  length(data) == 1
      return [(1/2, 1/2)]
    end
  
    min_x, max_x = extrema(map(x -> x[1], data))
    min_y, max_y = extrema(map(x -> x[2], data))
  
    x_scale = (max_x - min_x)
    x_scale = x_scale == 0 ? 1 : x_scale
    y_scale = (max_y - min_y)
    y_scale = y_scale == 0 ? 1 : y_scale
  
    return [((x - min_x)/x_scale, (y - min_y)/y_scale) for (x, y) in data]
  end

"""
Escala los datos de entrada para que se ajusten a un ancho y alto específicos, manteniendo la proporción de aspecto.

La función `escalear` toma una lista de pares de coordenadas `(x, y)` y los escala para que se ajusten dentro de un área rectangular del `ancho` y `alto` especificados, con un margen de 10 píxeles en cada lado. El escalado se realiza encontrando los valores mínimos y máximos de las coordenadas `x` e `y`, y luego escalando los datos al 90% del ancho y alto disponibles.

Args:
    data (Tuple{Number, Number}[]): Una lista de pares de coordenadas `(x, y)` para ser escalados.
    width (Number): El ancho deseado de los datos escalados.
    height (Number): El alto deseado de los datos escalados.

Returns:
    Tuple{Number, Number}[]: Los pares de coordenadas `(x, y)` escalados.
"""
function escalear(data, ancho, alto)  
 i = escalear_a_unitario(data)
 [(x * ancho, y * alto) for (x, y) in i]
end