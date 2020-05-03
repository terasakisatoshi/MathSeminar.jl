# This ensures that NodeJS and Franklin are loaded then it installs
# highlight.js which is needed for the prerendering step.
# Then the environment is activated and instantiated to install all
# Julia packages which may be required to successfully build your site.
# NOTE: the last line should be `optimize()`, you may want to give it
# specific arguments, see the documentation or ?optimize in the REPL.

using Pkg
using NodeJS, Franklin, Remark

run(`$(npm_cmd()) install highlight.js`)

Pkg.activate(".")
Pkg.instantiate()

Remark.slideshow("./slideshow/tutorial/example.jl", "./slideshow/tutorial")
Remark.slideshow("./slideshow/juliatokai/document.jl", "./slideshow/juliatokai")
optimize(minify=false, prepath="MathSeminar.jl")
