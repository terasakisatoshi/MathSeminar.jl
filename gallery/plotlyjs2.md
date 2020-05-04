@def title = "PlotlyJS Example2"
@def hasmath = true
@def hascode = true
@def hasplotly = true

\chapter{PlotlyJS の例}


```julia:plotly3d
using PlotlyJS
function random_line()
    a=0.1

    us = 0:0.05π:2π
    ts = -1:0.05:1
    traces=typeof(scatter3d())[]
    marker=attr(
        color="#1f77b4",
        size=12,
        symbol="circle",
        line=attr(color="rgb(0,0,0)", width=0),
    )
    for t in ts
        x=@. (t^2+a)*cos(us)
        y=@. (t^2+a)*sin(us)
        z=t*ones(length(x))
        push!(
            traces,
            scatter3d(
                x=x,y=y,z=z,
                mode="lines",
                marker=marker,
                showlegend=false,
            )
        )
    end

    for u in us
        x = @. (ts^2+a)*cos(u)
        y = @. (ts^2+a)*sin(u)
        z = ts
        push!(
            traces,
            scatter3d(
                x=x,y=y,z=z,
                mode="lines",
                marker=marker,
                showlegend=false
            )
        )
    end

    layout = Layout(
        autosize=true,
        width=500,
        height=500,
        margin=attr(l=0, r=0, b=150, t=0),
    )
    plot(traces,layout)
end

p = random_line()
fdplotly(json(p)) # hide
```

\textoutput{plotly3d}
