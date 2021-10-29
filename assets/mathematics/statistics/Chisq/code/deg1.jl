# This file was generated, do not modify it. # hide
n_trial = 100000
X = rand(d, n_trial)
X² = X .^ 2.
p = plot()
histogram!(p, X², normalize=:pdf, label=L"X^2")
x = range(0.01,2,length=100)
y = T.(1, x)
plot!(p, x, y, xlim=[0,2], ylim=[0,4], label=L"T_1")

y = pdf.(Chisq(1), x)
plot!(p, x, y, line=:dash, label=L"\chi^2(1)") ;
savefig(joinpath(@OUTPUT, "deg1.png")) #hide