function Plotta1 (indice) 
% 
dati = importdata(['Dati/Neurons', num2str(indice), '.txt']);
matrici = dati.data;
clear dati;

potenziali1 = [];
potenziali2 = [];
potenziali3 = [];
vmat1 = [];
imat1 = [];
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
umat1 = [];
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
        
        potenziali2(i+1, j+1, timestamp+1) = v; %#ok
        vmat2((i+1)*10 + j+1, timestamp+1) = v; %#ok
        umat2((i+1)*10 + j+1, timestamp+1) = u; %#ok
        imat2((i+1)*10 + j+1, timestamp+1) = corr; %#ok
        smat2(i+1, j+1) = spk; 
    elseif riga(2) == 3
        i = riga(3);
        j = riga(4);
        v = riga(5);
        u = riga(6);
        corr = riga(8);
        
        potenziali3(i+1, j+1, timestamp+1) = v; %#ok
        vmat3((i+1)*10 + j+1, timestamp+1) = v; %#ok
        umat3((i+1)*10 + j+1, timestamp+1) = u; %#ok
        imat3((i+1)*10 + j+1, timestamp+1) = corr; %#ok
    elseif riga(2) == 4
        v = riga(5);
        corr = riga(8);
        
        vmat4(timestamp+1) = v; %#ok
        imat4(timestamp+1) = corr; %#ok
    elseif riga(2) == 5
        v = riga(5);
        corr = riga(8);
        
        vmat5(timestamp+1) = v; %#ok
        imat5in(timestamp+1) = corr; %#ok
    elseif riga(2) == 6
        v = riga(5);
        corr = riga(8);
        
        vmat6(timestamp+1) = v; %#ok
        imat6in(timestamp+1) = corr; %#ok
     else
         if riga(1) ~= timestamp
             timestamp = riga(1);
         end
         j = riga(3);
         i = riga(4);
         v = riga(5);
         u = riga(6);
         corr = riga(8);
         
         potenziali1(i+1, j+1, timestamp+1) = v;
         vmat1((i+1)*10 + j+1, timestamp+1) = v;
         umat1((i+1)*10 + j+1, timestamp+1) = u;
         imat1((i+1)*10 + j+1, timestamp+1) = corr;
    end
end

sottomat = potenziali2(:,:,end-300:end);
media = mean(sottomat,3);

 if indice > 1
     sottomat3 = potenziali3(:,:,end-300:end);
     media3 = mean(sottomat3, 3); %#ok
 end
 sottomat1 = potenziali1(:,:,1200:end);
 clear potenziali1
clear potenziali2
clear potenziali3

figure
surf(smat2)
 pcolor(media);
xlabel('J')
ylabel('I')
title('Secondo layer')
 figure

 media1 = mean(sottomat1,3);
 surf(media1); figure(gcf);colorbar
 xlabel('J')
 ylabel('I')
 title('Primo layer')
 figure

 for n = 11:99
     if mod(n,10)==0
continue
end
     plot(vmat(n,:))
     hold all
 end
 title('V secondo layer')

 for n = 11:33
     if mod(n,10)==0
         continue
     end
     n
     plot(vmat1(n,:))
     hold all
 end
 title('V primo layer')
 figure

 figure;plot(vmat(28,:), 'r');hold on;plot(imat(28,:), 'g')
 title('Rosso: V, verde: I')
 figure;plot(vmat1(11,:), 'r');hold on;plot(imat1(11,:), 'g')
 title('Rosso: V, verde: I')
 figure
 plot(imat(97,:), 'g')
 title('Verde: I')

clear matrici
save SLN
clear
end
