using Plots

X = collect(1:400)
# N = vcat(zeros(100).+1, zeros(100).+7, zeros(100).+5, zeros(100).+2);
N = X.^8;
K = [1,2,3];
K = ChronologicalCluster.solve(N, K)

plot(scatter(X,N))

plot(X[1:K[1]],N[1:K[1]])
plot!(X[K[1]+1:K[2]],N[K[1]+1:K[2]])
plot!(X[K[2]+1:K[3]],N[K[2]+1:K[3]])
plot!(X[K[3]+1:end],N[K[3]+1:end])