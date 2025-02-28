module Graficos

export escalear

include("escaleo.jl")

fig_width = 420
fig_height = 420

width = fig_width - 20
height = fig_height - 20

xoff = 20
yoff = 20

como_string(x,y) = "$x,$y"


puntos(data) = join(map( p ->como_string(p[1]+xoff, height-p[2]+yoff), escalear(data, width, height))," ")


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

  <rect x="0" y="0" width="$(fig_width)" height="$(fig_height)" fill="none" stroke="blue" stroke-width="1" />
  <rect x="$(xoff)" y="$(yoff)" width="$(width)" height="$(height)" fill="none" stroke="black" stroke-width="1" />
  
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
