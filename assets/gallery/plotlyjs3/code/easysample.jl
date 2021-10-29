# This file was generated, do not modify it. # hide
using Plots
using JSON
plotlyjs()

p=plot(rand(15))

fdplotly(
    JSON.json((
        layout = Plots.plotly_layout(p),
        data = Plots.plotly_series(p),
    )); style = "width:300px;height:200x",
)

gr(); #hide