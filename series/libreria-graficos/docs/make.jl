push!(LOAD_PATH,"../src/")
using Documenter, Graficos

repo="https://github.com/Taller-de-Sasha/SCA314.git"
makedocs(;sitename="Graficos",repo)

deploydocs(;
    repo,
    # devbranch="serie/l-g-p3",
    dirname="documenter",
)