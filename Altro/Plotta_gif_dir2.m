function Plotta_gif_dir(indice) 
% ', num2str(indice), '
dati = importdata(['Neurons', num2str(indice), '.txt']);
matrici = dati.data;
clear dati;

start=1;                     %step iniziale 
finish= 1800;%2300;                    %step finale
window=200; %200;                     %grandezza della finestra da graficare
incremental=100;                %spostamento della finestra da un plot all'altro

potenziali1 = [];
potenziali2 = [];
% correnti2 =[];
potenziali3 = [];
potenziali12 = [];

% vmat1 = [];
% imat1 = [];
% vmat2 = [];
% imat2 = [];
% umat2 = [];
% smat2 = zeros(9,9);
% vmat3 = [];
% imat3 = [];
% umat3 = [];
vmat4 = [];
imat4 = [];
% vmat5 = [];
% imat5in = [];
% vmat6 = [];
% imat6in = [];
vmat12 = [];
imat12 = [];
umat12 = [];
% vmat13 = [];
% imat13 = [];

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
%         correnti2(i+1, j+1, timestamp+1) = corr;
%         vmat2((i+1)*10 + j+1, timestamp+1) = v; %#ok
%         umat2((i+1)*10 + j+1, timestamp+1) = u; %#ok
%         imat2((i+1)*10 + j+1, timestamp+1) = corr; %#ok
%         smat2(i+1, j+1) = spk; 
    elseif riga(2) == 3
        i = riga(3);
        j = riga(4);
        v = riga(5);
        u = riga(6);
        corr = riga(8);
        
        potenziali3(i+1, j+1, timestamp+1) = v; %#ok
%         vmat3((i+1)*10 + j+1, timestamp+1) = v; %#ok
%         umat3((i+1)*10 + j+1, timestamp+1) = u; %#ok
%         imat3((i+1)*10 + j+1, timestamp+1) = corr; %#ok
    elseif riga(2) == 1
        i = riga(3);
        j = riga(4);
        v = riga(5);
        u = riga(6);
        corr = riga(8);
       
        
        potenziali1(i+1, j+1, timestamp+1) = v; %#ok
        %correnti1(i+1, j+1, timestamp+1) = corr;
        %vmat12((i+1)*10 + j+1, timestamp+1) = v; %#ok
        %umat12((i+1)*10 + j+1, timestamp+1) = u; %#ok
        %imat12((i+1)*10 + j+1, timestamp+1) = corr; %#ok
     elseif riga(2) == 4
        v = riga(5);
        corr = riga(8);
        
        vmat4(timestamp+1) = v; %#ok
        imat4(timestamp+1) = corr; %#ok
     elseif riga(2) == 12
        i = riga(3);
        j = riga(4);
        v = riga(5);
        u = riga(6);
        corr = riga(8);
       
        
        potenziali12(i+1, j+1, timestamp+1) = v; %#ok
        correnti12(i+1, j+1, timestamp+1) = corr; %#ok
        vmat12((i+1)*10 + j+1, timestamp+1) = v; %#ok
        umat12((i+1)*10 + j+1, timestamp+1) = u; %#ok
        imat12((i+1)*10 + j+1, timestamp+1) = corr; %#ok
        end
end
%% GIF CLUSTER SOSL#1
sottomat = potenziali2(:,:,start:start+window);
%sottomat = potenziali2(:,:,1000:1600);
media = mean(sottomat,3);
figure
surf(media)
axis ([0 9 0 9 -170 -20 -170 -20]);
view(-46,46);
%rotate(h,[1 0 0],50);
xlabel('J')
ylabel('I')
% zlabel('number of spikes')
title('Activity of the SOSL')
zlabel('membrane potential [mV]')
title('Secondo layer SOSL1')
colorbar
set(gca,'nextplot','replacechildren','visible','on');
f= getframe(gcf);
[im, map] =rgb2ind(f.cdata,256,'nodither');
im(1,1,1,length(start:incremental:finish)+1) = 0;
i = 2;
for k=start:incremental:finish
sottomat = potenziali2(:,:,k:(k+window));
%sottomat = potenziali2(:,:,1000:1600);
media = mean(sottomat,3);
surf(media)
view(-46,46);
f= getframe(gcf);
im(:,:,1,i) = rgb2ind(f.cdata,map,'nodither');
 %saveas(gcf,['SOSL1spk_sim',num2str(indice+1)],'fig');
 i = i+1;
