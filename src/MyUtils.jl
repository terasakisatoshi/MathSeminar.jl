module MyUtils

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

end # module