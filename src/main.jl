function cost(N::Vector, k::Int)
    N1 = N[1:k]
    N2 = N[k+1:end]
    M1 = sum(N1)/(k)
    M2 = sum(N2)/(length(N)-k)
    score = (sum(abs.(N1.-M1))+sum(abs.(N2.-M2)))/length(N)
    return score
end

function search(N::Vector)
    old_score = Inf
    idx = 0
    for k in 1:length(N)-1
        score = cost(N, k)
        if score >= old_score 
            return idx
        else
            old_score = score
            idx = k
        end
    end
    return idx 
end

function simple_fix(K::Vector)
    for i in 1:length(K)-1
        if K[i] == K[i+1]
            K[i+1] += 1
        end
    end
    return K
end

function heuristic(N::Vector, K::Vector)
    K_new = copy(K)
    for i in 1:length(K)
        if i==1
            i1 = 1
            i2 = K[i+1]
        elseif i != length(K)
            i1 = K[i-1] + 1
            i2 = K[i+1]
        else
            i1 = K[i-1] + 1
            i2 = length(N)
        end
        K_new[i] = search(N[i1:i2]) + i1
    end
    return simple_fix(K_new)
end

function solve(N::Vector, K::Vector)
    K_old = nothing
    while K_old != K
        K_old, K = K, heuristic(N, K)
    end
    return K
end