# This file was generated, do not modify it. # hide
n_trial = 100000
X = rand(d, n_trial)
Y = rand(d, n_trial)
X² = X .^ 2
Y² = Y .^ 2
p=plot()

histogram!(p, X².+Y², normalize=:pdf, label=L"X^2+Y^2")
x = range(0.01,2,length=100)
y = T.(2, x)
plot!(p, x, y,xlim=[0,5], ylim=[0,0.5], label=L"T_3")

χ² = Chisq(2)

y = pdf.(χ², x)
χ² = Chisq(2)
plot!(p, x, y, label=L"\chi^2(2)",line=:dash)
savefig(joinpath(@OUTPUT, "deg2.png")) #hide