function [media] = PlottaPrimo (indice) 

dati = importdata(['Dati/Neurons', num2str(indice), '.txt']);
matrici = dati.data;
clear dati;

% potenziali1 = [];
potenziali2 = [];
% vmat1 = [];
% imat1 = [];
vmat = [];
imat = [];
umat = [];
% umat1 = [];
timestamp = -1;

for k = 1:size(matrici, 1)
    riga = matrici(k,:);
    if riga(2) == 1
        if riga(1) ~= timestamp
            timestamp = riga(1);
        end
        i = riga(3);
        j = riga(4);
        v = riga(5);
        u = riga(6);
        corr = riga(8);
        
        potenziali2(i+1, j+1, timestamp+1) = v; %#ok<*SAGROW>
        vmat((i+1)*10 + j+1, timestamp+1) = v;
        umat((i+1)*10 + j+1, timestamp+1) = u;
        imat((i+1)*10 + j+1, timestamp+1) = corr;
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

sottomat = potenziali2(:,:,end-300:end);
% sottomat1 = potenziali1(:,:,1200:end);
% clear potenziali1
clear potenziali2

media = mean(sottomat,3);
surf(media); figure(gcf);colorbar
xlabel('J')
ylabel('I')
title('Primo layer')
% figure

% media1 = mean(sottomat1,3);
% surf(media1); figure(gcf);colorbar
% xlabel('J')
% ylabel('I')
% title('Primo layer')
% figure

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

save SLN

end
