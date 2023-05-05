function Plot_Liquid_Input_Morris (indice) 
%Plotta un po di tutto: le tensioni e le correnti di uscita del liquido e
%dell'input layer.
%Le tensioni del neurone di Morris Lecar e del neurone somma
%corrispondente.
% ', num2str(indice), '
%plotta una serie di cose riguardo al liquid
dati = importdata(['../Dati/Neurons', num2str(indice),'.txt']);
%dati = importdata('Dati\Neurons0-0.txt');
matrici = dati.data;
clear dati;

dati2 = importdata(['../Dati/NeuronMorrisLecar', num2str(indice),'.txt']);
%dati2 = importdata('Dati\NeuronMorrisLecar0-0.txt');
matrici2 = dati2.data;
clear dati;

numberSteps=1100;

potenziali1 = [];
potenziali2 = [];
correnti1 =[];
correnti2 =[];
correnti12 =[];
potenziali3 = [];
potenziali12 = [];

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
vmat14 = [];
imat14 = [];
vmat15 = [];
imat15 = [];

% umat1 = [];
timestamp = -1;

for k = 1:size(matrici, 1)
    riga = matrici(k,:);
    if riga(1) ~= timestamp
        timestamp = riga(1);
    end
    if riga(2) == 2     %SOSL1
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
        smat2(i+1, j+1) = spk; 
%     elseif riga(2) == 3 %SOSL2
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
%     elseif riga(2) == 5
%         v = riga(5);
%         corr = riga(8);
%         
%         vmat5(timestamp+1) = v; %#ok
%         imat5in(timestamp+1) = corr; %#ok
%     elseif riga(2) == 6     %Reward
%         i = riga(3);
%         j = riga(4);
%         if i == 1 && j==1
%         v = riga(5);
%         corr = riga(8);
%         
%         vmat6(timestamp+1) = v; %#ok
%         imat6in(timestamp+1) = corr; %#ok
%         end
%     elseif riga(2) == 12    %SOSL3
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
% %        
%     elseif riga(2) == 13
%         v = riga(5);
%         corr = riga(8);
%         
%         vmat13(timestamp+1) = v; %#ok
%         imat13(timestamp+1) = corr; %#ok
%         
    elseif riga(2) == 1     %FirstLayer1
        i = riga(3);
        j = riga(4);
        v = riga(5);
        u = riga(6);
        corr = riga(8);
       
        
        potenziali1(i+1, j+1, timestamp+1) = v; %#ok
        correnti1(i+1, j+1, timestamp+1) = corr;
        vmat12((i+1)*10 + j+1, timestamp+1) = v; %#ok
        umat12((i+1)*10 + j+1, timestamp+1) = u; %#ok
        imat12((i+1)*10 + j+1, timestamp+1) = corr; %#ok
         
        
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
    elseif riga(2) == 14    %Liquid State
        i = riga(3);
        j = riga(4);
        u = riga(6);
        v = riga(5);
        corr = riga(8);
        I_out = riga(9);
        
%         if i == 100 && j==100       
%             vmat14(timestamp+1) = v; %#ok
%             imat14(timestamp+1) = corr; %#ok
%         else       
            potenziali14(i+1, j+1, timestamp+1) = v; %#ok
            correnti14(i+1, j+1, timestamp+1) = corr; %#ok
            vmat14((i+1)*10 + j+1, timestamp+1) = v; %#ok
            umat14((i+1)*10 + j+1, timestamp+1) = u; %#ok
            imat14((i+1)*10 + j+1, timestamp+1) = corr; %#ok
            i_Out14(i+1, j+1, timestamp+1) = I_out; %#ok
     
    elseif riga(2) == 15    %Output Layer
        i = riga(3);
        j = riga(4);
%         u = riga(6);
        v = riga(5);
%         corr = riga(8);
%         I_out = riga(9);
%         I_tot = riga(10);
            
            potenziali15(i+1, j+1, timestamp+1) = v; %#ok
