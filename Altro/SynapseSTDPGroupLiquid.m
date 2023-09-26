%%%%%%%% SynapsesSTDP.m  %%%%%%

%%% variabili da settare %%%
%% Liquid Number = 14                 
%% output neuron = (100,100)  in layer 14


m=13;        % numero di fasi di learning da plottare -1
n=0;            % numero di fasi di test da plottare 
p=n-1;            % numero di fasi di test da plottare -1
StLayer = 14;    % Layer del neurone di start
StRow = 0;      % Indice di riga del neurone di start
StCol = 0;      % Indice di colonna del neurone di start
DestLayer = 15;    % Layer del neurone di destinazione
DestRow = 0;      % Indice di riga del neurone di destinazione
DestCol = 0;      % Indice di colonna del neurone di destinazione

if p>0
    W0=zeros(1,100*(m+p));
    I0=zeros(1,100*(m+p));
    
    W1=zeros(1,100*(m+p));
    I1=zeros(1,100*(m+p));
%     W2=zeros(1,1000*(m+p));
%     I2=zeros(1,1000*(m+p));
%     W3=zeros(1,1000*(m+p));
%     I3=zeros(1,1000*(m+p));
%     W4=zeros(1,1000*(m+p));
%     I4=zeros(1,1000*(m+p));
%     W5=zeros(1,1000*(m+p));
%     I5=zeros(1,1000*(m+p));
%     W6=zeros(1,1000*(m+p));
%     I6=zeros(1,1000*(m+p));
%     W7=zeros(1,1000*(m+p));
%     I7=zeros(1,1000*(m+p));
%     W8=zeros(1,1000*(m+p));
%     I8=zeros(1,1000*(m+p));
%     W9=zeros(1,1000*(m+p));
%     I9=zeros(1,1000*(m+p));
%     W10=zeros(1,1000*(m+p));
%     I10=zeros(1,1000*(m+p));
    
    t=[1:100*(m+p)];
else
    W=zeros(1,100*m);
    I=zeros(1,100*m);
    t=[1:100*m];
    W0=zeros(1,100*(m));
    I0=zeros(1,100*(m));
    
    W1=zeros(1,100*(m));
    I1=zeros(1,100*(m));
end
index=1;
index2=1;

%% LEARNING
for i=0:m                % inizio da i=1 per non plottare la prima simulazione (i=0) dove le sinapsi STDP non sono attive
dati = importdata(['Dati\SynapseSTDP', num2str(i) ,'.txt']);
matrici = dati.data;

%only for the liquid state
timestamp = -1;
for k = 1:size(matrici, 1)
    riga = matrici(k,:);
    if riga(1) ~= timestamp
        timestamp = riga(1);
    end
     if (riga(2) == StLayer) && (riga(5) == DestLayer)
         l = riga(3);
         j = riga(4);
         Wtot(l+1,j+1,timestamp+1) = riga(8); 
     end
    
end

savefile = strcat('Wtot',num2str(i),'.mat');
save(savefile, 'Wtot')

figure
for a = 1:8
    for b=1:8
        plot(squeeze(Wtot(a,b,:)))
        hold on
    end
end

