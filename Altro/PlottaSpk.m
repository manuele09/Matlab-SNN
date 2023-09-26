function Plotta (indice) 
% ', num2str(indice), '
dati = importdata(['Dati/Neurons', num2str(indice),'.txt']);
matrici = dati.data;
clear dati;

potenziali1 = [];
potenziali2 = [];
correnti1 =[];
correnti2 =[];
potenziali3 = [];
potenziali12 = [];
correnti12 = [];
spike =[];

% vmat1 = [];
% imat1 = [];
vmat2 = [];
imat2 = [];
umat2 = [];
smat2 = zeros(9,9);
vmat3 = [];
imat3 = [];
umat3 = [];
vmat4 = [];
imat4 = [];
vmat5 = [];
imat5in = [];
vmat6 = [];
imat6in = [];
vmat12 = [];
imat12 = [];
umat12 = [];
vmat13 = [];
imat13 = [];

% umat1 = [];
timestamp = -1;

for k = 1:size(matrici, 1)
    riga = matrici(k,:);
    if riga(1) ~= timestamp
        timestamp = riga(1);
    end
    if riga(2) == 2
        i = riga(3);
        j = riga(4);
        v = riga(5);
        u = riga(6);
        corr = riga(8);
        spk = riga(7);
        
        potenziali2(i+1, j+1, timestamp+1) = v;%#ok
        correnti2(i+1, j+1, timestamp+1) = corr;
        vmat2((i+1)*10 + j+1, timestamp+1) = v; %#ok
        umat2((i+1)*10 + j+1, timestamp+1) = u; %#ok
        imat2((i+1)*10 + j+1, timestamp+1) = corr; %#ok
        spike(i+1,j+1,timestamp+1) = spk;
%         if(timestamp+1<=1000)
%             spike(i+1,j+1,timestamp+1) = spk/(timestamp+1); 
%         else
%             spike(i+1,j+1,timestamp+1) = spk/(timestamp+1-1000);
%         end
        
%     elseif riga(2) == 3
%         i = riga(3);
%         j = riga(4);
%         v = riga(5);
%         u = riga(6);
%         corr = riga(8);
%         
%         potenziali3(i+1, j+1, timestamp+1) = v; %#ok
%         vmat3((i+1)*10 + j+1, timestamp+1) = v; %#ok
%         umat3((i+1)*10 + j+1, timestamp+1) = u; %#ok
%         imat3((i+1)*10 + j+1, timestamp+1) = corr; %#ok
%     elseif riga(2) == 4
%         v = riga(5);
%         corr = riga(8);
%         
%         vmat4(timestamp+1) = v; %#ok
%         imat4(timestamp+1) = corr; %#ok
%     elseif ((riga(2) == 5) && (riga(3)==1) && (riga(4)==1))
%         v = riga(5);
%         corr = riga(8);
%         
%         vmat5(timestamp+1) = v; %#ok
%         imat5in(timestamp+1) = corr; %#ok
%     elseif ((riga(2) == 6) && (riga(3)==1) && (riga(4)==1))
%         v = riga(5);
%         corr = riga(8);
%         
%         vmat6(timestamp+1) = v; %#ok
%         imat6in(timestamp+1) = corr; %#ok
%   
%     elseif riga(2) == 12
%         i = riga(3);
%         j = riga(4);
%         v = riga(5);
%         u = riga(6);
%         corr = riga(8);
%        
%         
%         potenziali12(i+1, j+1, timestamp+1) = v; %#ok
%         correnti12(i+1, j+1, timestamp+1) = corr; %#ok
%         vmat12((i+1)*10 + j+1, timestamp+1) = v; %#ok
%         umat12((i+1)*10 + j+1, timestamp+1) = u; %#ok
%         imat12((i+1)*10 + j+1, timestamp+1) = corr; %#ok
%        
%     elseif ((riga(2) == 13) && (riga(3)==9) && (riga(4)==9))  %end neuron segnalatore
%         v = riga(5);
%         corr = riga(8);
%         
%         vmat13(timestamp+1) = v; %#ok
%         imat13(timestamp+1) = corr; %#ok
        
