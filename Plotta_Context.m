%Versione fatta da me per un context a forma di rettangolo
%Incompleta
for simulazione = 0:9
data = importdata(['../Dati/Neurons', num2str(simulazione), '.txt']);
matrice = data.data; %Questa matrice ha size(matrice, 1) righe, e 12 colonne.

spikes = zeros(5, 5); %array con 4 valori
t = [];
sample_step = 1199;
window = 100;
start_step = sample_step-window;

condizione = matrice(:, 2) == 16; %estrae gli indici delle righe che appartengo al context layer
input_layer = matrice(condizione, :);

for k = 1:size(input_layer, 1)
    if (input_layer(k, 1) >= start_step)
        spikes(input_layer(k, 3)+1, input_layer(k, 4)+1) = spikes(input_layer(k, 3)+1, input_layer(k, 3)+1) + input_layer(k, 7);
    end
end

spikes = spikes / window;
%figure(1);

subplot(4, 3, simulazione+1);
surf(spikes);
view(2);
ylabel("Feature");
xlabel("Valore");
titolo = sprintf("Input %d", simulazione);
title(titolo);
colorbar;

end