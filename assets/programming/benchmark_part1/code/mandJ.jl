# This file was generated, do not modify it. # hide
using DelimitedFiles

function cnt(ReZ, ImZ, ReC, ImC)
    k::UInt8 = 0
    while (k < 255)
        new_ReZ = ReZ * ReZ - ImZ * ImZ + ReC
        new_ImZ = 2 * ReZ * ImZ + ImC
        if new_ReZ * new_ReZ + new_ImZ * new_ImZ > 4.
            return k
        end
        ReZ = new_ReZ
        ImZ = new_ImZ
        k += 1
    end
    return k
end

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

function mand(M::Int, N::Int)
    grid = Array{UInt8}(undef, M, N)
    init_Re = 0.0
    init_Im = 0.0
    for j = 1:M
        for i = 1:N
            ReC = 4.0 / (N - 1) * (i - 1) - 2.0
            ImC = 4.0 / (M - 1) * (j - 1) - 2.0
            ReZ = init_Re
            ImZ = init_Im
            grid[j, i] = cnt(ReZ, ImZ, ReC, ImC)
        end
    end
    return grid
end

function main()
    s = time()
    M = N = 1250
    grid = mand(M,N)
    t = time()
    @show(t - s)
    writedlm("/tmp/benchJ.txt",grid,",")
end

main()

using BenchmarkTools
@btime mand(1250, 1250);