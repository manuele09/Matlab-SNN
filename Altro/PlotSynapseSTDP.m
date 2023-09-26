%%%%%%%% SynapsesSTDP.m  %%%%%%

%%% variabili da settare %%%
%% Constest Layer Number(SOSL#3) = 12
%% End sequence Layer Number = 13
%% SOSL#1 Number = 2                    N.B. 13 e 2 possono essere solo DestLayer data l'implementazione

m=35;        % numero di fasi di learning da plottare -1
n=5;            % numero di fasi di test da plottare 
p=n-1;            % numero di fasi di test da plottare -1
StLayer = 12;    % Layer del neurone di start
StRow = 0;      % Indice di riga del neurone di start
StCol = 0;      % Indice di colonna del neurone di start
DestLayer = 2;    % Layer del neurone di destinazione
DestRow = 2;      % Indice di riga del neurone di destinazione
DestCol = 5;      % Indice di colonna del neurone di destinazione

if p>0
    W=zeros(1,1000*(m+p));
    I=zeros(1,1000*(m+p));
    t=[1:1000*(m+p)];
else
    W=zeros(1,1000*m);
    I=zeros(1,1000*m);
    t=[1:1000*m];
end
index=1;

%% LEARNING
for i=1:m                % inizio da i=1 per non plottare la prima simulazione (i=0) dove le sinapsi STDP non sono attive
dati = importdata(['SynapseSTDP', num2str(i) ,'.txt']);
matrici = dati.data;
i
[row,col]=size(matrici);
for a=1:row
    if (matrici(a,2) == StLayer) &  (matrici(a,3) == StRow) & (matrici(a,4) == StCol) & (matrici(a,5) == DestLayer) &  (matrici(a,6) == DestRow) & (matrici(a,7) == DestCol)
         W(1,index) = matrici(a,8);
         I(1,index) = matrici(a,9);
         index = index+1;
         %pause
    end
end
    
end

%plot(t,W);
%plot(t,I);


n=n+m;        
%% TEST
for i=m+2:n
dati = importdata(['SynapseSTDP', num2str(i) ,'.txt']);
matrici = dati.data;
i
[row,col]=size(matrici);
for a=1:row
    if (matrici(a,2) == StLayer) &  (matrici(a,3) == StRow) & (matrici(a,4) == StCol) & (matrici(a,5) == DestLayer) &  (matrici(a,6) == DestRow) & (matrici(a,7) == DestCol)
         W(1,index) = matrici(a,8);
         I(1,index) = matrici(a,9);
         index = index+1;
         %pause
    end
end
end

plot(t,W);
%plot(t,I);