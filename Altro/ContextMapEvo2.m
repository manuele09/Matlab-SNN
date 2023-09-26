%% Grafico 3D del contesto realizzato mediante l'uso di una mappa dei
%% colori
function ContextMapEvo(indice,Points,subSeq,strlabel)
global path potenziali16 smat16 potenzialiEnd idp16 idt16 fontsize spessore maxIndPre container
%carico i dati
% if(indiceInt==-1)
%  dati = importdata(['Neurons', num2str(indice),'.txt']);
% else
% dati = importdata(['Neurons',num2str(indice),'-',num2str(indiceInt),'.txt']);
% end
% matrici = dati.data;
% clear dati;

% provaPrec=prova;

numberSteps=size(potenziali16,3);
% dim=0;              
% if size(container,2)~=0             %mi serve per capire a che step devo mettere i nuovi dati
%        dim=container{1};
%        dim=size(dim(1,:),2);
% end
%                 
% % for u=1:size(prova,1)
% %     provaPrec(u,size(prova,2)+1:2*(size(prova,2)))=potenziali16(u,maxIndPre(u),101:end);
% %     provaPrec(u,1:size(prova,2))=prova(u,:);
% % end
% if dim~=0
%     f=size(container,2);
%     for u=1:size(maxIndPre,2)
%         
%         coint=container{f};
% %         prova(dim:dim+numberSteps-100)=potenziali16(u,maxIndPre(u),101:end);
%         coint(size(coint,1),dim+1:dim+numberSteps)=potenziali16(u,maxIndPre(u),:);
%         container{f}=coint;
%         f=f-1;
%     end
% end


% number_Rings=3;
% ind=1;
% timestamp = -1;
% 
% for k = 1:size(matrici, 1)
%     riga = matrici(k,:);
%     if riga(1) ~= timestamp
%         timestamp = riga(1);
%     end
%     if riga(2) == 16     %Context Layer
%         i = riga(3);
%         j = riga(4);
%         v = riga(5);
%         u = riga(6);
%         corr = riga(8);
%         spk = riga(7);
%         idp=riga(11);
%         idt=riga(12);
%         
%         if idp==-1 && idt==-1
%         potenzialiEnd(j+1,timestamp+1) = v;%#ok
%         correntiEnd(j+1,timestamp+1) = corr;
%         umatEnd(j+1,timestamp+1) = u; %#ok
%         spikeEnd(j+1, timestamp+1) = spk;
%         else       
%         potenziali16(i+1, j+1, timestamp+1) = v;%#ok
%         correnti16(i+1, j+1, timestamp+1) = corr;
%         vmat16((i+1)*10 + j+1, timestamp+1) = v; %#ok
%         umat16((i+1)*10 + j+1, timestamp+1) = u; %#ok
%         imat16((i+1)*10 + j+1, timestamp+1) = corr; %#ok
%         spike16(i+1, j+1, timestamp+1)=spk;
%         smat16(i+1, j+1) = spk; 
%         idp16(i+1, j+1) = idp; 
%         idt16(i+1, j+1) = idt;
%         end
%         
%         if j ~= -1 && riga(1)==100
%             matrixTree(j+1,1)=i;    %anello
%             matrixTree(j+1,2)=idp;  %ID padre
%             matrixTree(j+1,3)=idt;  %ID target
%                                     %l'indice di colonna è l'ID univoco
%         end
%     end
% end


%definisco cosa plottare
data=mean(potenziali16(:,:,:),3);   %media dei potenziali durante la simulazione
%data2=(smat16(:,:)/1000)*1000/0.08;    %spike rate media nei 1000 steps


%numero di anelli presenti nel contesto
anelli=size(data,1);

for i=1:anelli
    if max(smat16(i,:))~=0
        maxindx(i)=find(smat16(i,:)==max(smat16(i,:)),1);
    end
end
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
%     soglia=-59.9;         % questa valore è settato in modo tale da evitare il problema che venga dato un neurone vincitore pure per gli anelli che non sono simulati
%     update=0;
    if i==1
        inc_angolo=2*pi/(classi^i);%classi^1 implementa la formula delle disposizioni con ripetizione che mi permettono di calcolare il numero di elementi in ogni anello
        angolo = pi/2; 
    end
    for j=1:size(data,2)           %scorro tutti gli elementi che ci devono essere in un anello
        if data(i,j)~=0 
            if i==1
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
%             if info(j,4)> soglia
%                     update=1;
%                     x_max=info(j,1);
%                     y_max=info(j,2);
%                     soglia=info(j,4);
%              end
            if smat16(i,j)~=0 && j==maxindx(i)
                maxpoint=[maxpoint; info(j,1),info(j,2),info(j,4)];
            
            end
           
        end
    
    end
%     if update
%     maxpoint=[maxpoint; x_max,y_max,soglia;];
%     end
    r_start=r_start+r_inc;
end

 %for j=1:size(maxindx,2)
%  j=size(maxindx,2);
%  st=1;
%      while j>=1
%                 if j==1
%                     prova=[];
%                     prova(dim+1:dim+numberSteps)=potenziali16(j,maxindx(j),:);
%                     container{size(container,2)+1}=prova;
%                 else
%                     coint=container{st};
%                     coint(size(coint,1)+1,dim+1:dim+numberSteps)=potenziali16(j,maxindx(j),:);
%                     container{st}=coint;
%                 end
%             j=j-1;
%             st=st+1;
%      end


