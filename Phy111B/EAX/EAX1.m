N = [5,10,50,100,1000];
final = [];
for i=1:length(N)
    a = randn(N(i),1000); m = mean(a); s = std(a); se = std(a)/sqrt(N(i)); 
    figure; subplot(3,1,1); hist(m,30); title(sprintf('Histogram N = %d',N(i))); xlabel('Mean'); ylabel('Count'); 
    subplot(3,1,2); hist(s,30); xlabel('Standard Deviation'); ylabel('Count'); 
    subplot(3,1,3); hist(se,30); xlabel('Error on the Mean'); ylabel('Count');
    c1 = sum( std(m) > abs(m))/1000 *100;
    c2 = sum( 2*std(m) > abs(m))/1000*100;
    final = [final,[N(i) 0 1 1/sqrt(N(i)) m(1) s(1) se(1) .6826*100. .9544*100. c1 c2]']
end
