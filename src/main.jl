function cost(N::Vector, k::Int) # norm l2
    N1 = N[1:k]
    N2 = N[k+1:end]
    M1 = sum(N1)/(k)
    M2 = sum(N2)/(length(N)-k)
    score = (sum(abs.(N1.-M1))+sum(abs.(N2.-M2)))/length(N)
    return score
end

function search(N::Vector) #grid search
    old_score = Inf
    idx = 0
    for k in 1:length(N)-1
        score = cost(N, k)
        if score >= old_score 
            nothing
        else
            old_score = score
            idx = k
        end
    end
    return idx 
end

function heuristic(N::Vector, K::Vector) # nao espera a iteração acabar para usar valores novos
    K_new = copy(K)
    for i in 1:length(K)
        i1 = (i == 1 ? 1 : K_new[i-1])
        i2 = (i == length(K) ? length(N) : K_new[i+1])

        K_new[i] = search(N[i1:i2]) + i1
    end
    return K_new
end

function solve(N::Vector, K::Vector)
    K_old = nothing
    plts = []
    plt = my_plot(N,K)
    push!(plts, plt)
    while K_old != K
        K_old, K = K, heuristic(N, K)
        plt = my_plot(N,K)
        push!(plts, plt)
    end
    return K, plts
end

function my_plot(N::Vector, K::Vector)
    X = collect(1:length(N))

    plt = plot(X[1:K[1]],N[1:K[1]])
    for i in 1:length(K)-1
        plot!(plt, X[K[i]+1:K[i+1]],N[K[i]+1:K[i+1]])
    end
    plot!(plt, X[K[length(K)]+1:end],N[K[length(K)]+1:end])
    
    return plt
end