function Zcomparison(indice) 
% ', num2str(indice), '
Z1=[];
Z2=[];
for z=0:5
dati = importdata(['Dati\Neurons', num2str(indice+z),'.txt']);
matrici = dati.data;
clear dati;

timestamp = -1;

result=[];
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

if(z==0)
k=1;
for i = 1:8
    for j=1:8
        Z1(k,:)= i_Out(i,j,:);
        k=k+1;
    end
end
end

if(z==5)
k=1;
for i = 1:8
    for j=1:8
        Z2(k,:)= i_Out(i,j,:);
        k=k+1;
    end
end
end

end

figure
hold on
for k=1:64
    result(k,:)=(Z1(k,:)-Z2(k,:));
    plot(result(k,:));
end




end
