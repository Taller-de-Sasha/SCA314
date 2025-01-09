push!(LOAD_PATH,"../src/")
using Documenter, Graficos

makedocs(sitename="Graficos", repo="https://github.com/Taller-de-Sasha/sca314.git")

deploydocs(
    repo="https://github.com/Taller-de-Sasha/sca314.git"
)