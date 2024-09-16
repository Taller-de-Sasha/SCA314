---
theme: solarized
enableMenu: false
---

# SCA314

--

![logo](imagenes/logo_sca.svg)

<a class="fragment" href="https://www.youtube.com/@SCA314"><i class="fa fa-youtube-play"></i>  @SCA314 </a>

<a class="fragment" href="https://www.github.com/Taller-de-Sasha/SCA314"><i class="fa fa-github"></i>  Taller-De-Sasha/SCA314 </a>

---

# Pruebas Automatizadas

---

## Parte 5

Implementar nuevas interpolaciones {class="fragment"}

--

<iframe width="560" height="315" src="https://www.youtube.com/embed/IdhnP00Y1Ks?si=TyqiIl40JcJxiTlv" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

[Charlas de VSCode en JuliaCon](https://www.youtube.com/results?search_query=juliacon+vscode)

--

- Implementar Interpolación Lineal
- Extender la forma de crear la interpolación 
    `[(x1,y1) ... (xN,yN)]`, `[x1, ..., xN], [y1, ..., yN]`, `{x1:y1, ... ,xN:yN}`
- Leer puntos de interpolación desde un archivo

---

## Parte 4

Armar Gráficos para validar implementación {class="fragment"}

--

Información que queremos observar:

- Puntos **de** interpolación
- $N$ puntos evaluando la interpolación

---

## Parte 3

Configurar el Ambiente de Trabajo {class="fragment"}

--

Antes de completar las tareas de la Parte 2 que quedaron pendientes:

- Implementar la Interpolación Lineal
- Implementar una utilidad para ver el gráfico de la interpolación

--

Configurar el Ambiente de Trabajo para:

- Correr las pruebas automatizadas
- Usar el Debugger

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