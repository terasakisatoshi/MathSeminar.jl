# This file was generated, do not modify it. # hide
using Plots
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