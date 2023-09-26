%non c'è nessun file "Avalue-I.txt"
dati = importdata(['Avalue-I.txt']);
matrici = dati.data;
clear dati;

% for k = 1:size(matrici, 1)
%     riga = matrici(k,:);
%     if riga(1) ~= timestamp
%         timestamp = riga(1);
%     end
%     if riga(2) == 2
%         i = riga(3);
%         j = riga(4);
%         v = riga(5);
%         u = riga(6);
%         corr = riga(8);
%         spk = riga(7);
%     end
