function Plot_Single_STDP (simulazione, l_s, r_s, c_s, l_d, r_d, c_d) 

%Plot_Single_STDP(7, 16, 0, 3, 16, 3, 0)
%tra neurone C primo ring e corrispettivo end neuron

%Plot_Single_STDP(8, 16, 2, 13, 16, 3, 2)
%tra neurone C primo ring e corrispettivo end neuron

%#t	StLayer	StRow	StCol	DstLayer	DstRow	DstCol	W	I	SimNumber
%    14	      4	      1     	15	      0 	  1
data = importdata(['../Dati/SynapseSTDP', num2str(simulazione), '.txt']);
matrice = data.data; %Questa matrice ha size(matrice, 1) righe, e 12 colonne.
t = [];
w = [];
i = 1;
niente = 1;
for k = 1:size(matrice, 1)
    if (matrice(k, 2) == l_s && matrice(k, 5) == l_d && matrice(k, 3) == r_s && matrice(k, 4) == c_s && matrice(k, 6) == r_d && matrice(k, 7) == c_d)
        t(i) = matrice(k, 1);
        w(i) = matrice(k , 8);
        i = i +1;
        niente = 0;
    end
end
if (niente == 1)
    disp("Non c'è nessun neurone con quelle specifiche");
else
    figure();
    plot(t, w);
    ylim([-0.8, 0.8]);
    %xlim([0, 1200]);
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

