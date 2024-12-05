module Graficos

width = 400
height = 400

como_string(x,y) = "$x,$y"
puntos(data) = join(map( p ->como_string(p[1], height-p[2]),data)," ")

function template(data, color="red") 
   points = puntos(data)
"""
<svg height="$height" width="$width" xmlns="http://www.w3.org/2000/svg"> 
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
