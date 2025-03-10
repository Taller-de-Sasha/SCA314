module Graficos

export escalear

include("escaleo.jl")

fig_width = 420
fig_height = 420

xoff = 10
yoff = 10

width = fig_width - 2*xoff
height = fig_height - 2*yoff


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
<svg height="$(fig_height)" width="$(fig_width)" xmlns="http://www.w3.org/2000/svg" style="background-color: white; border: 2px solid blue"> 
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

  <rect x="0" y="0" width="$(fig_width)" height="$(fig_height)" fill="none" stroke="green" stroke-width="1" />
  
  <!-- Axes -->
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


plot(f) = template(map(x->(x,f(x)), -5:0.05:5))

end # module Graficos
