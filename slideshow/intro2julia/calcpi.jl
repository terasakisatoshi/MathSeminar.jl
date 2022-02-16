function calcπ(N)
    cnt = 0
    for a = 1:N, b = 1:N
        cnt += ifelse(gcd(a, b) == 1, 1, 0)
    end
    prob = cnt / N / N
    # 実は return は不要. 最後に評価した式の値を返す.
    √(6 / prob) # √ は \sqrt + <tab>
end

@time calcπ(10^4)
