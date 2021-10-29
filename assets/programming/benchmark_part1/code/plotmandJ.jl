# This file was generated, do not modify it. # hide
Refpath="/tmp/benchC.txt"
Tarpath="/tmp/benchJ.txt"
run(`bash -c "cmp --silent $Refpath $Tarpath || echo \"files are different\""`)

using Plots
gr()
using DelimitedFiles
img = readdlm(Tarpath,',',Int)
M,N = img |> size
p = heatmap(1:N,1:M,img,aspect_ratio=1, size=(400, 400))
savefig(p, joinpath(@OUTPUT, "mandJ.png")) #hide