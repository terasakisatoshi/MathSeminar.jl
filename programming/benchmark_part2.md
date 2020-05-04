@def title = "Implement more Julian"
@def hasmath = true
@def hascode = true

\chapter{パフォーマンスを維持したままJuliaらしく}

```julia:mandJ0
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

function mand(M,N)
    grid = Array{UInt8}(undef, M, N)
    init_Re = 0.0
    init_Im = 0.0
    for j = 1:N
        for i = 1:M
            ReC = 4.0 / (M - 1) * (j - 1) - 2.0
            ImC = 4.0 / (N - 1) * (i - 1) - 2.0
            ReZ = init_Re
            ImZ = init_Im
            grid[i, j] = cnt(ReZ, ImZ, ReC, ImC)
        end
    end
    return grid
end

function main()
    s = time()
    M = N = 5000
    grid = mand(M,N)
    t = time()
    @show(t - s)
    writedlm("/tmp/resultJ.txt",grid,",")
end

main()

using BenchmarkTools
@btime mand(5000, 5000);
```

\output{mandJ0}

\remark{}{数値誤差について}{
点の位置をあらわす `(4.0 / (M - 1) * (j - 1) - 2.0)` は `range(-2, 2, length(N))` と数学的に等価ですが，数値の誤差の関係で結果が若干異なることがあります．
}

```julia:comprehension
N=10; @show [4.0*(i-1)/(N-1) - 2.0 for i in 1:N]
```

\output{comprehension}

```julia:rangeresult
N=10; @show collect(range(-2,2,length=N))
```

\output{rangeresult}



```julia:plotmandJ
Tarpath="/tmp/resultJ.txt"
using Plots
using DelimitedFiles
img = readdlm(Tarpath,',',Int)
M,N = img |> size
p = heatmap(1:N,1:M,img,aspect_ratio=1, size=(400, 400))
savefig(p, joinpath(@OUTPUT, "mandJ.png")) #hide
```

\fig{mandJ}

```julia:mandJ1
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
    for (i,x) in enumerate(xs)
        for (j,y) in enumerate(ys)
            grid[j, i] = cnt(init_z,complex(x, y))
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
    writedlm("/tmp/resultJ1.txt",grid,",")
end

main()

using BenchmarkTools
@btime mand(5000, 5000);
```

\output{mandJ1}

```julia:plotmandJ1
Refpath="/tmp/resultJ.txt"
Tarpath="/tmp/resultJ1.txt"
run(`bash -c "cmp --silent $Refpath $Tarpath || echo \"files are different\""`)

using Plots
using DelimitedFiles
img = readdlm(Tarpath,',',Int)
M,N = img |> size
p = heatmap(1:N,1:M,img,aspect_ratio=1, size=(400, 400))
savefig(p, joinpath(@OUTPUT, "mandJ1.png")) #hide
```

\output{plotmandJ1}

\fig{mandJ1}

```julia:mandJ2
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
```

\output{mandJ2}

```julia:plotmandJ2
Refpath="/tmp/resultJ1.txt"
Tarpath="/tmp/resultJ2.txt"
run(`bash -c "cmp --silent $Refpath $Tarpath || echo \"files are different\""`)

using Plots
using DelimitedFiles
img = readdlm(Tarpath,',',Int)
M,N = img |> size
p = heatmap(1:N,1:M,img,aspect_ratio=1, size=(400, 400))
savefig(p, joinpath(@OUTPUT, "mandJ2.png")) #hide
```

\output{plotmandJ2}

\fig{mandJ2}

```julia:mandJ3
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
```

\output{mandJ3}

```julia:plotmandJ3
Refpath="/tmp/resultJ1.txt"
Tarpath="/tmp/resultJ3.txt"
run(`bash -c "cmp --silent $Refpath $Tarpath || echo \"files are different\""`)

using Plots

using DelimitedFiles
img = readdlm(Tarpath, ',', Int)
M,N = img |> size
p = heatmap(1:N, 1:M, img,aspect_ratio=1, size=(400, 400))
savefig(p, joinpath(@OUTPUT, "mandJ3.png"))
```

\output{plotmandJ3}

\fig{mandJ3}