%    elseif ((riga(2) == 13) && (riga(3)==10) && (riga(4)==10)) %Inhibition-Induced Spiking neuron 
%         v = riga(5);
%         corr = riga(8);
%         
%         vmat13(timestamp+1) = v; %#ok
%         imat13(timestamp+1) = corr; %#ok
%         
%     elseif riga(2) == 1
%         i = riga(3);
%         j = riga(4);
%         v = riga(5);
%         u = riga(6);
%         corr = riga(8);
%        
%         
%         potenziali1(i+1, j+1, timestamp+1) = v; %#ok
%         correnti1(i+1, j+1, timestamp+1) = corr;
        %vmat12((i+1)*10 + j+1, timestamp+1) = v; %#ok
        %umat12((i+1)*10 + j+1, timestamp+1) = u; %#ok
        %imat12((i+1)*10 + j+1, timestamp+1) = corr; %#ok
         
        
%     else
%         if riga(1) ~= timestamp
%             timestamp = riga(1);
%         end
%         j = riga(3);
%         i = riga(4);
%         v = riga(5);
%         u = riga(6);
%         corr = riga(8);
%         
%         potenziali1(i+1, j+1, timestamp+1) = v;
%         vmat1((i+1)*10 + j+1, timestamp+1) = v;
%         umat1((i+1)*10 + j+1, timestamp+1) = u;
%         imat1((i+1)*10 + j+1, timestamp+1) = corr;
    end
end

%Rappresentazione dei potenziali layer input1
%  figure
%  set(gcf,'numbertitle','off','name',['input1_sim',num2str(indice+1)]) % See the help for GCF 
%  
%  w=1;
%  for k = 1: 4
%      for n = 1: 4
%          membrane1 = [];
%             for i=1:2000
%             membrane1(i) = potenziali1(k,n,i);
%             end     
%        subplot(4,4,w);
%        w=w+1;
%        plot(membrane1)
%      end
%  end
%   xlabel('step')
%   ylabel('membrane potential [mV]')
%   title('Membrane potentials of the input layer')
 %saveas(gcf,['input1_sim',num2str(indice+1)],'fig');

%Rappresentazione dei potenziali layer SOSL#1
%  figure
%  set(gcf,'numbertitle','off','name',['sosl1p_sim',num2str(indice+1)]) % See the help for GCF 
%  w=1;
%  for k = 9: 9                   %bisogna mettere +1 alle coordinate del cluster da stampare
%      for n = 5: 5
%          membrane2 = [];
%             for i=1:2500
%             membrane2(i) = potenziali2(k,n,i);
%             end     
%        %subplot(9,9,w);
%        w=w+1;
%        plot(membrane2)
%      end
%  end
%   xlabel('step')
%   ylabel('membrane potential [mV]')
%   title('Membrane potential of the central neurons of A')
% % saveas(gcf,['sosl1p_sim',num2str(indice+1)],'fig');
 


%Rappresentazione dei potenziali del contesto
%  figure
%  set(gcf,'numbertitle','off','name',['contesto_sim',num2str(indice+1)]) % See the help for GCF 
%  w=1;
%  for k = 1: 12
%      for n = 1: 12
%          membrane = [];
%             for i=1:2000
%             membrane(i) = correnti12(k,n,i); %correnti12(k,n,i);
%             end     
%        subplot(12,12,w);
%        w=w+1;
%        plot(membrane)
%      end
%  end
%  saveas(gcf,['contesto_sim',num2str(indice+1)],'fig');
 
 %Rappresentazione delle correnti SOSL#1
