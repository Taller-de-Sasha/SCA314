---
theme: simple
enableMenu: false
---

# SCA314

--

![logo](https://raw.githubusercontent.com/Taller-de-Sasha/SCA314/refs/heads/main/logo/logo_sca.svg)

<a class="fragment" href="https://www.youtube.com/@SCA314"><i class="fa fa-youtube-play"></i>  @SCA314 </a>

<a class="fragment" href="https://www.github.com/Taller-de-Sasha/SCA314"><i class="fa fa-github"></i>  Taller-De-Sasha/SCA314 </a>

---

# Desarrollo de una Librería

---

## Parte 3

Registrar el paquete {class="fragment"}

--

- Vamos a registrar el paquete en para que otros puedan usarlo 

```julia-repl
pkg> add Graficos
```

---

## Parte 2

Configuración de CI/CD {class="fragment"}

- Vamos a configurar los tests para correrlos en VSCode con [TestItemRunner](https://github.com/julia-vscode/TestItemRunner.jl)
- Vamos a configurar el CI/CD para que se corren los tests en GitHub Actions en cada Pull Request

---

Librería para hacer gráficos de funciones interpoladas en [SVG](https://en.wikipedia.org/wiki/SVG)

<svg class="fragment" height="100" width="100" xmlns="http://www.w3.org/2000/svg">
  <circle r="45" cx="50" cy="50" fill="red" />
</svg> 

```xml {class="fragment"}
<svg height="100" width="100" xmlns="http://www.w3.org/2000/svg">
  <circle r="45" cx="50" cy="50" fill="red" />
</svg> 
```

---

## Parte 1

Armado del paquete {class="fragment"}

--

--

- Configurar un paquete desde cero
    - src/tests, deps
- Mostrar imagen en VSCode
- Configurar CI/CD

--

Otras características (**features**) para explorar

- [*Pretty Printing*](https://docs.julialang.org/en/v1/manual/types/#man-custom-pretty-printing)
- [*Package Extensions*](https://pkgdocs.julialang.org/v1/creating-packages/#Conditional-loading-of-code-in-packages-(Extensions))
- [*Plots Recipes*](https://docs.juliaplots.org/latest/recipes/)
- [*MOJUWO (Modern Julia Workflows)*](https://modernjuliaworkflows.org/sharing/)
    - Calidad del código
    - Documentación
    - Registrar y publicar la librería

---

