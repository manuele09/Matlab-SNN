function PlottaContext (indice,indiceInt) 
%stampa delle informazioni utili sul context, non il grafico con il
%gradiente a colori
if(indiceInt==-1)
 dati = importdata(['../Dati/Neurons', num2str(indice),'.txt']);
else
dati = importdata(['../Dati/Neurons',num2str(indice),'-',num2str(indiceInt),'.txt']);
end
matrici = dati.data;
clear dati;


numberSteps=1200; 
number_Rings=3;
ind=1;
timestamp = -1;

for k = 1:size(matrici, 1)
    riga = matrici(k,:);
    if riga(1) ~= timestamp
        timestamp = riga(1);
    end
    if riga(2) == 16     %Context Layer
        i = riga(3);
        j = riga(4);
        v = riga(5);
        u = riga(6);
        corr = riga(8);
        spk = riga(7);
        idp=riga(11);
        idt=riga(12);
        
        if idp==-1 && idt==-1
        potenzialiEnd(i+1, j+1,timestamp+1) = v;%#ok
        correntiEnd(i+1, j+1,timestamp+1) = corr;
        umatEnd(i+1, j+1,timestamp+1) = u; %#ok
        spikeEnd(i+1, j+1, timestamp+1) = spk;
        else       
        potenziali16(i+1, j+1, timestamp+1) = v;%#ok
        correnti16(i+1, j+1, timestamp+1) = corr;
        vmat16((i+1)*10 + j+1, timestamp+1) = v; %#ok
        umat16((i+1)*10 + j+1, timestamp+1) = u; %#ok
        imat16((i+1)*10 + j+1, timestamp+1) = corr; %#ok
        spike16(i+1, j+1, timestamp+1)=spk;
        smat16(i+1, j+1) = spk; 
        idp16(i+1, j+1) = idp; 
        idt16(i+1, j+1) = idt;
        end
        
        if j ~= -1 && riga(1)==200
            matrixTree(j+1,1)=i;    %anello
            matrixTree(j+1,2)=idp;  %ID padre
            matrixTree(j+1,3)=idt;  %ID target
                                    %l'indice di riga è l'ID univoco
        end
    end
end

%% TREE
%ogni elemento dell'albero è contrassegnato da (i,j)
% dove i corrisponde all'ID e j all' IDtarget

s=size(matrixTree);

z=find(sort(matrixTree(:,1)));
number_target=z(1)-1;

rings=unique(matrixTree(:,1),'rows');
rings=size(rings,1);


for i=1:1:number_target
    nodes=[];
    first_element = FindElement(matrixTree, 1, 0, 3, i-1);
    nodes = 0;
    figure
    treeplot(nodes)
    [x,y] = treelayout(nodes);
    text(x(1), y(1), ['(',num2str(first_element(1)),',',num2str(first_element(4)),')'], 'VerticalAlignment','bottom','HorizontalAlignment','right')

    if rings >1
        second_element = FindElement(matrixTree, 1, 1, 2, first_element(1));
        s2=size(second_element);
        
        if rings == 3    %Ho 3 anelli
            for n=1:1:s2(1)
                 third_element = FindElement(matrixTree, 1, 2, 2, second_element(n,1));
                  s3=size(third_element);
                  nodes=[nodes, 1, (size(nodes,2)+1)*ones(1,s3(1))];
                    treeplot(nodes)
                    [x,y] = treelayout(nodes);
                    text(x(1), y(1), ['(',num2str(first_element(1)),',',num2str(first_element(4)),')'], 'VerticalAlignment','bottom','HorizontalAlignment','right')                  
            end
            for m=1:1:s2(1)
                text(x(m+1 + s3(1)*(m-1)), y(m+1 + s3(1)*(m-1)), ['(',num2str(second_element(m,1)),',',num2str(second_element(m,4)),')'], 'VerticalAlignment','bottom','HorizontalAlignment','right')
                for o=1:1:s3(1)
                   third_element = FindElement(matrixTree, 1, 2, 2, second_element(m,1));
                   text(x(m+1 +s3(1)*(m-1) +o), y(m+1 + s3(1)*(m-1)+o), ['(',num2str(third_element(o,1)),',',num2str(third_element(o,4)),')'], 'VerticalAlignment','bottom','HorizontalAlignment','right')
                end
            end
            
        elseif rings == 2  %Ho solo 2 anelli         
            nodes=[nodes, ones(1,s2(1))];
            treeplot(nodes)
            [x,y] = treelayout(nodes);
            text(x(1), y(1), ['(',num2str(first_element(1)),',',num2str(first_element(4)),')'], 'VerticalAlignment','bottom','HorizontalAlignment','right')
            for n=1:1:s2
                text(x(n+1), y(n+1), ['(',num2str(second_element(n,1)),',',num2str(second_element(n,4)),')'], 'VerticalAlignment','bottom','HorizontalAlignment','right')
            end
        end
    end


    
     title({['Target ', num2str(i-1)], '(ID,target)'},'FontSize',12,'FontName','Times New Roman');