if subSeq==false
    ult_anello=size(maxpoint,1);                                %mi indica l'ultimo anello attivo nel contesto
    if ult_anello>1
    d=sqrt(maxpoint(ult_anello,1)^2+maxpoint(ult_anello,2)^2);
    for z=1:size(info,1)
        if sqrt(info(z,1)^2+info(z,2)^2)<(d-0.1*d)
            info(z,4)=-60;
        end
    end
    maxpoint=maxpoint(ult_anello,:,:);
    end

end

% maxIndPre=[];
% maxIndPre=maxindx;

if isempty(maxpoint)
    maxpoint=[info(1,1),info(1,2),info(1,4)];
end
%procedo a plottare i dati che sono tutti conservati sulla matrice info
F = TriScatteredInterp(info(:,1),info(:,2),info(:,4));
tx = min(info(:,1))-r_inc:.025:max(info(:,1))+r_inc;
ty = min(info(:,2)):.025:max(info(:,2));
[qx,qy] = meshgrid(tx,ty);
qz = F(qx,qy);
figure('units','normalized','outerposition',[0 0 1 1]);
%mesh(qx,qy,qz);   
surf(qx,qy,qz,'LineStyle','none');
colorbar;
hold on;
if Points
    plot3(info(:,1),info(:,2),max(info(:,4))*ones(size(info(:,4))),'MarkerSize',8,'Marker','o','LineStyle','none','Color',[1 1 1],'MarkerEdgeColor',[0 0 0],'MarkerFaceColor',[1 1 1]); %plotto un pallino per ogni neurone del contesto se lo voglio sulla superficie della funzione devo usare come z: F(info(:,1),info(:,2)
    plot3(maxpoint(:,1),maxpoint(:,2),max(info(:,4))*ones(size(maxpoint(:,1))),'MarkerSize',10,'Marker','o','LineStyle','none','Color',[1 1 1],'MarkerEdgeColor',[0 0 0],'MarkerFaceColor',[1 0 0]);   %plotto un pallino solo nei neuroni vincitori per ogni anello (ci può essere un errore dove il pallino viene introdotto nel neurone vincitore nell'anello all'epoca precedente (ma per come sono tunati i parametri della rete non dovrebbe accadere))
else
    plot3(maxpoint(:,1),maxpoint(:,2),maxpoint(:,3),'MarkerSize',10,'Marker','o','LineStyle','none','Color',[1 1 1],'MarkerEdgeColor',[0 0 0],'MarkerFaceColor',[1 0 0]);   %plotto un pallino solo nei neuroni vincitori per ogni anello (ci può essere un errore dove il pallino viene introdotto nel neurone vincitore nell'anello all'epoca precedente (ma per come sono tunati i parametri della rete non dovrebbe accadere))
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
if(i==anelli)
    plot3(x+xp,y+yp,(max(info(:,4))+1)*ones(size(xp)),'k','LineWidth',1.5);
else
    plot3(x+xp,y+yp,(max(info(:,4))+1)*ones(size(xp)),'w','LineWidth',1.5);  % plotto i cerchi con quel valore di zeta in modo tale che si possano vedere dall'altonell'immagine, altrimenti sarebbero nascosti dalla curva
end
r_start=r_start+r_inc;
end

title('Context Layer','FontSize',fontsize);
zlabel('Membrane Potential (mV)','FontSize',fontsize);
xlabel(gca,strlabel,'FontSize',fontsize);
ylabel(gca,'Membrane Potential (mV)','FontSize',fontsize);
axis([-(r_start),(r_start),-(r_start),(r_start)]);
set(gca,'YTickLabel','','XTickLabel','');
colorbar;
caxis([-85 -55]);
set(gca,'FontSize',fontsize,'PlotBoxAspectRatio',[1.1 1 1]);
view(2);
% Save2ppt(['epoca',num2str(indice+1)]);
Save2ppt(['esperimento_completo']);
saveas(gcf,[path,'Context_Map_sim',num2str(indice+1)],'fig');
saveas(gcf,[path,'Context_Map_sim',num2str(indice+1)],'epsc2');
saveas(gcf,[path,'Context_Map_sim',num2str(indice+1)],'jpg');
   

%% Plot of the End Neuron
w=1;
figure('units','normalized','outerposition',[0 0 1 1]);
for i=1:1:anelli
    
%         membraneEnd = [];
%         for m=1:numberSteps
%               membraneEnd(m) = potenzialiEnd(anelli+1,i,m);
%         end     
           subplot(anelli,1,w);
           w=w+1;
            plot(potenzialiEnd(i,:),'LineWidth',spessore);
%             xlabel('Simulation Steps')
            %ylabel('Membrane Potential (mV)')         
           axis([0,numberSteps,-75,40]);
           NumTicks = 3;
           L = get(gca,'YLim');
           set(gca,'YTick',round(linspace(L(1),L(2),NumTicks)))
           set(gca,'FontSize',fontsize);
%            title(['Ring ',num2str(i)],'FontSize',fontsize-1);
           legend(['Ring ',num2str(i)]);
end
%  suplabel('End Neurons','t',fontsize,[.10 .095 .84 .84]);
 h=suptitle('End Neurons');
 set(h,'FontSize',fontsize);
 legend(['Ring ',num2str(i)]);
 suplabel('Membrane Potential (mV)','y',fontsize); 
 suplabel('Simulation Steps','x',fontsize,[.10 .08 .84 .84]);
%  Save2ppt(['epoca',num2str(indice+1)]);
 Save2ppt(['esperimento_completo']);
 saveas(gcf,[path,'EndNeurons_sim',num2str(indice+1)],'fig');
 saveas(gcf,[path,'EndNeurons_sim',num2str(indice+1)],'epsc2');
 saveas(gcf,[path,'EndNeurons_sim',num2str(indice+1)],'jpg');
 
 

end