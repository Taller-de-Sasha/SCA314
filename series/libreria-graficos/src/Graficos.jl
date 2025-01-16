module Graficos

export escalear

fig_width = 400
fig_height = 400

width = fig_width - 20
height = fig_height - 20

como_string(x,y) = "$x,$y"

# Tomar el minimo y maximo de cada eje y escalar los datos al 90% del tamaño del eje
function escalear_(data, width, height)
  if  length(data) == 1
    return [(width/2,height/2)]
  end

  min_x, max_x = extrema(map(x -> x[1], data))
  min_y, max_y = extrema(map(x -> x[2], data))
  
  scale = 1.0
  shift = 0.0
  
  x_scale = scale * calcular_escala(min_x, max_x, width)
  y_scale = scale * calcular_escala(min_y, max_y, height)
  
  x_shift = calcular_offset(min_x, max_x, width)
  y_shift = calcular_offset(min_y, max_y, height)

  return [(x_scale * (x - x_shift)+shift, y_scale * (y - y_shift)+shift) for (x, y) in data]
end

function calcular_offset(min, max, rango) 
  if min == max
    return rango/2
  end
  0.0
end

function calcular_escala(min_x, max_x, length)
  if  min_x == max_x
    return 1.0
  end

  length / (max_x - min_x)
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
function escalear(data)  
  escalear_(data, width, height)
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
