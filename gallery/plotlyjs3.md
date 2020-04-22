@def title = "PlotlyJS Example3"
@def hasmath = true
@def hascode = true
@def hasplotly = true

\chapter{Using API from Plots.jl}

- Here is an example for those who would like to call PlotlyJS API from Plots.jl.

\section{Passing JSON which has `layout` and `data` object}

- [Franklin.fdplotly](https://github.com/tlienart/Franklin.jl/blob/2b6423783b4675ab14da74e183545ef2377bdf94/src/manager/extras.jl) function requires `json::String` object as an argument which should contain fields named `layout` and `data`. On the other hand, Plots.jl provides `plotly_layout` and `plotly_series` that build `layout` and `data` respectively. See [here](https://github.com/JuliaPlots/Plots.jl/blob/master/src/backends/plotly.jl) to see more details.

- Here is an short example of creating Plot object from Plots.jl.

\subsection{Example 1}

```julia:easysample
using Plots
using JSON
plotlyjs()

p=plot(rand(10))

fdplotly(
    JSON.json((
        layout = Plots.plotly_layout(p),
        data = Plots.plotly_series(p),
    )); style = "width:300px;height:200x",
)

gr(); #hide
```

\textoutput{easysample}

\subsection{Example 2}

- More complicated example can be executed via the following script:


```julia:usingfdplotly
using Plots
using JSON
plotlyjs()

r = 2.0
N = 20

φ = range(0.0, 2π, length = N)
p = plot()
for θ in range(0, 2π, length = N)
    x = @. r * sin(θ) * cos(φ)
    y = @. r * sin(θ) * sin(φ)
    z = repeat([r * cos(θ)], N)
    scatter!(p, x, y, z, label = false, color = :blue)
end

fdplotly(JSON.json((
    layout = Plots.plotly_layout(p),
    data = Plots.plotly_series(p),
)); style = "width:400px;height:300x",
)
gr(); # hide; back to default backend
```

\textoutput{usingfdplotly}


\section{Using custom function}

- There is another approach that creates our own `fdplotly` function which accepts `p::Plots.Plot` object.
By using `Plots.js_body` function, we can mimic what `Franklin.fdplotly` does:

```julia:fdplotly
using Random
function fdplotly(p::Plots.Plot; 
    id="fdp" * Random.randstring('a':'z', 3),
    style = "width:600px;height:350px")::Nothing
    b = Plots.js_body(p, id)
    println("""~~~<div id="$id" style="$style"></div> <script> $b </script>~~~""") # hide
    return nothing
end
```

\textoutput{fdplotly}

```julia:usingbodyjs
using Plots
using JSON
plotlyjs()

r = 3.0
N = 20

φ = range(0.0, 2π, length = N)
p = plot()
for θ in range(0, 2π, length = N)
    x = @. r * sin(θ) * cos(φ)
    y = @. r * sin(θ) * sin(φ)
    z = repeat([r * cos(θ)], N)
    scatter!(p, x, y, z, label = false, color = :green)
end

fdplotly(p)
gr(); # hide; back to default backend
```

\textoutput{usingbodyjs}