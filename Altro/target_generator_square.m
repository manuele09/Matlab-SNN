    target=[];

k= [61.5 61.2 60.8 60.5];
f=[ 5 10 15 20];
n=1000;  %numero di step eseguiti durante la fase liquid
for j=0:3
    target=[];
for i=0:999

%target sinusoidale
target(i+1)=sin((i*2*pi*(f(j+1)*0.001))/1)/100;
%target a onda quadra
if target(i+1)>0
    target(i+1)=k(j+1);
    target(i+1+n)=k(j+1);
    target(i+1+2*n)=k(j+1);
else
    target(i+1)=-k(j+1);
    target(i+1+n)=-k(j+1);
    target(i+1+2*n)=-k(j+1);
end

end
target=target';

switch j
    case 0
save target_default_0.txt target -ASCII;

    case 1
save target_default_1.txt target -ASCII;

    case 2   
save target_default_2.txt target -ASCII;

    case 3
save target_default_3.txt target -ASCII;

end
end