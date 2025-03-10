module Graficos

include("escaleo.jl")
include("ejes.jl")

FIG_WIDTH = 420
FIG_HEIGHT = 420

PLOT_X_OFFSET = 10
PLOT_Y_OFFSET = 10

PLOT_WIDTH = FIG_WIDTH - 2*PLOT_X_OFFSET
PLOT_HEIGHT = FIG_HEIGHT - 2*PLOT_Y_OFFSET


como_string(x,y) = "$x,$y"


escaleo_a_figura_x(x) = PLOT_WIDTH*x + PLOT_X_OFFSET
escaleo_a_figura_y(y) = PLOT_HEIGHT - (PLOT_HEIGHT*y) + PLOT_Y_OFFSET

puntos(data) = join(map( p -> como_string(p[1], p[2]), data)," ")


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
   r = calcular_rangos(data)
   (fx, fy) = funciones_de_escaleo_a_unitario(data, r)
   Fx(x) = escaleo_a_figura_x(fx(x))
   Fy(y) = escaleo_a_figura_y(fy(y))

   data_escalada =  [(Fx(x), Fy(y)) for (x, y) in data]
   points = puntos(data_escalada)

  """
<svg height="$(FIG_HEIGHT)" width="$(FIG_WIDTH)" xmlns="http://www.w3.org/2000/svg" style="background-color: white; border: 2px solid blue"> 
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

  <!-- <rect x="0" y="0" width="$(FIG_WIDTH)" height="$(FIG_HEIGHT)" fill="none" stroke="green" stroke-width="5" /> -->
  
  <!-- Axes -->
  <rect x="$(PLOT_X_OFFSET)" y="$(PLOT_Y_OFFSET)" width="$(PLOT_WIDTH)" height="$(PLOT_HEIGHT)" fill="none" stroke="black" stroke-width="1" />
  
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
