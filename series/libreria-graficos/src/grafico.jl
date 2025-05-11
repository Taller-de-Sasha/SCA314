struct Serie
    data::Vector{Tuple{Float64,Float64}}
    color::String
    label::String

    function Serie(data::Vector{Tuple{Float64,Float64}}; color::String="red", label::String="l")
        new(data, color, label)
    end
end


struct Grafico 
    series::Vector{Serie}
end

