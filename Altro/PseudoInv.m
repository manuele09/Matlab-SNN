function PseudoInv (indice) 
% ', num2str(indice), '
dati = importdata(['Neurons', num2str(indice),'.txt']);
matrici = dati.data;
clear dati;

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
    elseif riga(2) == 6
        i = riga(3);
        j = riga(4);
        if i == 1 && j==1
        v = riga(5);
        corr = riga(8);
        
        vmat6(timestamp+1) = v; %#ok
        imat6in(timestamp+1) = corr; %#ok
        end
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
%        
%     elseif riga(2) == 13
%         v = riga(5);
%         corr = riga(8);
%         
%         vmat13(timestamp+1) = v; %#ok
%         imat13(timestamp+1) = corr; %#ok
%         
    elseif riga(2) == 1
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
    elseif riga(2) == 14
        i = riga(3);
        j = riga(4);
        u = riga(6);
        v = riga(5);
        corr = riga(8);
        I_out = riga(9);
        
        if i == 100 && j==100       
            vmat14(timestamp+1) = v; %#ok
            imat14(timestamp+1) = corr; %#ok
        else       
            potenziali15(i+1, j+1, timestamp+1) = v; %#ok
            correnti15(i+1, j+1, timestamp+1) = corr; %#ok
            vmat15((i+1)*10 + j+1, timestamp+1) = v; %#ok
            umat15((i+1)*10 + j+1, timestamp+1) = u; %#ok
            imat15((i+1)*10 + j+1, timestamp+1) = corr; %#ok
            i_Out(i+1, j+1, timestamp+1) = I_out; %#ok
        end
    end
end

k=1;
for i = 1:8
    for j=1:8
        Z(k,:)= i_Out(i,j,101:1100);
        k=k+1;
    end
end

target0=load(['target',num2str(indice),'-0.txt']);

target = target0(:,1);

Z=Z';

inv=pinv(Z);
W = pinv(Z)*target;

savefile = 'W.mat';
save(savefile, 'W')
save W.txt W -ASCII


% filename='W';
% [fid]=fopen(filename, 'w');
% cont=fwrite(fid,W,'float64');
% fclose(fid);


t6= Z(7,:).*W';
savefile = 't6.mat';
save(savefile, 't6')

t=Z*W;
savefile = 't.mat';
save(savefile, 't')

figure
plot(t)
hold on
plot(target)