end
nameFile = strcat('clustering_AC_SOSL1_',num2str(indice),'.gif');
imwrite(im,map,nameFile,'DelayTime',1,'LoopCount',0)

%% GIF CLUSTER INPUT LAYER
sottomat = potenziali1(:,:,start:start+window);
%sottomat = potenziali2(:,:,1000:1600);
media = mean(sottomat,3);
figure
surf(media)
axis ([0 4 0 4 -170 -20 -170 -20]);
view(-46,46);
%rotate(h,[1 0 0],50);
xlabel('J')
ylabel('I')
% zlabel('number of spikes')
title('Activity of the Input Layer')
zlabel('membrane potential [mV]')
title('Input Layer')
colorbar
set(gca,'nextplot','replacechildren','visible','on');
f= getframe(gcf);
[im, map] =rgb2ind(f.cdata,256,'nodither');
im(1,1,1,length(start:incremental:finish)+1) = 0;
i = 2;
for k=start:incremental:finish
sottomat = potenziali1(:,:,k:(k+window));
%sottomat = potenziali2(:,:,1000:1600);
media = mean(sottomat,3);
surf(media)
view(-46,46);
f= getframe(gcf);
im(:,:,1,i) = rgb2ind(f.cdata,map,'nodither');
 %saveas(gcf,['SOSL1spk_sim',num2str(indice+1)],'fig');
 i = i+1;
end
nameFile = strcat('clustering_Input_Layer_',num2str(indice),'.gif');
imwrite(im,map,nameFile,'DelayTime',1,'LoopCount',0)

% %% GIF CLUSTER SOSL#2
% sottomat = potenziali3(:,:,start:start+window);
% %sottomat = potenziali2(:,:,1000:1600);
% media = mean(sottomat,3);
% figure
% surf(media)
% axis ([0 9 0 9 -170 -20 -170 -20]);
% view(-46,46);
% %rotate(h,[1 0 0],50);
% xlabel('J')
% ylabel('I')
% % zlabel('number of spikes')
% title('Activity of the SOSL2')
% zlabel('membrane potential [mV]')
% title('Secondo layer SOSL2')
% colorbar
% set(gca,'nextplot','replacechildren','visible','on');
% f= getframe(gcf);
% [im, map] =rgb2ind(f.cdata,256,'nodither');
% im(1,1,1,length(start:incremental:finish)+1) = 0;
% i = 2;
% for k=start:incremental:finish
% sottomat = potenziali3(:,:,k:(k+window));
% %sottomat = potenziali2(:,:,1000:1600);
% media = mean(sottomat,3);
% surf(media)
% view(-46,46);
% f= getframe(gcf);
% im(:,:,1,i) = rgb2ind(f.cdata,map,'nodither');
%  %saveas(gcf,['SOSL1spk_sim',num2str(indice+1)],'fig');
%  i = i+1;
% end
% nameFile = strcat('clustering_AC_SOSL2_',num2str(indice),'.gif');
% imwrite(im,map,nameFile,'DelayTime',1,'LoopCount',inf)


