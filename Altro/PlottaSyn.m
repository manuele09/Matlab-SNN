function [w5, w7] = PlottaSyn(indice)
%', num2str(indice), '
    dati = importdata(['Dati/Synapse2.txt']);
    matrici = dati.data;
    clear dati;
    
    w5 = 0; 
    imat5out = [];
    w7 = [];
    imat7out = [];
    
    timestamp = -1;

    for k = 1:size(matrici, 1)
        riga = matrici(k,:);
        if riga(1) ~= timestamp
            timestamp = riga(1);
        end
        % Sameness
        if riga(2) == 5
            w = riga(8);
            corr = riga(9);
            w5 = w; 
            imat5out(timestamp+1) = corr; %#ok
        % "Fake" SOSL
        elseif riga(2) == 7
            i = riga(3);
            j = riga(4);
            w = riga(8);
            corr = riga(9);
            w7(i+1,j+1) = w; %#ok
            imat7out((i+1)*10 + j+1, timestamp+1) = corr; %#ok
        end
    end
    clear matrici
    save SLN_SYN
end