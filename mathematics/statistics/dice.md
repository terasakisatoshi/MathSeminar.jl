@def title = "Statistics"

\initcounter{}

\chapter{統計量の平均, 分散}

\definition{}{標本平均, 標本分散}{
- $n$ 個のサンプル (sample) $X_1,X_2,\dots,X_n$ を独立に取得したとする. サンプルはデーターの観測等の標本抽出するごとに異なる値を得るので確率変数とみなせる. これらの平均, 分散を各々次で定義する:

- 標本平均

$$
\bar{X} = \frac{1}{n} \sum_{i=1}^n X_i.
$$

- 標本分散

$$
S^2 = \frac{1}{n} \sum_{i=1}^n (X_i - \bar{X})^2.
$$
}

\prop{samplemeanvar}{}{
- 平均が $\mu$, 分散が $\sigma^2$ である分布から独立に抽出したサンプルの $\{X_i\}_{i=1}^n$ から定まる標本平均 $\bar{X}$ の平均 $E[\bar{X}]$, 分散 $V(\bar{X})$は各々次で与えられる:
$$
    \begin{aligned} E[\bar{X}] = \mu, && V[\bar{X}] = \frac{\sigma^2}{n}. \end{aligned}
$$
}
\proof{

- $E[\bar{X}]$ の計算をする. 期待値の線形性を利用することで容易に証明できる.

$$
\begin{aligned}
E[\bar{X}] &= \frac{1}{n}\sum_{i=1}^n E[X_i] \\
           &= \frac{1}{n}\sum_{i=1}^n \mu \\
           &= \frac{n\mu}{n} = \mu.
\end{aligned}
$$

- $V[\bar{X}]$ の計算をする. まず次のように式を変形できることに注意する.

$$
\bar{X} - \mu = \frac{1}{n}\left(\sum_{i=1}^n X_i \right) - \mu = \frac{1}{n}\sum_{i=1}^n\left(X_i - \mu\right) \label{sumandbar}
$$

このとき

$$
\begin{aligned}
V[\bar{X}] &= E[(\bar{X} - \mu)^2] \\
           &= \frac{1}{n^2} E\left[
              \left(\sum_{i=1}^n (X_i - \mu)\right)
              \left(\sum_{j=1}^n (X_j - \mu)\right)
              \right] \\
           &= \frac{1}{n^2} \sum_{i=1}^n
              E\left[(X_i - \mu)^2 \right]
              + \frac{2}{n^2} \sum_{i < j }
              E\left[
                     (X_i - \mu)(X_j - \mu)
              \right] \\
           & \underset{\star}{=} \frac{1}{n^2} \sum_{i=1}^n \sigma^2 +
               \frac{2}{n^2} \sum_{ i< j } \underbrace{E[(X_i-\mu)]}_{=0}\underbrace{E[(X_j-\mu)]}_{=0} \\
           & = \frac{n\sigma^2}{n^2} \\
           & = \frac{\sigma^2}{n}.
\end{aligned}
$$

ただし $\underset{\star}{=}$ の式変形で確率変数が互いに独立であることを用いている．
}

\prop{}{}{
  - 平均が $\mu$, 分散が $\sigma^2$ である分布から独立に抽出したサンプルの $\{X_i\}_{i=1}^n$ から定まる標本分散の平均 $E[S^2]$ は次で与えられる:

  $$
  E[S^2] = \frac{n-1}{n}\sigma^2
  $$
}
\proof{
まず, $S^2$ の定義式を変形する.
$$
\begin{aligned}
S^2 &= \frac{1}{n}\sum_{i=1}^n (X_i - \bar{X})^2 \\
    &= \frac{1}{n}\sum_{i=1}^n ((X_i-\mu) - (\bar{X}- \mu))^2 \\
    &\underset{\star}{=} \frac{1}{n}\sum_{i=1}^n (X_i - \mu)^2 +
       \frac{1}{n}\sum_{i=1}^n (\bar{X}-\mu)^2 -
       \frac{2}{n}\sum_{i=1}^n (X_i-\mu)(\bar{X} - \mu) \\
    &= \frac{1}{n}\sum_{i=1}^n (X_i-\mu)^2 - (\bar{X} - \mu)^2.
\end{aligned}
$$

ただし $\underset{\star}{=}$ の計算では \eqref{sumandbar} を用いている. 以上の式変形と \ref{samplemeanvar} の結果を使うことで

$$
\begin{aligned}
E[S^2] &= E\left[\frac{1}{n}\sum_{i=1}^n(X_i-\mu)^2\right] - E\left[(\bar{X}-\mu)^2\right] \\
       &= \frac{n\sigma^2}{n} - \frac{\sigma^2}{n} \\
       &= \frac{n-1}{n}\sigma^2
\end{aligned}
$$

となる．以上で示したいことが示された.

}

\chapter{Central Limit Theorem}

\theorem{clt}{CLT}{
Mathematically, if $X_{1},X_{2},\dots,X_{n}$
is a random sample of size $n$ taken from a population with mean $\mu$
and finite variance $\sigma ^{2}$ and
if $\bar{X}$ is the sample mean,
the limiting form of the distribution of
$$
Z=\left({\frac{\bar{X}-\mu }{\sigma /\surd n}}\right)
$$
is the standard normal distribution.
}


\example{}{Throwing Dices}{
```julia:dice
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
```
\output{dice}
}

\fig{dice}
