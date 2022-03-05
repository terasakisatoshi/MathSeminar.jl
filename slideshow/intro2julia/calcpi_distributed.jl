using Distributed

addprocs()

function calcπ(N)
    cnt = @distributed (+) for a = 1:N
        s = 0
        for b = 1:N
            s += ifelse(gcd(a, b) == 1, 1, 0)
        end
        s
    end
    prob = cnt / N / N
    √(6 / prob)
end

@time calcπ(10^4)
@time calcπ(5*10^4)