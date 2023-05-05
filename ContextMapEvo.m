%% Grafico 3D del contesto realizzato mediante l'uso di una mappa dei
%% colori
function ContextMapEvo(indice,indiceInt)

%carico i dati
if(indiceInt==-1)
 dati = importdata(['../Dati/Neurons', num2str(indice),'.txt']);
else
dati = importdata(['../Dati/Neurons',num2str(indice),'-',num2str(indiceInt),'.txt']);
end
matrici = dati.data;
clear dati;


numberSteps=1100; 
number_Rings=4;
window = 300; %finestra in cui calcolare la media
ind=1;
timestamp = -1;

for k = 1:size(matrici, 1)
    riga = matrici(k,:);
    if riga(1) ~= timestamp
        timestamp = riga(1);
    end
    if riga(2) == 16     %Context Layer
        i = riga(3); %row
        j = riga(4); %column
        v = riga(5);
        u = riga(6);
        corr = riga(8); %current
        spk = riga(7); %nspikes
        idp=riga(11); %id_father
        idt=riga(12); %id_target
        
        if idp==-1 && idt==-1 %è un End Neuron
        potenzialiEnd(i+1, j+1,timestamp+1) = v;%#ok
        correntiEnd(i+1, j+1,timestamp+1) = corr;
        umatEnd(i+1, j+1,timestamp+1) = u; %#ok
        spikeEnd(i+1, j+1, timestamp+1) = spk;
        else %neurone dell'anello
        potenziali16(i+1, j+1, timestamp+1) = v;%#ok
        correnti16(i+1, j+1, timestamp+1) = corr;
        vmat16((i+1)*10 + j+1, timestamp+1) = v; %#ok %COSA???
        umat16((i+1)*10 + j+1, timestamp+1) = u; %#ok
        imat16((i+1)*10 + j+1, timestamp+1) = corr; %#ok
        spike16(i+1, j+1, timestamp+1)=spk;
        smat16(i+1, j+1) = spk; 
        idp16(i+1, j+1) = idp; 
        idt16(i+1, j+1) = idt;
        end
        
        %ricordo che j è l'id univoco dei neuroni del context
        if j ~= -1 && riga(1)==100
            matrixTree(j+1,1)=i;    %anello
            matrixTree(j+1,2)=idp;  %ID padre
            matrixTree(j+1,3)=idt;  %ID target
                                    %l'indice di colonna è l'ID univoco
        end
    end
end


%definisco cosa plottare
data=mean(potenziali16(:,:,end-window:end),3);   %media dei potenziali durante la simulazione

%data=(smat16(:,:)/1000)*1000/0.08;    %spike rate media nei 1000 steps

%numero di anelli presenti nel contesto
anelli=size(data,1);

%procedo a contare il numero di elementi nel primo anello in modo da sapere
%quante classi sono state apprese
classi=0;
for i=1:size(data,2)
    if data(1,i)~=0
        classi=classi+1;
    end
end


%raggio iniziale del primo anello e incremento ad ogni anello successivo
r_start=1;
r_inc=1;

%definisco una matrice che ha come indice di riga l'id univoco del neurone
%e 4 colonne in cui conservo: nella prima e seconda colonna le coordinate x
%e y, nella terza colonna l'angolo rispetto all'asse orizzontale in cui si
%trova il punto, nella quarta colonna il valore da dare al punto

