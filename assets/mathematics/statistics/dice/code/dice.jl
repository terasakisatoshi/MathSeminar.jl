# This file was generated, do not modify it. # hide
using Statistics
using Plots
pyplot()
using LaTeXStrings
using Distributions

dice = [1, 2, 3, 4, 5, 6]
μ_dice = mean(dice)
σ_dice = std(dice, corrected = false)

n_sample = 500
n_trial = 3000

X̄ = Float64[]
for t = 1:n_trial
    sample = rand(dice, n_sample)
    push!(X̄, mean(sample))
end

Z = (X̄ .- μ_dice) ./ (σ_dice / √(n_sample))
p = histogram(Z, normalize = :pdf, label="sample mean")
d = Normal(0., 1.)
plot!(p, x -> pdf(d, x), label=L"\mathcal{N}(μ,σ^2)")
p = plot!(p, xlim = [-3, 3])
Plots.savefig(p, joinpath(@OUTPUT, "dice.svg")) # hide