end

% %% Valutiamo il numero di elementi presenti in ogni anello
% % dentro size_rings(i) abbiamo il numero di neuroni presenti nell'i-esimo
% % anello
% for i=1:1:rings
%     ele = FindElement(matrixTree, 1, i-1);
%     size_Rings(i) = size(ele,1); 
% end

%% Plot of the membrane potential for each ring

for i=1:1:rings
        
        figure
        set(gcf,'numbertitle','off','name',['Potential_Context_ring',num2str(i),'_sim',num2str(indice+1)]) % See the help for GCF 
        ele = FindElement(matrixTree, 1, i-1);
        father_number=size(unique(ele(:,3)),1);
        ele=sortrows(ele,3);
        %j=1;       
        w=1;
        for n = 1:1:size(ele,1)
           membrane16 = [];
           for m=1:numberSteps
              membrane16(m) = potenziali16(i,ele(n,1)+1,m);
           end     
           subplot(father_number,size(ele,1)/father_number,w);
           w=w+1;
       
           if ele(n,4)== 0
                plot(membrane16, 'b')
           elseif ele(n,4)== 1
                plot(membrane16, 'r')
           elseif ele(n,4)== 2
                plot(membrane16, 'g')
           else
                plot(membrane16, 'k')
           end
            axis([0,numberSteps,-200,100]);
            hleg1=legend(['ID = ',num2str(ele(n,1)),' ID-Father = ',num2str(ele(n,3))]);
            set(hleg1,'Location','northoutside','FontSize',6)
            %title(['ID = ',num2str(ele(n,1)),' ID-Father = ',num2str(ele(n,3))])%,' ID-Target = ',num2str(ele(n,4))])
%             xlabel('step')
%             ylabel('membrane potential [mV]')
        end
    xlabel('step')
    ylabel('membrane potential [mV]')
    suptitle(['Membrane potentials of the Context Layer in the ring ',num2str(i)])
        
   
end


%% Plot of the input current for each ring

for i=1:1:rings
        
        figure
        set(gcf,'numbertitle','off','name',['CurrentInput_Context_ring',num2str(i),'_sim',num2str(indice+1)]) % See the help for GCF 
        ele = FindElement(matrixTree, 1, i-1);
        father_number=size(unique(ele(:,3)),1);
        ele=sortrows(ele,3);
        %j=1;       
        w=1;
        for n = 1:1:size(ele,1)
           current16 = [];
           for m=1:numberSteps
              current16(m) = correnti16(i,ele(n,1)+1,m);
           end     
           subplot(father_number,size(ele,1)/father_number,w);
           w=w+1;
       
           if ele(n,4)== 0
                plot(current16, 'b')
           elseif ele(n,4)== 1
                plot(current16, 'r')
           elseif ele(n,4)== 2
                plot(current16, 'g')
           else
                plot(current16, 'k')
           end
            axis([0,numberSteps,-600,300]);
            hleg1=legend(['ID = ',num2str(ele(n,1)),' ID-Father = ',num2str(ele(n,3))]);
            set(hleg1,'Location','northoutside','FontSize',6)
            %title(['ID = ',num2str(ele(n,1)),' ID-Father = ',num2str(ele(n,3))])%,' ID-Target = ',num2str(ele(n,4))])
