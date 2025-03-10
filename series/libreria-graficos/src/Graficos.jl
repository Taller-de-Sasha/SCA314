module Graficos

using Printf

include("escaleo.jl")
include("ejes.jl")

FIG_WIDTH = 420
FIG_HEIGHT = 420

PLOT_X_OFFSET = 10
PLOT_Y_OFFSET = 10

PLOT_WIDTH = FIG_WIDTH - 2 * PLOT_X_OFFSET
PLOT_HEIGHT = FIG_HEIGHT - 2 * PLOT_Y_OFFSET

N_DIVISIONES = 5+2

como_string(x, y) = "$x,$y"

numero_formateado(x) = Printf.@sprintf("%.2f", x)

escaleo_a_figura_x(x) = PLOT_WIDTH * x + PLOT_X_OFFSET
escaleo_a_figura_y(y) = PLOT_HEIGHT - (PLOT_HEIGHT * y) + PLOT_Y_OFFSET

function puntos(data)
  points = join(map(p -> como_string(p[1], p[2]), data), " ")

  """
  <polyline
  points="$points"
  fill="none"
  stroke="none"
  marker-start="url(#dot)"
  marker-mid="url(#dot)"
  marker-end="url(#dot)" />
  """
end

function ejes_verticales(puntos, color)
  function l(label, x)
  """
  <line x1="$x" y1="$(PLOT_Y_OFFSET)" x2="$x" y2="$(PLOT_Y_OFFSET+PLOT_HEIGHT)" stroke="$color" stroke-width="1" />
  <line x1="$x" y1="$(PLOT_Y_OFFSET+PLOT_HEIGHT)" x2="$x" y2="$(PLOT_Y_OFFSET+PLOT_HEIGHT-5)" stroke="black" stroke-width="1" />
  <text x="$x" y="$(PLOT_Y_OFFSET+PLOT_HEIGHT+10)" font-size="10">$(numero_formateado(label))</text>

  """
  end
  join(map(p->l(p[1],p[2]), puntos),"\n")
end

function ejes_horizontales(puntos, color)
  function l(label, y)
  """
  <line x1="$(PLOT_X_OFFSET)" y1="$y" x2="$(PLOT_X_OFFSET+PLOT_WIDTH)" y2="$y" stroke="$color" stroke-width="1" />
  <line x1="$(PLOT_X_OFFSET)" y1="$y" x2="$(PLOT_X_OFFSET+5)" y2="$y" stroke="black" stroke-width="1" />
  <text x="$(PLOT_X_OFFSET/2)" y="$y" font-size="10">$(numero_formateado(label))</text>

  """
  end
  join(map(p->l(p[1],p[2]), puntos),"\n")
end


function ejes_origen(x,y, rangos, color)
  rx, ry = rangos
  ejes = ""
  if (rx.min < 0 && rx.max > 0) 
    ejes *= """
    <line x1="$x" y1="$(PLOT_Y_OFFSET)" x2="$x" y2="$(PLOT_Y_OFFSET+PLOT_HEIGHT)" stroke="$color" stroke-width="1" />
    <text x="$x" y="$(PLOT_Y_OFFSET+PLOT_HEIGHT+10)" font-size="10">0.0</text>
    """  
  end
  
  if (ry.min < 0 && ry.max > 0)
    ejes *= """
    <line x1="$(PLOT_X_OFFSET)" y1="$y" x2="$(PLOT_X_OFFSET+PLOT_WIDTH)" y2="$y" stroke="$color" stroke-width="1" />
    <text x="$(PLOT_X_OFFSET/2)" y="$y" font-size="10">0.0</text>
    """
  end
  
  ejes
end

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

  data_escalada = [(Fx(x), Fy(y)) for (x, y) in data]

  points = puntos(data_escalada)

  ejes_v = ejes_verticales(puntos_eje(N_DIVISIONES, r.x, Fx),"green")
  ejes_h = ejes_horizontales(puntos_eje(N_DIVISIONES, r.y, Fy), "yellow")
  ejes_o = ejes_origen(Fx(0), Fy(0), r, "magenta")

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
  $ejes_v
  $ejes_h

  $ejes_o

  $points
</svg> 
"""
end


mostrar(svg) = display("image/svg+xml", svg)

plot(f) = template(map(x -> (x, f(x)), -5:0.05:5))

end # module Graficos
