using Plots

X = collect(1:400)
# N = vcat(zeros(100).+1, zeros(100).+7, zeros(100).+5, zeros(100).+2);
# N = sin.(X)./X;
N = X.^2/10000;
N[200:400] .= 2
N[1:15] .= -1
N[100:200] .= -1
K = [1,2,3,4,5];
K = ChronologicalCluster.solve(N, K)

plot(X,N)

plot(X[1:K[1]],N[1:K[1]])
for i in 1:length(K)-1
    plot!(X[K[i]+1:K[i+1]],N[K[i]+1:K[i+1]])
end
plot!(X[K[length(K)]+1:end],N[K[length(K)]+1:end])