%% GIF PREMOTOR NEURON 
% scrsz = get(0,'ScreenSize');                        %ScreenSize is a four-element vector: [left, bottom, width, height]
% figure('Position',[1 1 scrsz(3) scrsz(4)])
%  %set(gcf,'numbertitle','off','name',['input1_sim',num2str(indice+1)]) % See the help for GCF 
% set(gca, 'FontSize', 16)
%        %w=1;
%        membrane1 = [];
%        for i=start:start+window
%           membrane1(i) = vmat4(i);
%        end     
%        %subplot(4,4,w);
%        %w=w+1;
%        plot(membrane1)
%        axis ([start start+window -100 50])
%        xlabel('step')
%        ylabel('membrane potential [mV]')
%        %title('Membrane potentials of the input layer')
% 
% set(gca,'nextplot','replacechildren','visible','on');
% f= getframe(gcf);
% [im, map] =rgb2ind(f.cdata,256,'nodither');
% im(1,1,1,length(start:incremental:finish)+1) = 0;
% t = 2;
% for j=start:incremental:finish
%        membrane1 = [];
%        for i=j:j+window
%           membrane1(i) = vmat4(i);
%        end     
%        plot(membrane1)
%        axis ([j j+window -100 50])
%        xlabel('step')
%        ylabel('membrane potential [mV]')
%        %title('Membrane potentials of the input layer')
% 
% f= getframe(gcf);
% im(:,:,1,t) = rgb2ind(f.cdata,map,'nodither');
%  %saveas(gcf,['SOSL1spk_sim',num2str(indice+1)],'fig');
%  t = t+1;
% end
% nameFile = strcat('AC_Premotor',num2str(indice),'.gif');
% imwrite(im,map,nameFile,'DelayTime',1,'LoopCount',inf)

%%GIF INPUT LAYER
scrsz = get(0,'ScreenSize');                        %ScreenSize is a four-element vector: [left, bottom, width, height]
figure('Position',[1 1 scrsz(3) scrsz(4)])
 %set(gcf,'numbertitle','off','name',['input1_sim',num2str(indice+1)]) % See the help for GCF 
 
 w=1;
 for k = 1: 4
     for n = 1: 4
         membrane1 = [];
            for i=start:start+window
            membrane1(i) = potenziali1(k,n,i);
            end     
       subplot(4,4,w);
       w=w+1;
       plot(membrane1)
       axis ([start start+window -100 50])
       xlabel('step')
       ylabel('membrane potential [mV]')
       %title('Membrane potentials of the input layer')
     end
 end
  
set(gca,'nextplot','replacechildren','visible','on');
f= getframe(gcf);
[im, map] =rgb2ind(f.cdata,256,'nodither');
im(1,1,1,length(start:incremental:finish)+1) = 0;
t = 2;
for j=start:incremental:finish
w=1;
 for k = 1: 4
     for n = 1: 4
         membrane1 = [];
            for i=j:j+window
            membrane1(i) = potenziali1(k,n,i);
            end     
       subplot(4,4,w);
       w=w+1;
       plot(membrane1)
       axis ([j j+window -100 50])
       xlabel('step')
       ylabel('membrane potential [mV]')
       %title('Membrane potentials of the input layer')
     end
 end
f= getframe(gcf);
im(:,:,1,t) = rgb2ind(f.cdata,map,'nodither');
 %saveas(gcf,['SOSL1spk_sim',num2str(indice+1)],'fig');
 t = t+1;
end
nameFile = strcat('AC_inputLayer',num2str(indice),'.gif');
imwrite(im,map,nameFile,'DelayTime',1,'LoopCount',0)
% 
% %%GIF SOSL Membrane Potential LAYER
% scrsz = get(0,'ScreenSize');                        %ScreenSize is a four-element vector: [left, bottom, width, height]
% figure('Position',[1 1 scrsz(3) scrsz(4)])
%  %set(gcf,'numbertitle','off','name',['input1_sim',num2str(indice+1)]) % See the help for GCF 
%  
%  w=1;
%  for k = 1: 9
%      for n = 1: 9
%          membrane2 = [];
%             for i=start:start+window
%             membrane2(i) = potenziali2(k,n,i);
%             end     
%        subplot(9,9,w);
%        w=w+1;
%        plot(membrane2)
%        axis ([start start+window -100 50])
%        xlabel('step')
%        %ylabel('membrane potential [mV]')
%        %title('Membrane potentials of the input layer')
%      end
%  end
%   
% set(gca,'nextplot','replacechildren','visible','on');
% f= getframe(gcf);
% [im, map] =rgb2ind(f.cdata,256,'nodither');
% im(1,1,1,length(start:incremental:finish)+1) = 0;
% t = 2;
% for j=start:incremental:finish
% w=1;
%  for k = 1: 9
%      for n = 1: 9
%          membrane2 = [];
%             for i=j:j+window
%             membrane2(i) = potenziali2(k,n,i);
%             end     
%        subplot(9,9,w);
%        w=w+1;
%        plot(membrane2)
%        axis ([j j+window -100 50])
%        xlabel('step')
%        %ylabel('membrane potential [mV]')
%        %title('Membrane potentials of the input layer')
%      end
%  end
% f= getframe(gcf);
% im(:,:,1,t) = rgb2ind(f.cdata,map,'nodither');
%  %saveas(gcf,['SOSL1spk_sim',num2str(indice+1)],'fig');
%  t = t+1;
% end
% nameFile = strcat('AC_Sosl_membrane',num2str(indice),'.gif');
% imwrite(im,map,nameFile,'DelayTime',1,'LoopCount',inf)

