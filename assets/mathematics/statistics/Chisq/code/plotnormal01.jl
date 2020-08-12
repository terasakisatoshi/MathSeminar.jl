# This file was generated, do not modify it. # hide
sample = rand(d, 10000)
p = plot(xlim=[-3, 3])
histogram!(sample, normalize=:pdf, label="hist")
plot!(x->pdf(d, x),label="pdf")
savefig(joinpath(@OUTPUT, "normal.png"))