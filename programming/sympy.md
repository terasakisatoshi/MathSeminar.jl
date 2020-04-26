@def title = "SymPy.jl Tutorial"
@def reeval = true

\chapter{SymPy.jl for Franklin users}

\section{Load some packages}

```julia:load
using SymPy
```

\section{Define helper function}

```julia:definefdsympy
using SymPy
using SymPy: SymbolicObject

function fdsympy(x::T, xx::T...; mode="equation*", itex=true) where T<:SymbolicObject
    buf = IOBuffer()
    print(buf, SymPy.sympy.latex(x, mode=mode,itex=itex))
    for a in xx
        print(buf, SymPy.sympy.latex(a, mode=mode,itex=itex))
    end
    print(buf |> take! |> String)
end

function fdsympy(x::AbstractArray{T}; mode="equation*", itex=true) where T<:SymbolicObject
    SymPy.sympy.latex(x, mode=mode,itex=itex) |> print
end

```

\chapter{Sample code}

\example{sample}{
```julia:example1
@vars x y z

fdsympy((x+y+z)^2 |> expand)
fdsympy(y)
```

\textoutput{example1}

```julia:example2
@vars x y z

fdsympy(x, y)
```

\textoutput{example2}


```julia:example3
@vars x y
fdsympy([x, y])
```

\textoutput{example3}

```julia:example4
@vars x y z

fdsympy([x y])
```

\textoutput{example4}


}


\example{Solve ODE}{

This example is taken from [sympy documentation](https://docs.sympy.org/latest/tutorial/intro.html#the-power-of-symbolic-computation)

```julia:solveode
using SymPy
@vars t y
y = Function(y)
sol = dsolve(Eq(y(t).diff(t,t) - y(t), exp(t)), y(t))
fdsympy(sol)
```

\textoutput{solveode}
}

\example{Rotations: Euler angles}{
```julia:matrix
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
```

\textoutput{matrix}
}
