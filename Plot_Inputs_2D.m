function Plot_Inputs_2D (first, last) 
for simulazione = first:last
data = importdata(['../Dati/Neurons', num2str(simulazione), '.txt']);
matrice = data.data; %Questa matrice ha size(matrice, 1) righe, e 12 colonne.

spikes = zeros(5, 5); %array con 4 valori
t = [];
sample_step = 1199;
window = 100;
start_step = sample_step-window;

condizione = matrice(:, 2) == 1; %estrae gli indici delle righe che appartengo al primo layer
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