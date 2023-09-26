function PlottaZFixedW (indice, indInternal) 

if nargin>1
   data = importdata(['Dati\Z_pesi_fissi', num2str(indice),'-',num2str(indInternal),'.txt']);
else
    data = importdata(['Dati\Z_pesi_fissi', num2str(indice),'.txt']);
end

figure
plot(data)
 xlabel('step','fontsize',16)
 ylabel('membrane potential [mV]','fontsize',16)
 set(gca,'FontSize',16)
title('Sum-Neuron')
end