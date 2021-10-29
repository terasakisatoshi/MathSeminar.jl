# This file was generated, do not modify it. # hide
using SymPy

@vars x1 x2 x3 real=true
@vars a11 a12 a13 real=true
@vars a21 a22 a23 real=true
@vars a31 a32 a33 real=true

a21 = a12
a31 = a13
a32 = a23

A = [
a11 a12 a13
a21 a22 a23
a31 a32 a33
]

x=[
  x1
  x2
  x3
]
MyUtils.fdsympy(x'A*x |> expand)