%             correnti15(i+1, j+1, timestamp+1) = corr; %#ok
%             vmat15((i+1) , j+1, timestamp+1) = v; %#ok
%             umat15((i+1)*10 + j+1, timestamp+1) = u; %#ok
%             imat15((i+1),j+1, timestamp+1) = corr; %#ok
%             i_Out15(i+1, j+1, timestamp+1) = I_out; %#ok
%             i_Tot15(i+1, j+1, timestamp+1) = I_tot; %#ok
     
    end
end


for k = 1:size(matrici2, 1)
    riga = matrici2(k,:);
    if riga(1) ~= timestamp
        timestamp = riga(1);
    end

    if riga(2) == 15    %Output Layer - Morris Lecar 
        i = riga(3)-1;
        j = riga(4);
        u = riga(6);
        v = riga(5);
        corr = riga(8);
        I_out = riga(9);
        I_tot = riga(10);
            
            potenziali15_ML(i+1, j+1, timestamp+1) = v; %#ok
            correnti15_ML(i+1, j+1, timestamp+1) = corr; %#ok
            vmat15_ML((i+1) , j+1, timestamp+1) = v; %#ok
            umat15_ML((i+1)*10 + j+1, timestamp+1) = u; %#ok
            imat15_ML((i+1),j+1, timestamp+1) = corr; %#ok
            i_Out15_ML(i+1, j+1, timestamp+1) = I_out; %#ok
            i_Tot15_ML(i+1, j+1, timestamp+1) = I_tot; %#ok
    end
end


%Rappresentazione del potenziali e delle correnti del REWARD neuron
%  figure
%  set(gcf,'numbertitle','off','name',['Reward1_sim',num2str(indice+1)]) % See the help for GCF 
%   plot(vmat6)  
%   xlabel('step')
%   ylabel('membrane potential [mV]')
%   title('Membrane potentials of the Reward neuron')
%  saveas(gcf,['Reward_Potential_sim',num2str(indice+1)],'fig');
% 
%   figure
%  set(gcf,'numbertitle','off','name',['Reward1_sim',num2str(indice+1)]) % See the help for GCF 
%  plot(imat6in) 
%   xlabel('step')
%   ylabel('Current [pA]')
%   title('Current of the Reward neuron')
%  saveas(gcf,['Reward_Current_sim',num2str(indice+1)],'fig');




%%Rappresentazione dei potenziali layer SOSL#1
%  figure
%  set(gcf,'numbertitle','off','name',['sosl1p_sim',num2str(indice+1)]) % See the help for GCF 
%  w=1;
%  for k = 5: 5
%      for n = 7: 7
%          membrane2 = [];
%          current2 = [];
%             for i=1:2500
%             %membrane2(i) = potenziali2(k,n,i);
%             current2(i) = correnti2(k,n,i);
%             end     
%        %subplot(9,9,w);
%        w=w+1;
%        %plot(membrane2)
%        plot(current2)
%        axis([0 2500 0 700])
%      end
%  end
%   xlabel('step')
%   %ylabel('membrane potential [mV]')
%   ylabel('current [pA]')
%   %title('Membrane potential of the central neurons of A')
%   title('Current of the central neurons of A')
%  saveas(gcf,['sosl1p_sim',num2str(indice+1)],'fig');
%  
% 
% 
% %Rappresentazione dei potenziali del contesto
%  figure
%  set(gcf,'numbertitle','off','name',['contesto_sim',num2str(indice+1)]) % See the help for GCF 
%  w=1;
%  for k = 1: 12 %12
%      for n = 1 : 12 
%          membrane = [];
%          current = [];
%             for i=1:2000
%             membrane(i) = potenziali12(k,n,i);
%             current(i) = correnti12(k,n,i);
%             end     
%        subplot(12,12,w);
%        %subplot(1,3,w);
%        w=w+1;
%        %plot(membrane)
%        plot(current)
%      end
%  end
%  saveas(gcf,['contesto_sim',num2str(indice+1)],'fig');
 
 %Rappresentazione delle correnti SOSL#1
