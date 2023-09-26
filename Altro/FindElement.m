function [ elements ] = FindElement( matrix, ind1, char1, ind2, char2, ind3, char3  )
%FindElement Questa funzione fa una ricerca degli elementi dentro matrix
% che corrispondono alle caratteristiche indicate, dove con ind si indica
% la posizione della caratteristica su cui fare la ricerca (per esempio
% colonna 1 o colonna2 o colonna 3), mentre char1 indica il valore voluto in tale
% caratteristica.
%  Tutti gli elementi presenti nella matrice di ritorno, hanno come primo
%  parametro l'ID univoco

s=size(matrix);
%elements=[];
k=1;

%ricerca solo su una caratteristica
if nargin == 3
    for i=1:1:s(1)
        row=matrix(i,:);
        if row(ind1) == char1
            elements(k,:)=[i-1,row];
            k=k+1;
        end
    end
end

%ricerca su due caratteristiche
if nargin == 5
    for i=1:1:s(1)
       row=matrix(i,:);
        if row(ind1) == char1 && row(ind2) == char2
            elements(k,:)=[i-1,row];
            k=k+1;
        end
    end
end

%ricerca su tre caratteristiche
if nargin == 7
    for i=1:1:s(1)
       row=matrix(i,:);
        if row(ind1) == char1 && row(ind2) == char2 && row(ind3) == char3
            elements(k,:)=[i-1,row];
            k=k+1;
        end
    end
end


end

