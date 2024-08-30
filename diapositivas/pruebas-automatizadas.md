---
theme: solarized
enableMenu: false
---

# SCA314

--

<a class="fragment" href="https://www.youtube.com/@SCA314"><i class="fa fa-youtube-play"></i>  @SCA314 </a>

<a class="fragment" href="https://www.github.com/Taller-de-Sasha/SCA314"><i class="fa fa-github"></i>  Taller-De-Sasha/SCA314 </a>

---

# Pruebas Automatizadas

---

## Parte 1

Entendiendo la Interpolación Numérica {class="fragment"}

--

> Dado un conjunto de puntos quiero crear una función (matemática) que pase por los mismos.

--

```julia
[(-1,1),(0,0),(1,1)]
```

---

## Parte 2

Re-estructurando el proyecto {class="fragment"}

--

Separar el código en:

- Código funcional
- Código de las pruebas 

--

Requerimientos:

- Definir dos métodos de interpolación: **Lineal a tramos** y **Constante a tramos**
- Leer los puntos de interpolación desde un archivo {class="fragment"}
- Hacer un gráfico para validar que esté bien la interpolación {class="fragment"}
