# # Hello World

# ## Introduction to Julia presentation tool

# ---

# # How do I create this slideshow ?

# 1. create document of Literate.jl format, say `example.jl`
# 1. just run the following julia script

# ```julia
# using Remark
# s=Remark.slideshow("example.jl", "pres", )
# Remark.open(s)
# ```

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

# # Plots PyPlot backend
## 描画バックエンドを PyPlot に切り替えるよ

using Plots
pyplot()
plot(sin)

# ---

# # Plot GR backend

# `<?xml version="1.0" encoding="utf-8"?>` occurs if we use `gr` backend why ???

using Plots
gr()
p1 = plot(cos)
p2 = plot(sin)
plot(p1, p2, layout=(2,1))

# ---

# # You can display image

using Images 

colorview(RGB, rand(3,100,100))


# ---

# # Thank you
