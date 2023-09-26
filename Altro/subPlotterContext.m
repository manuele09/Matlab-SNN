function subPlotterContext(indice)
%%PARAMETRI:
%%indice-> vettore contenente gli indici delle img da mettere nel subplot

% for i=1:numel(indice)                             % se si vogliono fare runtime anche le immagini del contesto
%     ContexMapEvo(indice(i),indiceInt(i));
% end

close all;
f = figure(1);  %create new figure  (mi serve per riservare il numero 1 alla figure in modo tale da evitare errori successivi)
suptitle('Sequence of the Context Maps during different epochs');
numcolonne=2;   %parametro scelto da noi
numrighe=ceil(numel(indice)/numcolonne);

for i=1:numel(indice)
hi = openfig(['Context_Map_sim',num2str(indice(i)),'.fig'],'reuse'); % open figure
axi = gca; % get handle to axes of figure
f = figure(1); 
s = subplot(numrighe,numcolonne,i); %create and get handle to the subplot axes
xlabel(['epochs ',num2str(indice(i))],'FontSize',14);
figi = get(axi,'children'); %get handle to all the children in the figure
copyobj(figi,s); %copy children to new parent axes i.e. the subplot axes
colorbar;
end


end