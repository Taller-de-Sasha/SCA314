module Graficos

export escalear

width = 400
height = 400

como_string(x,y) = "$x,$y"


# Tomar el minimo y maximo de cada eje y escalar los datos al 90% del tamaño del eje
function escalear_(data, width, height)
  min_x, max_x = extrema(map(x -> x[1], data))
  min_y, max_y = extrema(map(x -> x[2], data))
   scale = 0.9
   shift = 10
  x_scale = scale * width / (max_x - min_x)
  y_scale = scale * height / (max_y - min_y)
  return [(x_scale * (x - min_x )+shift, y_scale * (y - min_y)+shift) for (x, y) in data]
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
function escalear(data)    escalear_(data, width-20, height-20)
end

puntos(data) = join(map( p ->como_string(p[1], height-p[2]), escalear(data))," ")


"""
Genera una cadena de puntos SVG a partir de los datos proporcionados.

La función `template` toma una lista de pares de coordenadas `(x, y)` y genera una cadena de puntos SVG que se puede usar para dibujar una polilínea u otra forma SVG. La función `puntos` se utiliza para convertir los pares de coordenadas a un formato de cadena que se puede usar en el marcado SVG.

Args:
    data (Tuple{Number, Number}[]): Una lista de pares de coordenadas `(x, y)` para convertir a puntos SVG.
    color (String): El color a usar para los marcadores SVG (por defecto es "rojo").

Returns:
    String: Una cadena de puntos SVG que se puede usar para dibujar una polilínea u otra forma SVG.
"""
function template(data, color="red") 
   points = puntos(data)
"""
<svg height="$height" width="$width" xmlns="http://www.w3.org/2000/svg" style="background-color: white; border: 10px solid black"> 
  <defs>
    <!-- Dot marker definition -->
    <marker
      id="dot"
      viewBox="0 0 10 10"
      refX="5"
      refY="5"
      markerWidth="5"
      markerHeight="5">
      <circle cx="5" cy="5" r="5" fill="$color" />
    </marker>
  </defs>

  <rect x="10" y="10" width="$(width-20)" height="$(height-20)" fill="none" stroke="black" stroke-width="1" />
  
    <polyline
    points="$points"
    fill="none"
    stroke="none"
    marker-start="url(#dot)"
    marker-mid="url(#dot)"
    marker-end="url(#dot)" />
</svg> 
"""
end
mostrar(svg) =  display("image/svg+xml", svg)
end # module Graficos
