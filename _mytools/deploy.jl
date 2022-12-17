# This ensures that NodeJS and Franklin are loaded then it installs
# highlight.pack.js which is needed for the prerendering step.
# Then the environment is activated and instantiated to install all
# Julia packages which may be required to successfully build your site.
# NOTE: the last line should be `optimize()`, you may want to give it
# specific arguments, see the documentation or ?optimize in the REPL.

using Pkg
using NodeJS

run(`$(npm_cmd()) install highlight.pack.js`)

Pkg.build("Franklin")

using Franklin, Remark, Weave

Pkg.activate(".")
Pkg.instantiate()

# make slide
Remark.slideshow("./slideshow/remark", options=Dict("ratio" => "16:9"), title="Remark.jl")
Remark.slideshow("./slideshow/franklin", options=Dict("ratio" => "16:9"), title="Franklin.jl")
Remark.slideshow("./slideshow/dash", options=Dict("ratio" => "16:9"), title="Dash.jl")
Remark.slideshow("./slideshow/binarybuilder", options=Dict("ratio" => "16:9"), title="BinaryBuilder.jl")
Remark.slideshow("./slideshow/myworkflow", options=Dict("ratio" => "16:9"), title="MyWorkflow.jl")
Remark.slideshow("./slideshow/repl", options=Dict("ratio" => "16:9"), title="Do something great in your REPL")
Remark.slideshow("./slideshow/intro2julia", options=Dict("ratio" => "16:9"), title="Intro2Julia")
Remark.slideshow("./slideshow/pycallchainrules", options=Dict("ratio" => "16:9"), title="PyCallChainRules.jl")
Remark.slideshow("./slideshow/replay", options=Dict("ratio" => "16:9"), title="Replay.jl")
Remark.slideshow("./slideshow/pluto", options=Dict("ratio" => "16:9"), title="Intro to Pluto.jl")

weave(joinpath("./programming", "weave.jmd"), out_path="./programming", doctype="github")
optimize(minify=false, prepath="MathSeminar.jl", clear=true)
