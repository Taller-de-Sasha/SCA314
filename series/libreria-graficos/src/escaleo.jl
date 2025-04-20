# llevamos todo al cuadrado unitario

function calcular_rangos(data)

  min_x, max_x = extrema(map(x -> x[1], data))
  min_y, max_y = extrema(map(x -> x[2], data))
  
  x_scale = (max_x - min_x)
  x_scale = x_scale == 0 ? 1 : x_scale
  y_scale = (max_y - min_y)
  y_scale = y_scale == 0 ? 1 : y_scale

  (x=(min=min_x, max=max_x, scale=x_scale), y=(min=min_y, max=max_y, scale=y_scale))
end

function funciones_de_escaleo_a_unitario(data, rangos)

  if  length(data) == 1
    return (x->1/2, y->1/2)
  end

  ((min_x, max_x, x_scale), (min_y, max_y, y_scale)) = rangos

  fx(x) = (x - min_x)/x_scale
  fy(y)= (y - min_y)/y_scale

  (fx=fx, fy=fy)
end

function escalear_a_unitario(data)
    fx, fy = funciones_de_escaleo_a_unitario(data, calcular_rangos(data))
    return [(fx(x), fy(y)) for (x, y) in data]
end