%  figure
%  set(gcf,'numbertitle','off','name',['spike_sim',num2str(indice+1)]) % See the help for GCF 
%  w=1;
%  for k = 9:9
%      for n = 5:5
%          current = [];
%             for i=1:2500
%             current(i) = correnti2(k,n,i); %potenziali2(k,n,i);
%             end     
%        %subplot(9,9,w);
%        w=w+1;
%        plot(current,'b')
%        hold on
%      end
%  end
%  
%  for k = 5:5
%      for n = 7:7
%          current = [];
%             for i=1:2500
%             current(i) = correnti2(k,n,i); %potenziali2(k,n,i);
%             end     
%        %subplot(9,9,w);
%        w=w+1;
%        plot(current,'r')
%        %hold on
%      end
%  end
%  hold off
% %  xlabel('step')
% %  ylabel('current [pA]')
% %  title('Input current to the central neurons of A and B')
%    xlabel('step')
%    ylabel('spike rate [1/t]')
%    title('Spike rate of neurons A and B')
%    saveas(gcf,['confronto_spikerate_sim',num2str(indice+1)],'fig');
% % saveas(gcf,['confronto_correnti_sim',num2str(indice+1)],'fig');
% % %saveas(gcf,['correnti_sim',num2str(indice+1)],'fig');

% Rappresentazione dello spike rate di un neurone
% start=1;                     %step iniziale 
% finish=2300;                    %step finale
 window=200;                   %grandezza della finestra da graficare
% incremental=1;
% 
% figure
%  set(gcf,'numbertitle','off','name',['spikerate_sim',num2str(indice+1)]) % See the help for GCF 
%  w=1; 
%  membrane2 = [];
%  for k = 9: 9                   %bisogna mettere +1 alle coordinate del cluster da stampare
%      for n = 5: 5
%             for i=start:finish+window
%             membrane2(i) = potenziali2(k,n,i);
%             end     
%        %subplot(9,9,w);
%        %w=w+1;
%        %plot(membrane2)
%      end
%  end
%  spikerate=[];
%  for k=start:incremental:finish
%      count=0;
%      for i=k:k+window
%          if membrane2(i)>10
%              count=count+1;
%          end
%      end
%      spikerate(k)=(count/window)*1000;
% %      spikerate(k+1)=(count/window)*1000;
% %      spikerate(k+2)=(count/window)*1000;
% %      spikerate(k+3)=(count/window)*1000;
% %      spikerate(k+4)=(count/window)*1000;
%  end
%   plot(spikerate);
%   xlabel('step')
%   ylabel('spike rate [1/t]')
%   title('Spike rate of a neuron')
%   
%  figure
%  for k = 9: 9                   %bisogna mettere +1 alle coordinate del cluster da stampare
%      for n = 5: 5
%          spikelist=[];
%             for i=1:2500
%                     if(i<=1000)
%                         spikelist(i) = spike(k,n,i)/(i); 
%                     else
%                         spikelist(i) = spike(k,n,i)/(i-1000);
%                     end
%                 spikelist(i) = spike(k,n,i);
%             end     
%        %subplot(9,9,w);
%        %w=w+1;
%        %plot(membrane2)
%      end
%  end
% 
%  plot(spikelist);
%  xlabel('step')
%  ylabel('spike rate [1/t]')
%  title('Spike rate of a neuron ver. 2')

figure
set(gcf,'numbertitle','off','name',['spikerate_sim',num2str(indice+1)]) % See the help for GCF 
 for k = 9: 9                   %bisogna mettere +1 alle coordinate del cluster da stampare
     for n = 5: 5
         spikelist=[];
            for i=1:2500
                    if(i<=1000)
                        if(i<=window)
                          spikelist(i) = spike(k,n,i)/(window);
                        else
                          spikelist(i)= (spike(k,n,i)-spike(k,n,i-window))/window;
                        end
                    else
                        if(i<=1000+window)
                            spikelist(i) = spike(k,n,i)/(window);
                        else
                            spikelist(i) = (spike(k,n,i)-spike(k,n,i-window))/(window);
                        end
                    end
                %spikelist(i) = spike(k,n,i);
            end     
       %subplot(9,9,w);
       %w=w+1;
       %plot(membrane2)
     end
 end

 plot(spikelist,'b');
 hold on
 
 for k = 5: 5                   %bisogna mettere +1 alle coordinate del cluster da stampare
     for n = 7: 7
         spikelist=[];
            for i=1:2500
                    if(i<=1000)
                        if(i<=window)
                          spikelist(i) = spike(k,n,i)/(window);
                        else
                          spikelist(i)= (spike(k,n,i)-spike(k,n,i-window))/window;
                        end
                    else
                        if(i<=1000+window)
                            spikelist(i) = spike(k,n,i)/(window);
                        else
                            spikelist(i) = (spike(k,n,i)-spike(k,n,i-window))/(window);
                        end
                    end
                %spikelist(i) = spike(k,n,i);
            end     
       %subplot(9,9,w);
       %w=w+1;
       %plot(membrane2)
     end
 end

 plot(spikelist,'r');
 hold off
 
 xlabel('step')
 ylabel('spike rate [1/t]')
 title('Spike rate of A and B')
 %saveas(gcf,['confronto_spikerate_sim',num2str(indice+1)],'fig');
             
 
