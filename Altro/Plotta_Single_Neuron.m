%Plotta il grafico della Tensione di un dato Neurone (identificato da 
%layer, row, column) in una determinata simulazione.
%#t	layer	Row	Column	V	U	NSpikes	I	IOut	SimNumber	IDFather	IDTarget
simulazione = 0;
layer = 1;
row = 0;
column = 0;
data = importdata(['Dati/Neurons', num2str(simulazione), '.txt']);
matrice = data.data; %Questa matrice ha size(matrice, 1) righe, e 12 colonne.

t = [];
v = [];
i = 1;
for k = 1:size(matrice, 1)
    if (matrice(k, 2) == layer && matrice(k, 3) == row && matrice(k, 4) == column)
        t(i) = matrice(k, 1);
        v(i) = matrice(k , 5);
        i = i +1;
    end
end

%figure(1);

subplot(2, 2, 1);
plot(t, v);
xlabel('Steps');
ylabel('Tensione');
title('Neurone');

subplot(2, 2, 2);
plot(t, v);
xlabel('Steps');
ylabel('Tensione');
title('Neurone');



%surf(t, v);


