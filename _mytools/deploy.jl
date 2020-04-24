using Pkg
using NodeJS
using Franklin
using Remark

Pkg.add(["NodeJS", "Franklin", "Literate", "Remark"])
Pkg.add(["WebIO", "Plotly", "PlotlyJS", "ORCA"])
run(`$(npm_cmd()) install highlight.js`)
Pkg.activate(".")
Pkg.instantiate()
Remark.slideshow("./remark/example.jl", "./remark")
optimize(minify = false)