info=[];
maxpoint=[];
for i=1:anelli
    soglia=-59.9;         % questa valore è settato in modo tale da evitare il problema che venga dato un neurone vincitore pure per gli anelli che non sono simulati
    %soglia = -150;
    update=0;
    if i==1 %primo anello
        inc_angolo=2*pi/(classi^i);%classi^1 implementa la formula delle disposizioni con ripetizione che mi permettono di calcolare il numero di elementi in ogni anello
        angolo = pi/2; 
    end
    for j=1:size(data,2)           %scorro tutti gli elementi che ci devono essere in un anello
        if data(i,j)~=0 
            if i==1 %primo anello
                info(j,3)=angolo;
                [x,y]=pol2cart(angolo,(r_start-r_inc/2));
                info(j,1)=x;
                info(j,2)=y;
                angolo=angolo-inc_angolo;
                info(j,4)=data(i,j);
                
            else
                angolo=info(idp16(i,j)+1,3)-((2*pi/(classi^(i-1)))/classi*idt16(i,j))+(2*pi/(classi^(i-1)))/2-((2*pi/(classi^(i-1)))/classi)/2;
                info(j,3)=angolo;
                [x,y]=pol2cart(angolo,(r_start-r_inc/2));
                info(j,1)=x;
                info(j,2)=y;
                info(j,4)=data(i,j);
            end
            if info(j,4)> soglia
                    update=1;
                    x_max=info(j,1);
                    y_max=info(j,2);
                    soglia=info(j,4);
             end
        end
    
    end
   if update
       maxpoint=[maxpoint; x_max,y_max,soglia;];
       %di volta in volta andiamo ad aggiungere una riga
       %al massimo ne avremo 3
    end
    r_start=r_start+r_inc;
end

%procedo a plottare i dati che sono tutti conservati sulla matrice info
F = TriScatteredInterp(info(:,1),info(:,2),info(:,4));
tx = min(info(:,1))-r_inc:.025:max(info(:,1))+r_inc;
ty = min(info(:,2)):.025:max(info(:,2));
[qx,qy] = meshgrid(tx,ty);
qz = F(qx,qy);
%figure
%mesh(qx,qy,qz);   
surf(qx,qy,qz,'LineStyle','none');
colorbar;
hold on;
%plot3(info(:,1),info(:,2),F(info(:,1),info(:,2)),'MarkerSize',15,'Marker','.','LineStyle','none','Color',[0.749019622802734 0 0.749019622802734]); %plotto un pallino per ogni neurone del contesto
if (size(maxpoint, 1) ~= 0)
    %plot3(maxpoint(:,1),maxpoint(:,2),maxpoint(:,3),'MarkerSize',15,'Marker','.','LineStyle','none','Color',[0.749019622802734 0 0.749019622802734]);   %plotto un pallino solo nei neuroni vincitori per ogni anello (ci può essere un errore dove il pallino viene introdotto nel neurone vincitore nell'anello all'epoca precedente (ma per come sono tunati i parametri della rete non dovrebbe accadere))
    plot3(info(:,1),info(:,2), info(:, 4),'MarkerSize',7,'Marker','.','LineStyle','none','Color','black'); %plotto un pallino per ogni neurone del contesto
    plot3(maxpoint(:,1),maxpoint(:,2),maxpoint(:,3),'MarkerSize',15,'Marker','.','LineStyle','none','Color', 'red');   %plotto un pallino solo nei neuroni vincitori per ogni anello (ci può essere un errore dove il pallino viene introdotto nel neurone vincitore nell'anello all'epoca precedente (ma per come sono tunati i parametri della rete non dovrebbe accadere))

end
%plotto gli anelli
x=0;
y=0;
%x and y are the coordinates of the center of the circle
%r is the radius of the circle
%0.01 is the angle step, bigger values will draw the circle faster but
%you might notice imperfections (not very smooth)
ang=0:0.01:2*pi;
r_start=1;
for i=1:anelli

xp=r_start*cos(ang);
yp=r_start*sin(ang);
hold on
plot3(x+xp,y+yp,(max(info(:,4))+1)*ones(size(xp)),'m','LineWidth',1.5);     % plotto i cerchi con quel valore di zeta in modo tale che si possano vedere dall'altonell'immagine, altrimenti sarebbero nascosti dalla curva
%plot3(xp,yp,(min(info(:,4)) - 15)*ones(size(xp)),'m','LineWidth',0.5, 'Color', 'black');     % plotto i cerchi con quel valore di zeta in modo tale che si possano vedere dall'altonell'immagine, altrimenti sarebbero nascosti dalla curva
r_start=r_start+r_inc;
end

stringa = sprintf("Map of the Context Layer, Sim: %d", indice);
title(stringa,'FontSize',16);
zlabel('Membrane Potential (mV)');
axis([-(r_start),(r_start),-(r_start),(r_start)]);
view(2);

%saveas(gcf,['Context_Map_sim',num2str(indice+1)],'fig');

     




end