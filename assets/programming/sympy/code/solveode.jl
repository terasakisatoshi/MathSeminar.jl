# This file was generated, do not modify it. # hide
using SymPy
@vars t y
y = Function(y)
sol = dsolve(Eq(y(t).diff(t,t) - y(t), exp(t)), y(t))
fdsympy(sol)