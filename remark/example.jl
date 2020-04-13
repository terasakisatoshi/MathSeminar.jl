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

# you can make matrix like

# ```math
# R(\theta)=\begin{bmatrix}
# \cos\theta & -\sin\theta \\\\
# \sin\theta & \cos\theta
# \end{bmatrix}
# ```

# ---

# # Plots PyPlot backend

## 描画バックエンドを PyPlot に切り替えるよ
using Plots
pyplot()
x = -π:0.01:π
plot(x, sin.(x))

# ---

# # Plot GR backend

using Plots
gr()
x = -π:0.01:π
p1 = plot(x, cos.(x))
p2 = plot(x, sin.(x))
plot(p1, p2, layout=(2,1))
savefig("saved.png") #hide

# ![not found](saved.png)

# ---

# # You can display image

using Images 

colorview(RGB, rand(3,100,100))


# ---

using TestImages

testimage("camera")

# # Thank you
