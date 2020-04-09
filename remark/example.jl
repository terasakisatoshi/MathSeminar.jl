#jl # example.jl
#jl # using Remark; Remark.slideshow("example.jl", "pres", ) |> Remark.open

# # Hello World
# ## Introduction to Julia

# ---

# # Some equations
# Here is an inline fraction: $\frac{1}{2}$
# 
# And some identities in display mode:
# 
# $$e^{i\pi} + 1 = 0$$
# 
# $$\sum_{n=0}^\infty \alpha^n = \frac{1}{1-\alpha}$$


# ```math
# \begin{bmatrix}
# \cos\theta & -\sin\theta \\\\
# \sin\theta & \cos\theta
# \end{bmatrix}
# ```


# ---
# # Plots GR backend

using Plots #src
plot(cos) #src
using Plots
plot(sin)

# ---

# # Plots PyPlot backend
## 描画バックエンドを PyPlot に切り替えるよ

pyplot()
plot(sin)

# ---

# # Images の場合

using Images 

colorview(RGB, rand(3,100,100))

# ---



# ---

# # Thank you
