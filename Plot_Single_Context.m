function Plot_Single_Context (simulazione, ring, target, id_father) 

if ~exist('id_father','var')
     % third parameter does not exist, so default it to something
      id_father = -1;
 end
%Plotta il grafico della Tensione di un dato Neurone (identificato da 
%layer, row, column) in una determinata simulazione.
%#t	layer	Row	Column	V	U	NSpikes	I	IOut	SimNumber	IDFather	IDTarget
data = importdata(['../Dati/Neurons', num2str(simulazione), '.txt']);
matrice = data.data; %Questa matrice ha size(matrice, 1) righe, e 12 colonne.
t = [];
v = [];
curr = [];
i = 1;
niente = 1;
for k = 1:size(matrice, 1)
    if (matrice(k, 2) == 16 && matrice(k, 3) == ring && matrice(k, 12) == target)
       % if (id_father == -1 || id_father == matrice(k, 11))
        t(i) = matrice(k, 1);
        v(i) = matrice(k , 5);
        curr(i) = matrice(k , 8);

        i = i +1;
        niente = 0;
       % end
    end
end
if (niente == 1)
    disp("Non c'è nessun neurone con quelle specifiche: "+ 16 + ", " + ring + ", " + target);
else
    %figure();
    plot(t, v);
    %plot(t, curr);
    if target ~= -1
        titolo = sprintf("Target %d, ring %d", target, ring);
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

