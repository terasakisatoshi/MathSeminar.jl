# This file was generated, do not modify it. # hide
n_trial = 100000
X = rand(d, n_trial)
Y = rand(d, n_trial)
Z = rand(d, n_trial)
X² = X .^ 2
Y² = Y .^ 2
Z² = Z .^ 2
p = plot()
histogram!(p, X².+Y².+Z², normalize=:pdf, label=L"X^2+Y^2+Z^2")
χ² = Chisq(3)

x = range(0.01,2,length=100)
y = T.(3, x)
plot!(p, x, y,xlim=[0,5], ylim=[0,0.5], label=L"T_3")
y = pdf.(χ², x)

plot!(p, x, y, label=L"\chi^2(3)",line=:dash)
savefig(joinpath(@OUTPUT, "deg3.png")) #hide