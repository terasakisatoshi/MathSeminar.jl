# This file was generated, do not modify it. # hide
using DelimitedFiles

function cnt(z,c)
    k::UInt8 = 0
    while (k < 255)
        z = z^2 + c
        if abs2(z)>4.
            return k
        end
        k += 1
    end
    return k
end

function mand(M, N)
    grid = Array{UInt8}(undef, M, N)
    init_z = complex(0.0, 0.0)
    xs = range(-2,2,length=N)
    ys = range(-2,2,length=M)
    grid = cnt.(init_z,complex.(xs',ys))
    return grid
end

function main()
    s = time()
    M = N = 5000
    grid = mand(M, N)
    t = time()
    @show(t - s)
    writedlm("/tmp/resultJ2.txt",grid,",")
end

main()

using BenchmarkTools
@btime mand(5000, 5000);