# This file was generated, do not modify it. # hide
Rx(θ) = [
    1.   0.        0
    0.  cos(θ) -sin(θ)
    0.  sin(θ)  cos(θ)
]

Ry(θ) = [
    cos(θ)  0. sin(θ)
     0.     1.   0.
    -sin(θ) 0. cos(θ)
]

Rz(θ) = [
    cos(θ) -sin(θ) 0
    sin(θ) cos(θ)  0
    0.          0. 1
]

@vars φ θ ψ

R = Rz(φ) * Ry(θ) * Rz(ψ)
fdsympy(R)