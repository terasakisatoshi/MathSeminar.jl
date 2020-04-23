@def title = "How fast is Julia language?"
@def hasmath = true
@def hascode = true
@def hasplotly = true

\chapter{Is Julia fast ?}

- Julia は LLVM による JIT コンパイルにより高速に動作し C 言語と同等のスピードを出すことができます。ここではベンチマークとしてマンデルブロ集合の生成する計算を例にJulia がどれくらいのパフォーマンスを出すのかを調べてみましょう。
\section{C のコードを書く}

- C のコードを書いてみました.

\Cexec{mandC}{
#include <stdio.h>
#include <stdint.h>
#include <time.h>

uint8_t cnt(double ReZ,double ImZ,double ReC,double ImC){
    uint8_t k=0;
    while(k < 255){
        double new_ReZ = ReZ * ReZ - ImZ * ImZ + ReC ;
        double new_ImZ = 2 * ReZ * ImZ + ImC;
        if (new_ReZ * new_ReZ+new_ImZ * new_ImZ>4){
            return k;
        }
        ReZ = new_ReZ;
        ImZ = new_ImZ;
        k+=1;
    }
    return k;
}


int main()
{
    clock_t start,end;
    start = clock();
    int M = 1250;
    int N = 1250;
    uint8_t grid[M][N];
    double init_Re = 0.0;
    double init_Im = 0.0;
    for (int j = 0; j < M; j++)
    {
        for (int i = 0; i < N; i++)
        {
            double ReC = 4.0 / (N - 1) * i - 2.0;
            double ImC = 4.0 / (M - 1) * j - 2.0;
            double ReZ = init_Re;
            double ImZ = init_Im;
            grid[j][i] = cnt(ReZ,ImZ,ReC,ImC);
        }
    }
    end = clock();
    double cpu_time_used = ((double) (end - start)) / CLOCKS_PER_SEC;
    printf("Elapsed time %f [sec]\n", cpu_time_used);
    FILE *fp;
    fp = fopen("/tmp/benchC.txt", "w");
    for (int j = 0; j < M; j++)
    {
        for (int i = 0; i < N; i++)
        {
            fprintf(fp, "%d", grid[j][i]);
            if (i != N - 1)
            {
                fprintf(fp, ",");
            }
            else
            {
                fprintf(fp, "\n");
            }
        }
    }
    fclose(fp);
    return 0;
}
}


描画は下記のとおりです。


```julia:plotmandC
using DelimitedFiles
using Plots
img = readdlm("/tmp/benchC.txt",',',Int)
M,N = img |> size
p=heatmap(1:N, 1:M, img, aspect_ratio=1, size=(400,400))
savefig(p, joinpath(@OUTPUT, "mandC.png")) #hide
```

\fig{mandC.png}

\section{Julia のコード}

最後に Julia のコードを見ていきましょう

```julia:mandJ
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
    rm("/tmp/benchJ.txt")
    writedlm("/tmp/benchJ.txt",grid,",")
end

main()

using BenchmarkTools
@btime mand(1250, 1250);
```

\output{mandJ}

```julia:plotmandJ
Refpath="/tmp/benchC.txt"
Tarpath="/tmp/benchJ.txt"
run(`bash -c "cmp --silent $Refpath $Tarpath || echo \"files are different\""`)

using Plots
using DelimitedFiles
img = readdlm(Tarpath,',',Int)
M,N = img |> size
p = heatmap(1:N,1:M,img,aspect_ratio=1, size=(400, 400))
savefig(p, joinpath(@OUTPUT, "mandJ.png")) #hide
```

\output{plotmandJ}

\fig{mandJ.png}