%             xlabel('step')
%             ylabel('current [pA]')
        end
   
    xlabel('step')
    ylabel('current [pA]')   
    suptitle(['Input current of the Context Layer in the ring ',num2str(i)])
        
   
end

%% Plot of the Spike rate for each ring
window=250; 
for i=1:1:rings
        
        figure
        set(gcf,'numbertitle','off','name',['Spike_Context_ring',num2str(i),'_sim',num2str(indice+1)]) % See the help for GCF 
        ele = FindElement(matrixTree, 1, i-1);
        father_number=size(unique(ele(:,3)),1);
        ele=sortrows(ele,3);
        %j=1;       
        w=1;
        for n = 1:1:size(ele,1)
           spikelist16 = [];
           for m=1:numberSteps

                        if(m<=window)
                          spikelist16(i,ele(n,1)+1,m) = (spike16(i,ele(n,1)+1,m)/(m))*1000/0.08;
                        else
                          spikelist16(i,ele(n,1)+1,m)= ((spike16(i, ele(n,1)+1, m)-spike16(i, ele(n,1)+1,m-window))/window)*1000/0.08;
                        end
                     
           end     
           subplot(father_number,size(ele,1)/father_number,w);
           w=w+1;
       
           if ele(n,4)== 0
                plot(squeeze(spikelist16(i, ele(n,1)+1, :)), 'b')
           elseif ele(n,4)== 1
                plot(squeeze(spikelist16(i, ele(n,1)+1, :)), 'r')
           elseif ele(n,4)== 2
                plot(squeeze(spikelist16(i, ele(n,1)+1, :)), 'g')
           else
                plot(squeeze(spikelist16(i, ele(n,1)+1, :)), 'k')
           end
            %axis([0,numberSteps,-200,2000]);
            hleg1=legend(['ID = ',num2str(ele(n,1)),' ID-Father = ',num2str(ele(n,3))]);
            set(hleg1,'Location','northoutside','FontSize',6)
            %title(['ID = ',num2str(ele(n,1)),' ID-Father = ',num2str(ele(n,3))])%,' ID-Target = ',num2str(ele(n,4))])
%             xlabel('step')
%             ylabel('membrane potential [mV]')
        end
    xlabel('step')
    ylabel('spike rate [Hz]')
    suptitle(['Spike Rate of the Context Layer in the ring ',num2str(i)])
        
   
end


%% Plot of the End Neuron
w=1;
figure
for i=1:1:rings
    
        membraneEnd = [];
        for m=1:numberSteps
              membraneEnd(m) = potenzialiEnd(rings+1,i,m);
        end     
           subplot(rings,1,w);
           w=w+1;
            plot(membraneEnd)
            xlabel('step')
            ylabel('Membrane Potential [mV]')         
            axis([0,numberSteps,-75,40]);   
end
 suptitle('Membrane potentials of the End Neuron')

% figure
% plot(correntiEnd)
% xlabel('step','fontsize',14)
% ylabel('Current [pA]','fontsize',14)
% set(gca,'FontSize',14)
% title('Current of the End Neuron')
% axis([0,numberSteps,-10,30]);

% w=1;
% figure
% for i=1:1:rings
%     
%         currentEnd = [];
%         for m=1:numberSteps
%               currentEnd(m) = correntiEnd(rings+1,i,m);
%         end     
%            subplot(rings,1,w);
%            w=w+1;
%             plot(currentEnd)
%             xlabel('step')
%             ylabel('Current [pA]')          
%             axis([0,numberSteps,-10,50]);   
% end
%  suptitle('Current of the End Neuron')


end