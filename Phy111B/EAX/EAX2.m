prob = ['b','c','d']
N = [100,1000,10000]
final = [];
for i=1:length(N)
    dist = exprnd(1,N(i),1000);
    m = mean(dist); figure; hist(m); 
    title(sprintf('Distributions of Means, M = 1000, N = %d, for Random Exponential Distributed Samples',N(i))); 
    xlabel('Means'); ylabel('Count');
    final = [final,[N(i) 1 1 1/sqrt(N(i)) 1/sqrt(N(i)) m(1) std(dist(:,1)) std(m)]']
    savefig(sprintf('4%s',prob(i)))
end