function MeanError () 

targetMean=[];

for k=0:125
% ', num2str(indice), '
target = importdata(['Dati/target0-', num2str(k),'.txt']);


targetError = target (:,2);

targetMean(k+1)= mean(abs(targetError));

end

figure
plot(targetMean)
set(gca,'FontSize',16)
xlabel('Iteration number','fontsize',16)
ylabel('mean Error','fontsize',16)