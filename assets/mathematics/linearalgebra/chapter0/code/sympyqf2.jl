# This file was generated, do not modify it. # hide
using SymPy

@vars x1 x2 real=true
@vars a11 a12 real=true
@vars a21 a22 real=true

a21 = a12
A = [
a11 a12
a21 a22
]

x=[
  x1
  x2
]
MyUtils.fdsympy(x'A*x |> expand)