from juliacall import Main as jl

jl.seval("using LinearAlgebra")
solve_julia = jl.seval(r"f(M, v) = M\v")
