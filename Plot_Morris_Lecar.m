function Plot_Morris_Lecar (simulazione, id) 
layer = 15;
row = 1;
figure;
%Plotta il grafico della Tensione di un dato Neurone (identificato da 
%layer, row, column) in una determinata simulazione.
%#t	layer	Row	Column	V	U	NSpikes	I	IOut	SimNumber	IDFather	IDTarget
data = importdata(['../Dati/NeuronMorrisLecar', num2str(simulazione), '-0.txt']);
matrice = data.data; %Questa matrice ha size(matrice, 1) righe, e 12 colonne.
clear data;

t = [];
v = [];
c = [];
i = 1;
for k = 1:size(matrice, 1)
    if (matrice(k, 2) == layer && matrice(k, 3) == row && matrice(k, 4) == id)
        t(i) = matrice(k, 1);
        v(i) = matrice(k , 5);
        c(i) = matrice(k, 13);
        i = i +1;
    end
end

plot(t, v);
hold on;
plot(t, c, "r");
ylim([-120, 35]);
%xlabel('Steps');
%ylabel('Tensione');
stringa = sprintf("Morris Lecar %d", id);
title(stringa);




