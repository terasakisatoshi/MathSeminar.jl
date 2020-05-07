# This file was generated, do not modify it. # hide
function T(n, z) 
    if z > 0
        a = z^(n/2 - 1)*exp(-z/2)
        b = 2^(n/2) * Γ(n/2)
        return a/b
    else
        return 0.
    end
end;