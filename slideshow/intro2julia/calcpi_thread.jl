using Base.Threads

function calcπ(N)
    cnt = Atomic{Int}(0)
    Threads.@threads for a = 1:N
        for b = 1:N
            Threads.atomic_add!(cnt, ifelse(gcd(a, b) == 1, 1, 0))
        end
    end
    prob = cnt.value / N / N
    # 実は return は不要. 最後に評価した式の値を返す.
    √(6 / prob) # √ は \sqrt + <tab>
end

@time @show calcπ(10^4)
@time @show calcπ(5*10^4)
