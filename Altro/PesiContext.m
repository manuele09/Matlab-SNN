dati=importdata('Dati\SynapseSTDP8.txt');
data=dati.data;

k=1;
info=[];
infoInput=[];
infoEnd=[];
for i=1:size(data,1)
    if(data(i,2)==16 && data(i,5)==16 && data(i,6)<3)  %STDP contesto, se metto <3 escludo gli end se metto <=3 includo gli end
       info(data(i,4)+1,data(i,7)+1,data(i,1))=data(i,8);
    elseif (data(i,2)==1 && data(i,5)==1)              %STDP input, 
        infoInput(data(i,3)*4+data(i,4)+1, data(i,6)*4+data(i,7)+1,data(i,1)+1)=data(i,8);
    elseif(data(i,2)==16 && data(i,5)==16 && data(i,6)==3)  %STDP contesto, se metto <3 escludo gli end se metto <=3 includo gli end
       infoEnd(data(i,4)+1,data(i,7)+1,data(i,1))=data(i,8);
    end
end

figure
title('Context');
for i=1:size(info,1)
    for j=1:size(info,2)
        hold on
        plot(squeeze(info(i,j,:)));
    end
end

figure
title('End');
for i=1:size(infoEnd,1)
    for j=1:size(infoEnd,2)
        hold on
        plot(squeeze(infoEnd(i,j,:)));
    end
end

figure
title('Input');
for i=1:size(infoInput,1)
    for j=1:size(infoInput,2)
        hold on
        plot(squeeze(infoInput(i,j,:)));
    end
end

clear all