% Rappresentazione 3D SOSL#1
% sottomat = potenziali2(:,:,end-300:end);
% media = mean(sottomat,3);
% figure
% set(gcf,'numbertitle','off','name',['SOSL#1_sim',num2str(indice+1)]);
% surf(media)
% xlabel('J')
% ylabel('I')
% zlabel('number of spikes')
% title('Activity of the SOSL#1')
% zlabel('membrane potential [mV]')
% title('Secondo layer SOSL#1')
% saveas(gcf,['SOSL1spk_sim',num2str(indice+1)],'fig');
% saveas(gcf,['SOSL#1_sim',num2str(indice+1)],'fig');
% pcolor(media);


%Rappresentazione 3D input1
% sottomat1 = potenziali1(:,:,end-300:end);
% media1 = mean(sottomat1,3);
% figure
% media1 = mean(sottomat1,3);
% surf(media1); figure(gcf);colorbar
% xlabel('J')
% ylabel('I')
% title('Primo layer di input')

%Rappresentazione Reward, Sameness and End Neuron
% figure
%  set(gcf,'numbertitle','off','name',['reward_sim',num2str(indice+1)]) % See the help for GCF 
%  plot(vmat6)
%  xlabel('step')
%  ylabel('membrane potential [mV]')
%  title('Membrane potential of the Reward Neuron')
%  saveas(gcf,['reward_sim',num2str(indice+1)],'fig');
% figure
%  set(gcf,'numbertitle','off','name',['sameness_sim',num2str(indice+1)]) % See the help for GCF 
%  plot(vmat5)
%  xlabel('step')
%  ylabel('membrane potential [mV]')
%  title('Membrane potential of the Sameness Neuron')
 %saveas(gcf,['sameness_sim',num2str(indice+1)],'fig');
% figure
%  set(gcf,'numbertitle','off','name',['end_sim',num2str(indice+1)]) % See the help for GCF 
%  plot(vmat13)
%  xlabel('step')
%  ylabel('membrane potential [mV]')
%  title('Membrane potential of the End Neuron')
%  saveas(gcf,['end_sim',num2str(indice+1)],'fig');


% figure
% if indice > 1
%     sottomat3 = potenziali3(:,:,end-300:end);
%     media3 = mean(sottomat3, 3); %#ok
% end
% sottomat1 = potenziali1(:,:,1200:end);


% for n = 11:99
%     if mod(n,10)==0
%         continue
%     end
%     plot(vmat(n,:))
%     hold all
% end
% title('V secondo layer')

% for n = 11:33
%     if mod(n,10)==0
%         continue
%     end
%     n
%     plot(vmat1(n,:))
%     hold all
% end
% title('V primo layer')
% figure

% figure;plot(vmat(28,:), 'r');hold on;plot(imat(28,:), 'g')
% title('Rosso: V, verde: I')
% figure;plot(vmat1(11,:), 'r');hold on;plot(imat1(11,:), 'g')
% title('Rosso: V, verde: I')
% figure
% plot(imat(97,:), 'g')
% title('Verde: I')

clear potenziali1
clear potenziali2
clear potenziali3
clear matrici
save SLN
clear
end