%  figure
%  set(gcf,'numbertitle','off','name',['correnti_sim',num2str(indice+1)]) % See the help for GCF 
%  w=1;
%  for k = 1:1
%      for n = 2:2
%          current = [];
%             for i=1:2500
%             current(i) = correnti1(k,n,i);
%             end     
%        %subplot(9,9,w);
%        w=w+1;
%        plot(current,'b')
%        hold on
%      end
%  end
%  
%  for k = 1:1
%      for n = 4:4
%          current = [];
%             for i=1:2500
%             current(i) = correnti1(k,n,i);
%             end     
%        %subplot(9,9,w);
%        w=w+1;
%        plot(current,'r')
%        %hold on
%      end
%  end
%  hold off
%  xlabel('step')
%  ylabel('current [pA]')
%  title('Input current to the central neurons of A and B')
%  %saveas(gcf,['confronto_correnti_sim',num2str(indice+1)],'fig');
% %saveas(gcf,['correnti_sim',num2str(indice+1)],'fig');


% Rappresentazione 3D SOSL#1
% sottomat = potenziali2(:,:,end-300:end);
% media = mean(sottomat,3);
% figure
% %set(gcf,'numbertitle','off','name',['SOSL#1_sim',num2str(indice+1)]);
% surf(media)
% figure(gcf);colorbar
% view(2)
% h=get(gcf,'CurrentAxes');
% set(h,'FontSize',16);
% axis ([1 9 1 9 -170 0 -170 0]);
% xlabel('J')
% ylabel('I')
% % zlabel('number of spikes')
% % title('Activity of the SOSL#1')
% zlabel('membrane potential [mV]')
% title('\alpha / \beta lobes')
% %saveas(gcf,['SOSL1spk_sim',num2str(indice+1)],'fig');
% saveas(gcf,['SOSL#1_sim',num2str(indice+1)],'fig');
% %pcolor(media);
% 
% 
% %Rappresentazione 3D input1
% sottomat1 = potenziali1(:,:,end-300:end);
% media1 = mean(sottomat1,3);
% figure
% surf(media1); figure(gcf);colorbar
% view(2)
% h=get(gcf,'CurrentAxes');
% set(h,'FontSize',16);
% axis ([1 4 1 4 -170 -20 -170 -20]);
% xlabel('J')
% ylabel('I')
% zlabel('membrane potential [mV]')
% title('Antennal Lobe');
% saveas(gcf,['InputLayer_sim',num2str(indice+1)],'fig');
% 
% %%rappresentazione 3D Context Layer
% sottomat = potenziali12(:,:,end-300:end);
% %sottomat = potenziali2(:,:,1000:1600);
% media = mean(sottomat,3);
% figure
% surf(media)
% colorbar
% h=get(gcf,'CurrentAxes');
% set(h,'FontSize',16);
% axis ([1 12 1 12 -170 -20 -170 -20]);
% %rotate(h,[1 0 0],50);
% xlabel('J')
% ylabel('I')
% view(2)
% % zlabel('number of spikes')
% title('Activity of the Context Layer')
% zlabel('membrane potential [mV]')
% title('Context Layer')
% saveas(gcf,['ContextLayer_sim',num2str(indice+1)],'fig');



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

%% Plot Persistance neuron
 figure
 subtitle('Persistance Neuron')
  w=1;
 for k = 1: size(potenziali15, 2)
         membrane15 = [];
            for i=1:numberSteps
            membrane15(i) = potenziali15(3,k,i);
            end     
       subplot(size(potenziali15, 2),1,w);
       w=w+1;
        plot(membrane15, 'b');
       %axis([0,numberSteps,0,2000]);
 end
 
 %% Plot Sameness neuron
 figure
 subtitle('Sameness Neuron')
  w=1;
 for k = 1: size(potenziali15, 2)
         membrane15 = [];
            for i=1:numberSteps
            membrane15(i) = potenziali15(4,k,i);
            end     
       subplot(size(potenziali15, 2),1,w);
       w=w+1;
        plot(membrane15, 'b');
       %axis([0,numberSteps,0,2000]);
 end

