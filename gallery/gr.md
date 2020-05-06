@def title = "GR.jl"

This example is taken from https://mybinder.org/v2/gh/jheinen/GR.jl/master

```julia:gr
using GR

GR.inline("mov")
x = collect(0:0.01:2*pi)
for i = 1:100
    GR.plot(x, sin.(x .+ i / 10.0), size=(400,300))
end

s = GR.show()
# render as HTML tag # hide
println("~~~") # hide
println(s.s) # hide 
println("~~~") #hide
```

\textoutput{gr}

