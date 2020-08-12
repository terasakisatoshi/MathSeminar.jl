@def title = "GR.jl"

This example is taken from https://mybinder.org/v2/gh/jheinen/GR.jl/master

```julia:gr
using GR

GR.inline("mov")
x = collect(0:0.01:2*pi)
for i = 1:30
    GR.plot(x, sin.(x .+ 3i / 10.0), size=(400,300))
end

s = GR.show()
println("~~~$(s.s)~~~")
GR.inline("png")
```

\textoutput{gr}