%% Rappresentazione del potenziali e delle correnti dell'output neuron
%  figure
%   title('Current of the Output Neuron - Liquid State')
%  set(gcf,'numbertitle','off','name',['Membrane_out_sim',num2str(indice+1)]) % See the help for GCF 
%   plot(vmat14)  
%   xlabel('step')
%   ylabel('membrane potential [mV]')
%   title('Membrane potentials of the Output Neuron - Liquid State')
 %saveas(gcf,['Out_Potential_sim',num2str(indice+1)],'fig');

 
%   figure
%  set(gcf,'numbertitle','off','name',['Current_with_target_sim',num2str(indice+1)]) % See the help for GCF 
%  if nargin==1
%     target = importdata(['Dati\target', num2str(indice),'.txt']);
%  else
%     target = importdata(['Dati\target', num2str(indice),'-',num2str(indiceInt),'.txt']);
%  end
%  plot(target(:,1), 'b')
%  hold on
%  plot(target(:,2), 'r')
 
 
%  hold on
%  plot(imat14,'y')
 
 savefile = 'iOut.mat';
save(savefile, 'imat14')
 
%   xlabel('step')
%   ylabel('Current [pA]')
%   legend('target', 'error')
%  
%  saveas(gcf,['Out_Current_Comparison_sim',num2str(indice+1)],'fig');
 
%% Neuron Morris-Lecar
 figure
 w=1;
 dim=size(potenziali15_ML);
     for j=1:dim(1,2)
     subplot(dim(1,2),1,w);
      w=w+1;     
     %hold on 
     plot(squeeze(potenziali15_ML(1,j,:)));
      xlabel('step')
     ylabel('Membrane Potential [mV]')
     axis([0,numberSteps,-100,80]);
     end
 subtitle('Neuron Morris-Lecar');   
     
%  figure
%  w=1;
%  dim=size(correnti15_ML);
%      for j=1:dim(1,2)
%      subplot(dim(1,2),1,w);
%       w=w+1;     
%      %hold on 
%      plot(squeeze(correnti15_ML(1,j,:)));
%       xlabel('step')
%      ylabel('Current [pA]')
%      axis([0,numberSteps,-100,80]);
%      end
%  subtitle('Neuron Morris-Lecar');  
 
 %% Sum-Neuron    
 figure
 dim=size(potenziali15);
 
 savefile = 'i_sum.mat';
save(savefile, 'potenziali15')

