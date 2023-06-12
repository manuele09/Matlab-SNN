function Plot_Single_Neuron (simulazione, layer, row, column, norm) 
loadedConfig = load('config.mat');
config = loadedConfig.configs;
if ~exist('norm','var')
     % third parameter does not exist, so default it to something
      norm = 0;
 end
%Plotta il grafico della Tensione di un dato Neurone (identificato da 
%layer, row, column) in una determinata simulazione.
%#t	layer	Row	Column	V	U	NSpikes	I	IOut	SimNumber	IDFather	IDTarget
data = importdata(['../Dati/Neurons', num2str(simulazione), '.txt']);
matrice = data.data; %Questa matrice ha size(matrice, 1) righe, e 12 colonne.
clear data;

t = [];
v = [];
curr = [];
i = 1;
niente = 1;
for k = 1:size(matrice, 1)
    if (matrice(k, 2) == layer && matrice(k, 3) == row && matrice(k, 4) == column)
        target = matrice(k, 12);
        father = matrice(k, 11);
        id = matrice(k, 4);
        t(i) = matrice(k, 1);
        v(i) = matrice(k , 5);
        curr(i) = matrice(k , 8);
        
        i = i +1;
        niente = 0;
    end
end
if (niente == 1)
    disp("Non c'è nessun neurone con quelle specifiche: "+ layer + ", " + row + ", " + column);
else
    %figure();
    if (norm == 0)
        
        plot(t, v, "LineWidth", config.line_width);
        yticks([-130, -50, 0]);
        ylim([-130, 50]);
        ax = gca;
        ax.FontSize = config.axis_font_size; 
        %title(titolo);
    else
         plot(t, v/40);
    end
    %plot(t, curr);
    if target ~= -1
        titolo = sprintf("Id %d, Target %d, father %d", id, target, father);
        title(titolo);
    end
end

% lista = [];
% contatore = 1;
% ring = 2;
% for k = 1:size(matrice, 1)
%     if (matrice(k, 2) == 16 && matrice(k, 3) == ring)
%         if not(ismember(matrice(k, 4) , lista))
%             lista(contatore) = matrice(k, 4);
%             contatore = contatore + 1;
%         end
%     end
% end
% disp(lista);

%primo anello: 0, 3, 14
%secondo anello: 1, 4, 5, 6, 15, 16, 17, 18, 19
%terzo anello: 2, 7, 8, 9, 10, 11, 12, 13, 20, 21, 22, 23, 24, 25, 26, 27, 28
% 29, 30, 31, 32, 33, 34, 35, 36, 37, 38

