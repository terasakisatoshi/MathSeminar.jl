# This ensures that NodeJS and Franklin are loaded then it installs
# highlight.js which is needed for the prerendering step.
# Then the environment is activated and instantiated to install all
# Julia packages which may be required to successfully build your site.
# NOTE: the last line should be `optimize()`, you may want to give it
# specific arguments, see the documentation or ?optimize in the REPL.

using Pkg
using NodeJS

run(`$(npm_cmd()) install highlight.js`)

Pkg.build("Franklin")

using Franklin, Remark, Weave

Pkg.activate(".")
Pkg.instantiate()

# make slide
Remark.slideshow("./slideshow/remark")
Remark.slideshow("./slideshow/franklin")
Remark.slideshow("./slideshow/dash", options = Dict("ratio" => "16:9"), title = "Dash.jl")
Remark.slideshow("./slideshow/binarybuild", options = Dict("ratio" => "16:9"), title = "BinaryBuilder.jl")


weave(joinpath("./programming", "weave.jmd"), out_path="./programming", doctype="github")
optimize(minify=false, prepath="MathSeminar.jl", clear=true)
