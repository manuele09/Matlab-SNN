%%% variabili da settare %%%
%% Constest Layer Number(SOSL#3) = 12
%% End sequence Layer Number = 13
%% SOSL#1 Number = 2                    N.B. 13 e 2 possono essere solo
%% DestLayer data l'implementazione

m=29;        % numero di fasi di learning da plottare -1
n=4;         % numero di fasi di test da plottare 
f=n+m;
%p=n-1;            % numero di fasi di test da plottare -1
StLayer = 12;    % Layer del neurone di start
StRow = 2;      % Indice di riga del neurone di start
StCol = 4;      % Indice di colonna del neurone di start
StRow2 = 3;      % Indice di riga del neurone di start
StCol2 = 6;      % Indice di colonna del neurone di start
DestLayer = 2;    % Layer del neurone di destinazione
DestRow = 0;      % Indice di riga del neurone di destinazione
DestCol = 1;      % Indice di colonna del neurone di destinazione
StRowB = 4;      % Indice di riga del neurone di start
StColB = 5;      % Indice di colonna del neurone di start
DestRowB = 3;      % Indice di riga del neurone di destinazione
DestColB = 2;      % Indice di colonna del neurone di destinazione
lastA =0;
lastB=0;
lastn=0;
WA =[];
WB =[];
Wn =[];
%% LEARNING
for i=1:m                % inizio da i=1 per non plottare la prima simulazione (i=0) dove le sinapsi STDP non sono attive
dati = importdata(['SynapseSTDP', num2str(i) ,'.txt']);
matrici = dati.data;
[row,col]=size(matrici);
for a=1:row
    if (matrici(a,2) == StLayer) &  (matrici(a,3) == StRow) & (matrici(a,4) == StCol) & (matrici(a,5) == DestLayer) &  (matrici(a,6) == DestRow) & (matrici(a,7) == DestCol)
         WA(1,i+1) = matrici(a,8);
         lastA = matrici(a,8);
         %I(1,index) = matrici(a,9);
    elseif (matrici(a,2) == StLayer) &  (matrici(a,3) == StRowB) & (matrici(a,4) == StColB) & (matrici(a,5) == DestLayer) &  (matrici(a,6) == DestRowB) & (matrici(a,7) == DestColB)
        WB(1,i+1) = matrici(a,8);
        lastB = matrici(a,8);
    
    elseif (matrici(a,2) == StLayer) &  (matrici(a,3) == StRow2) & (matrici(a,4) == StCol2) & (matrici(a,5) == DestLayer) &  (matrici(a,6) == DestRowB) & (matrici(a,7) == DestColB)
        Wn(1,i+1) = matrici(a,8);
        lastn = matrici(a,8);
    
    end
end
    
end

t=m+1;        
%% TEST
 for i=t:f
 if i==m+1
  WA(1,i+1) =lastA;
  WB(1,i+1) =lastB;
  Wn(1,i+1) =lastn;
 else
dati = importdata(['SynapseSTDP', num2str(i) ,'.txt']);
matrici = dati.data;
[row,col]=size(matrici);
for a=1:row
    if (matrici(a,2) == StLayer) &  (matrici(a,3) == StRow) & (matrici(a,4) == StCol) & (matrici(a,5) == DestLayer) &  (matrici(a,6) == DestRow) & (matrici(a,7) == DestCol)
         WA(1,i+1) = matrici(a,8);
         %I(1,index) = matrici(a,9);
         
         %pause
    elseif (matrici(a,2) == StLayer) &  (matrici(a,3) == StRowB) & (matrici(a,4) == StColB) & (matrici(a,5) == DestLayer) &  (matrici(a,6) == DestRowB) & (matrici(a,7) == DestColB)
        WB(1,i+1) = matrici(a,8);
    elseif (matrici(a,2) == StLayer) &  (matrici(a,3) == StRow2) & (matrici(a,4) == StCol2) & (matrici(a,5) == DestLayer) &  (matrici(a,6) == DestRowB) & (matrici(a,7) == DestColB)
        Wn(1,i+1) = matrici(a,8);
    end
end
end
end

figure
set(gcf,'numbertitle','off','name','Peso Sinapsi STDP')
plot(WA,'b');
hold all
plot(WB,'r');
plot(Wn,'g');
xlabel('epoch')
ylabel('Sinaptic Weight [W]')
title('Evolution of the sinaptic weights')
hold off
clear all