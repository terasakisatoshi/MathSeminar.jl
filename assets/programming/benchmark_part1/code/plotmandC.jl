# This file was generated, do not modify it. # hide
using DelimitedFiles
using Plots
gr()
img = readdlm("/tmp/benchC.txt",',',Int)
M,N = img |> size
p=heatmap(1:N, 1:M, img, aspect_ratio=1, size=(400,400))
savefig(p, joinpath(@OUTPUT, "mandC.png")) #hide