% 
% i
% [row,col]=size(matrici);
% for a=1:row
%     riga=matrici(a,:);
%     if (riga(2) == StLayer) &&  (riga(3) == StRow) && (riga(4) == StCol) && (riga(5) == DestLayer) &&  (riga(6) == DestRow) && (riga(7) == DestCol)
%          W0(1,index) = riga(8);
%          I0(1,index) = riga(9); 
%          index = index+1;
%          %pause
%     elseif (riga(2) == StLayer) &&  (riga(3) == 0) && (riga(4) == 1) && (riga(5) == DestLayer) &&  (riga(6) == DestRow) && (riga(7) == DestCol)
%          W1(1,index2) = riga(8);
%          I1(1,index2) = riga(9);  
%          index2 = index2+1;
% %      elseif (riga(2) == StLayer) &  (riga(3) == 1) & (riga(4) == 0) & (riga(5) == DestLayer) &  (riga(6) == DestRow) & (riga(7) == DestCol)
% %          W2(1,index) = riga(8);
% %          I2(1,index) = riga(9); 
% %     elseif (riga(2) == StLayer) &  (riga(3) == 0) & (riga(4) == 11) & (riga(5) == DestLayer) &  (riga(6) == DestRow) & (riga(7) == DestCol)
% %          W3(1,index) = riga(8);
% %          I3(1,index) = riga(9); 
% %     elseif (riga(2) == StLayer) &  (riga(3) == 11) & (riga(4) == 0) & (riga(5) == DestLayer) &  (riga(6) == DestRow) & (riga(7) == DestCol)
% %          W4(1,index) = riga(8);
% %          I4(1,index) = riga(9); 
% %     elseif (riga(2) == StLayer) &  (riga(3) == 6) & (riga(4) == 2) & (riga(5) == DestLayer) &  (riga(6) == DestRow) & (riga(7) == DestCol)
% %          W5(1,index) = riga(8);
% %          I5(1,index) = riga(9); 
% %    elseif (riga(2) == StLayer) &  (riga(3) == 6) & (riga(4) == 3) & (riga(5) == DestLayer) &  (riga(6) == DestRow) & (riga(7) == DestCol)
% %          W6(1,index) = riga(8);
% %          I6(1,index) = riga(9); 
% %     elseif (riga(2) == StLayer) &  (riga(3) == 7) & (riga(4) == 2) & (riga(5) == DestLayer) &  (riga(6) == DestRow) & (riga(7) == DestCol)
% %          W7(1,index) = riga(8);
% %          I7(1,index) = riga(9); 
% %     elseif (riga(2) == StLayer) &  (riga(3) == 6) & (riga(4) == 1) & (riga(5) == DestLayer) &  (riga(6) == DestRow) & (riga(7) == DestCol)
% %          W8(1,index) = riga(8);
% %          I8(1,index) = riga(9); 
% %     elseif (riga(2) == StLayer) &  (riga(3) == 5) & (riga(4) == 2) & (riga(5) == DestLayer) &  (riga(6) == DestRow) & (riga(7) == DestCol)
% %          W9(1,index) = riga(8);
% %          I9(1,index) = riga(9); 
% %     elseif (riga(2) == StLayer) &  (riga(3) == 0) & (riga(4) == 5) & (riga(5) == DestLayer) &  (riga(6) == DestRow) & (riga(7) == DestCol)
% %          W10(1,index) = riga(8);
% %          I10(1,index) = riga(9); 
%     end
%     %index = index+1;
% end
%     
end
% 
% %plot(t,W);
% %plot(t,I);
% 
% 
% % n=n+m;        
% % %% TEST
% % for i=m+2:n
% % dati = importdata(['SynapseSTDP', num2str(i) ,'.txt']);
% % matrici = dati.data;
% % i
% % [row,col]=size(matrici);
% % for a=1:row
% %    riga=matrici(a,:);
% %     if (riga(2) == StLayer) &&  (riga(3) == StRow) && (riga(4) == StCol) && (riga(5) == DestLayer) &&  (riga(6) == DestRow) && (riga(7) == DestCol)
% %          W0(1,index) = riga(8);
% %          I0(1,index) = riga(9);         
% %          %pause
% %     elseif (riga(2) == StLayer) &&  (riga(3) == 0) && (riga(4) == 1) && (riga(5) == DestLayer) &&  (riga(6) == DestRow) && (riga(7) == DestCol)
% %          W1(1,index) = riga(8);
% %          I1(1,index) = riga(9);  
% % %      elseif (riga(2) == StLayer) &  (riga(3) == 1) & (riga(4) == 0) & (riga(5) == DestLayer) &  (riga(6) == DestRow) & (riga(7) == DestCol)
% % %          W2(1,index) = riga(8);
% % %          I2(1,index) = riga(9); 
% % %     elseif (riga(2) == StLayer) &  (riga(3) == 0) & (riga(4) == 11) & (riga(5) == DestLayer) &  (riga(6) == DestRow) & (riga(7) == DestCol)
% % %          W3(1,index) = riga(8);
% % %          I3(1,index) = riga(9); 
% % %     elseif (riga(2) == StLayer) &  (riga(3) == 11) & (riga(4) == 0) & (riga(5) == DestLayer) &  (riga(6) == DestRow) & (riga(7) == DestCol)
% % %          W4(1,index) = riga(8);
% % %          I4(1,index) = riga(9); 
% % %     elseif (riga(2) == StLayer) &  (riga(3) == 6) & (riga(4) == 2) & (riga(5) == DestLayer) &  (riga(6) == DestRow) & (riga(7) == DestCol)
% % %          W5(1,index) = riga(8);
% % %          I5(1,index) = riga(9); 
% % %    elseif (riga(2) == StLayer) &  (riga(3) == 6) & (riga(4) == 3) & (riga(5) == DestLayer) &  (riga(6) == DestRow) & (riga(7) == DestCol)
% % %          W6(1,index) = riga(8);
% % %          I6(1,index) = riga(9); 
% % %     elseif (riga(2) == StLayer) &  (riga(3) == 7) & (riga(4) == 2) & (riga(5) == DestLayer) &  (riga(6) == DestRow) & (riga(7) == DestCol)
% % %          W7(1,index) = riga(8);
% % %          I7(1,index) = riga(9); 
% % %     elseif (riga(2) == StLayer) &  (riga(3) == 6) & (riga(4) == 1) & (riga(5) == DestLayer) &  (riga(6) == DestRow) & (riga(7) == DestCol)
% % %          W8(1,index) = riga(8);
% % %          I8(1,index) = riga(9); 
% % %     elseif (riga(2) == StLayer) &  (riga(3) == 5) & (riga(4) == 2) & (riga(5) == DestLayer) &  (riga(6) == DestRow) & (riga(7) == DestCol)
% % %          W9(1,index) = riga(8);
% % %          I9(1,index) = riga(9); 
% % %     elseif (riga(2) == StLayer) &  (riga(3) == 0) & (riga(4) == 5) & (riga(5) == DestLayer) &  (riga(6) == DestRow) & (riga(7) == DestCol)
% % %          W10(1,index) = riga(8);
% % %          I10(1,index) = riga(9); 
% %     end
% %     index = index+1;
% % end
% % end
% 
% figure
% 
% plot(t,W0)
% hold all
% plot(t,W1)
% % plot(t,W2)
% % plot(t,W3)
% % plot(t,W4)
% % plot(t,W5)
% % plot(t,W6)
% % plot(t,W7)
% % plot(t,W8)
% % plot(t,W9)
% % plot(t,W10)
% 
% %figure
% %plot(t,I);