w=1;
 %for i=1:dim(1,1)
     for j=1:dim(1,2)
      subplot(dim(1,2),1,w);
      w=w+1;   
     %hold on 
     plot(squeeze(potenziali15(1,j,:)));
     xlabel('step')
     ylabel('Membrane Potential [mV]')
     %axis([0,numberSteps,-0.015,0.015]);
     axis tight
     end
 %end
 subtitle('Sum-Neuron')
  
 %if nargin ==1
     
 %% Rappresentazione delle correnti Liquid State
 figure
 set(gcf,'numbertitle','off','name',['current_Liquid_sim',num2str(indice+1)]) % See the help for GCF 
 xlabel('step')
  ylabel('current [pA]')
  subtitle('Input current of the Liquid State')
  load('../Dati/EI.txt');
  input=load('../Dati/Input_connection.txt');
  %input=load(['Input_active_',num2str(indice),'.txt']);
  input_sort=sortrows(input);
  input=unique(input_sort,'rows');
  s=size(input);
  
 w=1;
 j=1;
 for k = 1: 8
     for n = 1: 8
         current14 = [];
            for i=1:numberSteps
            current14(i) = correnti14(k,n,i);
            end     
       subplot(8,8,w);
       w=w+1;
       if EI((k-1)*8 +n, 2)== 0 
           if input(j,1)==k && input(j,2)==n
                plot(current14, 'r--')
                if j < s(1)
                    j=j+1;
                end
           else
              plot(current14, 'r')
           end
       else
           if input(j,1)==k && input(j,2)==n
                plot(current14, 'b--')
                if j < s(1)
                    j=j+1;
                end
           else
              plot(current14, 'b')
           end         
       end
       %axis([0,numberSteps,0,100]);
       axis tight
       %plot(current14)
     end
 end
  
 
 saveas(gcf,['Liquid_sim',num2str(indice+1)],'fig');
 
 
 %% Rappresentazione delle correnti di OUTPUT della Liquid State
 figure
 set(gcf,'numbertitle','off','name',['current_OUT_Liquid_sim',num2str(indice+1)]) % See the help for GCF 
 axis([-5 5 0 100]);
 
 j=1;
 w=1;
 for k = 1: 8
     for n = 1: 8
         current14 = [];
            for i=1:numberSteps
            current14(i) = i_Out14(k,n,i);
            end     
       subplot(8,8,w);
       w=w+1;
       
       if EI((k-1)*8 +n, 2)== 0
           if input(j,1)==k && input(j,2)==n
                plot(current14, 'r--')
                if j < s(1)
                    j=j+1;
                end
           else
                plot(current14, 'r')
           end
       else
           if input(j,1)==k && input(j,2)==n
                plot(current14, 'b--')
                if j < s(1)
                    j=j+1;
                end
           else
                plot(current14, 'b')
           end
       end
       axis([0,numberSteps,0,20]);
       %plot(current14)
       %axis([0 100 0 1.5]);
     end
 end
 
%   xlabel('step')
%   ylabel('current [pA]')
  subtitle('Output current of the Liquid State')
 
 saveas(gcf,['Liquid_sim_out_current',num2str(indice+1)],'fig');
 
 
 %% Rappresentazione del potenziale della Liquid State
 figure
 set(gcf,'numbertitle','off','name',['Potential_liquid_sim',num2str(indice+1)]) % See the help for GCF 
 
 %j=1;
 w=1;
 for k = 1: 8
     for n = 1: 8
         membrane14 = [];
            for i=1:numberSteps
            membrane14(i) = potenziali14(k,n,i);
            end     
       subplot(8,8,w);
       w=w+1;
       
       if EI((k-1)*8 +n, 2)== 0
%            if input(j,1)==k && input(j,2)==n
%                 plot(membrane14, 'r--')
%                 j=j+1;
%            else
                plot(membrane14, 'r')
           %end
       else
%            if input(j,1)==k && input(j,2)==n
%                 plot(membrane14, 'b--')
%                 j=j+1;
%            else
                plot(membrane14, 'b')
           %end
       end
       axis([0,numberSteps,-100,100]);
       %plot(membrane14)
     end
 end
%   xlabel('step')
%    ylabel('membrane potential [mV]')
  subtitle('Membrane potentials of the Liquid State')
  
 %saveas(gcf,['Liquid_current_sim',num2str(indice+1)],'fig');
 
 %% Rappresentazione dei potenziali layer input1
 figure
 set(gcf,'numbertitle','off','name',['input1_sim',num2str(indice+1)]) % See the help for GCF 
 
 w=1;
 for k = 1: 4
     for n = 1: 4
         membrane1 = [];
            for i=1:numberSteps
            membrane1(i) = potenziali1(k,n,i);
            end     
       subplot(4,4,w);
       w=w+1;
       plot(membrane1)
       axis([0,numberSteps,-100,80]);
     end
 end
  xlabel('step')
  ylabel('membrane potential [mV]')
  subtitle('Membrane potentials of the Input Layer')
 saveas(gcf,['input1_sim',num2str(indice+1)],'fig');
 %end

 
clear potenziali1
clear potenziali2
clear potenziali3
clear matrici
save SLN
clear
end
