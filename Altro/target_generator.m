%genera dei target sinusoidali e li salva in target_default_i.txt

 
target=[];

f=[15, 20, 25, 30];
%k= [61.5 61.45 61.35 61.2 60.8 60.5];
%f=[ 5 10 15 20 25 30];
n=1000;  %numero di step eseguiti durante la fase liquid
for j=0:3
    target=[];
for i=0:n-1

%target sinusoidale
target(i+1)=sin((i*2*pi*(f(j+1)*0.001))/1)/100;     %è importante usare questo approccio e non un unico ciclo for da 3000 steps perchè mi devo assicurare che ogni 1000 steps la sinusoide parta con la stessa fase (oltre che in questo modo risparmio iterazioni)
target(i+1+n)=target(i+1);
target(i+1+2*n)=target(i+1);

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
    case 4
save target_default_4.txt target -ASCII;
    case 5
save target_default_5.txt target -ASCII;
end
end