%% GIF CLUSTER CONTEXT LAYER
sottomat = potenziali12(:,:,start:start+window);
%sottomat = potenziali2(:,:,1000:1600);
media = mean(sottomat,3);
figure
surf(media)
axis ([0 12 0 12 -170 -20 -170 -20]);
view(-46,46);
%rotate(h,[1 0 0],50);
xlabel('J')
ylabel('I')
% zlabel('number of spikes')
title('Activity of the Context Layer')
zlabel('membrane potential [mV]')
title('Context Layer')
colorbar
set(gca,'nextplot','replacechildren','visible','on');
f= getframe(gcf);
[im, map] =rgb2ind(f.cdata,256,'nodither');
im(1,1,1,length(start:incremental:finish)+1) = 0;
i = 2;
for k=start:incremental:finish
sottomat = potenziali12(:,:,k:(k+window));
%sottomat = potenziali2(:,:,1000:1600);
media = mean(sottomat,3);
surf(media)
view(-46,46);
f= getframe(gcf);
im(:,:,1,i) = rgb2ind(f.cdata,map,'nodither');
 %saveas(gcf,['SOSL1spk_sim',num2str(indice+1)],'fig');
 i = i+1;
end
nameFile = strcat('clustering_Context_',num2str(indice),'.gif');
imwrite(im,map,nameFile,'DelayTime',1,'LoopCount',1)

% %%GIF CONTEXT LAYER Membrane Potential LAYER
% scrsz = get(0,'ScreenSize');                        %ScreenSize is a four-element vector: [left, bottom, width, height]
% figure('Position',[1 1 scrsz(3) scrsz(4)])
%  %set(gcf,'numbertitle','off','name',['input1_sim',num2str(indice+1)]) % See the help for GCF 
%  
%  w=1;
%  for k = 1: 12
%      for n = 1: 12
%          membrane12 = [];
%             for i=start:start+window
%             membrane12(i) = potenziali12(k,n,i);
%             end     
%        subplot(12,12,w);
%        w=w+1;
%        plot(membrane12)
%        axis ([start start+window -100 50])
%        xlabel('step')
%        %ylabel('membrane potential [mV]')
%        %title('Membrane potentials of the input layer')
%      end
%  end
%   
% set(gca,'nextplot','replacechildren','visible','on');
% f= getframe(gcf);
% [im, map] =rgb2ind(f.cdata,256,'nodither');
% im(1,1,1,length(start:incremental:finish)+1) = 0;
% t = 2;
% for j=start:incremental:finish
% w=1;
%  for k = 1: 12
%      for n = 1: 12
%          membrane12 = [];
%             for i=j:j+window
%             membrane12(i) = potenziali12(k,n,i);
%             end     
%        subplot(12,12,w);
%        w=w+1;
%        plot(membrane12)
%        axis ([j j+window -100 50])
%        xlabel('step')
%        %ylabel('membrane potential [mV]')
%        %title('Membrane potentials of the input layer')
%      end
%  end
% f= getframe(gcf);
% im(:,:,1,t) = rgb2ind(f.cdata,map,'nodither');
%  %saveas(gcf,['SOSL1spk_sim',num2str(indice+1)],'fig');
%  t = t+1;
% end
% nameFile = strcat('AC_Context_membrane',num2str(indice),'.gif');
% imwrite(im,map,nameFile,'DelayTime',1,'LoopCount',inf)



