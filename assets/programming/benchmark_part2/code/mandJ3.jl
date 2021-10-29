# This file was generated, do not modify it. # hide
#=
set environment variable `JULIA_NUM_THREADS=8` before julia begins
=#
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
    Base.Threads.@threads for i in 1:N
        for j in 1:M
            grid[j, i] = cnt(init_z,complex(xs[i], ys[j]))
        end
    end
    return grid
end

function main()
    s = time()
    M = N = 5000
    grid = mand(M, N)
    t = time()
    @show(t - s)
    writedlm("/tmp/resultJ3.txt",grid,",")
end

main()

using BenchmarkTools
@btime mand(5000, 5000);