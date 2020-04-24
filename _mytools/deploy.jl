using Pkg

Pkg.add(["NodeJS", "Franklin", "Literate", "Remark"])
Pkg.add(["WebIO", "Plotly", "PlotlyJS", "ORCA"])
run(`$(npm_cmd()) install highlight.js`)

using NodeJS, Franklin, Remark

Pkg.activate(".")
Pkg.instantiate()
Remark.slideshow("./remark/example.jl", "./remark")
optimize(minify = false)
