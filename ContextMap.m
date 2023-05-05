%% Grafico 2D del contesto realizzato mediante l'uso di una mappa dei
%% colori
function ContextMap(indice,indiceInt)
%figure è stata commentata per usarla nel tile
%carico i dati
if(indiceInt==-1)
 dati = importdata(['../Dati/Neurons', num2str(indice),'.txt']);
else
dati = importdata(['../Dati/Neurons',num2str(indice),'-',num2str(indiceInt),'.txt']);
end
matrici = dati.data;
clear dati;

numberSteps=1100; 
number_Rings=3;
ind=1;
timestamp = -1;
for k = 1:size(matrici, 1)
    riga = matrici(k,:);
    if riga(1) ~= timestamp 
        timestamp = riga(1);
    end
    if riga(2) == 16     %Context Layer
        i = riga(3); %row
        j = riga(4); %column
        v = riga(5); %voltage
        u = riga(6); %u
        corr = riga(8); %corrente
        spk = riga(7); %NSpikes
        idp=riga(11); %id parent (father)
        idt=riga(12); %id target
        
        %non è un neurone del contesto
        %allora mi sa che da per scontato che è il neurone end
        if idp==-1 && idt==-1
        potenzialiEnd(i+1, j+1,timestamp+1) = v;%#ok
        correntiEnd(i+1, j+1,timestamp+1) = corr;
        umatEnd(i+1, j+1,timestamp+1) = u; %#ok
        spikeEnd(i+1, j+1, timestamp+1) = spk;
        else       
        potenziali16(i+1, j+1, timestamp+1) = v;%#ok
        correnti16(i+1, j+1, timestamp+1) = corr;
        vmat16((i+1)*10 + j+1, timestamp+1) = v; %#ok
        umat16((i+1)*10 + j+1, timestamp+1) = u; %#ok
        imat16((i+1)*10 + j+1, timestamp+1) = corr; %#ok
        spike16(i+1, j+1, timestamp+1)=spk;
        smat16(i+1, j+1) = spk; 
        idp16(i+1, j+1) = idp; 
        idt16(i+1, j+1) = idt;
        end
        
        if j ~= -1 && riga(1)==100
            matrixTree(j+1,1)=i;    %anello
            matrixTree(j+1,2)=idp;  %ID padre
            matrixTree(j+1,3)=idt;  %ID target
                                    %l'indice di riga è l'ID univoco
        end
    end
end

%definisco cosa plottare
%potenziali16 contiene i potenziali dei neuroni del contesto:
%rispettavivamente sono salvati riga, colonna, timestamp.
%data = zeros(4, 50);
data=mean(potenziali16(:,:,:),3);   %media dei potenziali di ciascun neurone
%rispetto al tempo, sarà una matrice di dimensione 2.
disp(size(data, 1));
disp(size(data, 2));
%data=(smat16(:,:)/1000)*1000/0.08;    %spike rate media nei 1000 steps


%definisco i vertici che equivalgono ai neuroni del contesto. Si suppone
%che il contesto abbia solo 3 anelli e che apprenda solo 3 classi

vertices=[];


vertices(1,1)=0; vertices(1,2)=0; vertices(1,3)=0; %aggiungo l'origine per un fattore grafico


%il primo anello ha raggio 1 e i punti sono dislocati in un raggio pari a
%0.5 in modo da poter disegnare sucessivamente le circonferenze

r1=1;       %raggio primo anello

[x,y]=pol2cart(pi/2,r1/2);      % identifico le coordinate della classe A
vertices(2,1)=x; vertices(2,2)=y; vertices(2,3)=0;

[x,y]=pol2cart(pi/2-(120*pi/180),r1/2);      % identifico le coordinate della classe B
vertices(3,1)=x; vertices(3,2)=y; vertices(3,3)=0;

[x,y]=pol2cart(pi/2+(120*pi/180),r1/2);      % identifico le coordinate della classe C
vertices(40,1)=x; vertices(40,2)=y; vertices(40,3)=0;

%il secondo anello ha raggio 2 e i punti sono dislocati in un raggio pari a
%1.5 in modo da poter disegnare sucessivamente le circonferenze

r2=2;       %raggio secondo anello

%figli di A
[x,y]=pol2cart(pi/2,r2-(r2-r1)/2);      % identifico le coordinate della classe B
vertices(4,1)=x; vertices(4,2)=y; vertices(4,3)=0;

[x,y]=pol2cart(pi/2-(30*pi/180),r2-(r2-r1)/2);     % identifico le coordinate della classe C
vertices(5,1)=x; vertices(5,2)=y; vertices(5,3)=0;

[x,y]=pol2cart(pi/2+(30*pi/180),r2-(r2-r1)/2);      % identifico le coordinate della classe A
vertices(6,1)=x; vertices(6,2)=y; vertices(6,3)=0;

%figli di B
[x,y]=pol2cart(pi/2-(120*pi/180),r2-(r2-r1)/2);      % identifico le coordinate della classe B
vertices(7,1)=x; vertices(7,2)=y; vertices(7,3)=0;

[x,y]=pol2cart(pi/2-(120*pi/180)-(30*pi/180),r2-(r2-r1)/2);      % identifico le coordinate della classe C
vertices(8,1)=x; vertices(8,2)=y; vertices(8,3)=0;

[x,y]=pol2cart(pi/2-(120*pi/180)+(30*pi/180),r2-(r2-r1)/2);      % identifico le coordinate della classe A
vertices(9,1)=x; vertices(9,2)=y; vertices(9,3)=0;


%figli di C
[x,y]=pol2cart(pi/2+(120*pi/180),r2-(r2-r1)/2);      % identifico le coordinate della classe B
vertices(10,1)=x; vertices(10,2)=y; vertices(10,3)=0;

[x,y]=pol2cart(pi/2+(120*pi/180)-(30*pi/180),r2-(r2-r1)/2);      % identifico le coordinate della classe C
vertices(11,1)=x; vertices(11,2)=y; vertices(11,3)=0;

[x,y]=pol2cart(pi/2+(120*pi/180)+(30*pi/180),r2-(r2-r1)/2);      % identifico le coordinate della classe A
vertices(12,1)=x; vertices(12,2)=y; vertices(12,3)=0;

%il secondo anello ha raggio 3 e i punti sono dislocati in un raggio pari a
%2.5 in modo da poter disegnare sucessivamente le circonferenze

r3=3;       %raggio terzo anello

%figli di AB
[x,y]=pol2cart(pi/2,r3-(r3-r2)/2);      % identifico le coordinate della classe B
vertices(13,1)=x; vertices(13,2)=y; vertices(13,3)=0;

[x,y]=pol2cart(pi/2-(10*pi/180),r3-(r3-r2)/2);      % identifico le coordinate della classe C
vertices(14,1)=x; vertices(14,2)=y; vertices(14,3)=0;

[x,y]=pol2cart(pi/2+(10*pi/180),r3-(r3-r2)/2);      % identifico le coordinate della classe A
vertices(15,1)=x; vertices(15,2)=y; vertices(15,3)=0;

%figli AC
[x,y]=pol2cart(pi/2-(30*pi/180),r3-(r3-r2)/2);      % identifico le coordinate della classe B
vertices(16,1)=x; vertices(16,2)=y; vertices(16,3)=0;

[x,y]=pol2cart(pi/2-(30*pi/180)-(10*pi/180),r3-(r3-r2)/2);      % identifico le coordinate della classe C
vertices(17,1)=x; vertices(17,2)=y; vertices(17,3)=0;

[x,y]=pol2cart(pi/2-(30*pi/180)+(10*pi/180),r3-(r3-r2)/2);      % identifico le coordinate della classe A
vertices(18,1)=x; vertices(18,2)=y; vertices(18,3)=0;

%figli AA
[x,y]=pol2cart(pi/2+(30*pi/180),r3-(r3-r2)/2);      % identifico le coordinate della classe B
vertices(19,1)=x; vertices(19,2)=y; vertices(19,3)=0;

[x,y]=pol2cart(pi/2+(30*pi/180)-(10*pi/180),r3-(r3-r2)/2);      % identifico le coordinate della classe C
vertices(20,1)=x; vertices(20,2)=y; vertices(20,3)=0;

[x,y]=pol2cart(pi/2+(30*pi/180)+(10*pi/180),r3-(r3-r2)/2);      % identifico le coordinate della classe A
vertices(21,1)=x; vertices(21,2)=y; vertices(21,3)=0;

%figli BB
[x,y]=pol2cart(pi/2-(120*pi/180),r3-(r3-r2)/2);      % identifico le coordinate della classe B
vertices(22,1)=x; vertices(22,2)=y; vertices(22,3)=0;

[x,y]=pol2cart(pi/2-(120*pi/180)-(10*pi/180),r3-(r3-r2)/2);      % identifico le coordinate della classe C
vertices(23,1)=x; vertices(23,2)=y; vertices(23,3)=0;

[x,y]=pol2cart(pi/2-(120*pi/180)+(10*pi/180),r3-(r3-r2)/2)      % identifico le coordinate della classe A
vertices(24,1)=x; vertices(24,2)=y; vertices(24,3)=0;

%figli BC
[x,y]=pol2cart(pi/2-(120*pi/180)-(30*pi/180),r3-(r3-r2)/2);      % identifico le coordinate della classe B
vertices(25,1)=x; vertices(25,2)=y; vertices(25,3)=0;

[x,y]=pol2cart(pi/2-(120*pi/180)-(30*pi/180)-(10*pi/180),r3-(r3-r2)/2)      % identifico le coordinate della classe C
vertices(26,1)=x; vertices(26,2)=y; vertices(26,3)=0;

[x,y]=pol2cart(pi/2-(120*pi/180)-(30*pi/180)+(10*pi/180),r3-(r3-r2)/2)      % identifico le coordinate della classe A
vertices(27,1)=x; vertices(27,2)=y; vertices(27,3)=0;

%figli BA
[x,y]=pol2cart(pi/2-(120*pi/180)+(30*pi/180),r3-(r3-r2)/2);      % identifico le coordinate della classe B
vertices(28,1)=x; vertices(28,2)=y; vertices(28,3)=0;

[x,y]=pol2cart(pi/2-(120*pi/180)+(30*pi/180)-(10*pi/180),r3-(r3-r2)/2);      % identifico le coordinate della classe C
vertices(29,1)=x; vertices(29,2)=y; vertices(29,3)=0;

[x,y]=pol2cart(pi/2-(120*pi/180)+(30*pi/180)+(10*pi/180),r3-(r3-r2)/2)      % identifico le coordinate della classe A
vertices(30,1)=x; vertices(30,2)=y; vertices(30,3)=0;


%figli CB
[x,y]=pol2cart(pi/2+(120*pi/180),r3-(r3-r2)/2);      % identifico le coordinate della classe B
vertices(31,1)=x; vertices(31,2)=y; vertices(31,3)=0;

[x,y]=pol2cart(pi/2+(120*pi/180)-(10*pi/180),r3-(r3-r2)/2);      % identifico le coordinate della classe C
vertices(32,1)=x; vertices(32,2)=y; vertices(32,3)=0;

[x,y]=pol2cart(pi/2+(120*pi/180)+(10*pi/180),r3-(r3-r2)/2);      % identifico le coordinate della classe A
vertices(33,1)=x; vertices(33,2)=y; vertices(33,3)=0;

%figli CC
[x,y]=pol2cart(pi/2+(120*pi/180)-(30*pi/180),r3-(r3-r2)/2);      % identifico le coordinate della classe B
vertices(34,1)=x; vertices(34,2)=y; vertices(34,3)=0;

[x,y]=pol2cart(pi/2+(120*pi/180)-(30*pi/180)-(10*pi/180),r3-(r3-r2)/2);      % identifico le coordinate della classe C
vertices(35,1)=x; vertices(35,2)=y; vertices(35,3)=0;

[x,y]=pol2cart(pi/2+(120*pi/180)-(30*pi/180)+(10*pi/180),r3-(r3-r2)/2);      % identifico le coordinate della classe A
vertices(36,1)=x; vertices(36,2)=y; vertices(36,3)=0;

%figli CA
[x,y]=pol2cart(pi/2+(120*pi/180)+(30*pi/180),r3-(r3-r2)/2);      % identifico le coordinate della classe B
vertices(37,1)=x; vertices(37,2)=y; vertices(37,3)=0;

[x,y]=pol2cart(pi/2+(120*pi/180)+(30*pi/180)-(10*pi/180),r3-(r3-r2)/2);      % identifico le coordinate della classe C
vertices(38,1)=x; vertices(38,2)=y; vertices(38,3)=0;

[x,y]=pol2cart(pi/2+(120*pi/180)+(30*pi/180)+(10*pi/180),r3-(r3-r2)/2);      % identifico le coordinate della classe A
vertices(39,1)=x; vertices(39,2)=y; vertices(39,3)=0;

%procedo adesso alla definizione dei collegamenti tra i vertici

%da origine alle 3 classi
faces(1,1)=1; faces(1,2)=40; faces(1,3)=2; faces(1,4)=2;
faces(2,1)=1; faces(2,2)=2; faces(2,3)=3; faces(2,4)=3;
faces(3,1)=1; faces(3,2)=3; faces(3,3)=40; faces(3,4)=40;
%da A ai suoi figli
faces(4,1)=2; faces(4,2)=4; faces(4,3)=5; faces(4,4)=2;
faces(5,1)=2; faces(5,2)=4; faces(5,3)=6; faces(5,4)=2;
%da B ai suoi figli
faces(6,1)=3; faces(6,2)=7; faces(6,3)=9; faces(6,4)=3;
faces(7,1)=3; faces(7,2)=7; faces(7,3)=8; faces(7,4)=3;
%da C ai suoi figli
faces(8,1)=40; faces(8,2)=10; faces(8,3)=11; faces(8,4)=40;
faces(9,1)=40; faces(9,2)=10; faces(9,3)=12; faces(9,4)=40;
%collegamenti intermedi tra i neurni del primo e secondo anello
faces(10,1)=2; faces(10,2)=3; faces(10,3)=9; faces(10,4)=5;
faces(11,1)=3; faces(11,2)=40; faces(11,3)=12; faces(11,4)=8;
faces(12,1)=40; faces(12,2)=2; faces(12,3)=6; faces(12,4)=11;

%da AB ai suoi figli
faces(13,1)=4; faces(13,2)=13; faces(13,3)=14; faces(13,4)=4; 
faces(14,1)=4; faces(14,2)=13; faces(14,3)=15; faces(14,4)=4;

%da AC ai suoi figli
faces(15,1)=5; faces(15,2)=16; faces(15,3)=17; faces(15,4)=5;
faces(16,1)=5; faces(16,2)=16; faces(16,3)=18; faces(16,4)=5;

%da AA ai suoi figli
faces(17,1)=6; faces(17,2)=19; faces(17,3)=20; faces(17,4)=6;
faces(18,1)=6; faces(18,2)=19; faces(18,3)=21; faces(18,4)=6;

%collegamento intermedio tra i figli di A
faces(19,1)=4; faces(19,2)=5; faces(19,3)=18; faces(19,4)=14;
faces(20,1)=4; faces(20,2)=6; faces(20,3)=20; faces(20,4)=15;

%da BB ai suoi figli
faces(21,1)=7; faces(21,2)=22; faces(21,3)=23; faces(21,4)=7;
faces(22,1)=7; faces(22,2)=22; faces(22,3)=24; faces(22,4)=7;

%da BC ai suoi figli
faces(23,1)=8; faces(23,2)=25; faces(23,3)=26; faces(23,4)=8;
faces(24,1)=8; faces(24,2)=25; faces(24,3)=27; faces(24,4)=8;

%da BA ai suoi figli
faces(25,1)=9; faces(25,2)=28; faces(25,3)=29; faces(25,4)=9;
faces(26,1)=9; faces(26,2)=28; faces(26,3)=30; faces(26,4)=9;

%collegamenti intermedi figli di B
faces(27,1)=7; faces(27,2)=9; faces(27,3)=29; faces(27,4)=24;
faces(28,1)=7; faces(28,2)=8; faces(28,3)=27; faces(28,4)=23;

%da CB ai suoi figli
faces(29,1)=10; faces(29,2)=31; faces(29,3)=32; faces(29,4)=10;
faces(30,1)=10; faces(30,2)=31; faces(30,3)=33; faces(30,4)=10;

%da CC ai suoi figli
faces(31,1)=11; faces(31,2)=34; faces(31,3)=35; faces(31,4)=11;
faces(32,1)=11; faces(32,2)=34; faces(32,3)=36; faces(32,4)=11;

%da CA ai suoi figli
faces(33,1)=12; faces(33,2)=37; faces(33,3)=38; faces(33,4)=12;
faces(34,1)=12; faces(34,2)=37; faces(34,3)=39; faces(34,4)=12;

%collegamenti intermedi figli C
faces(35,1)=10; faces(35,2)=11; faces(35,3)=36; faces(35,4)=32;
faces(36,1)=10; faces(36,2)=12; faces(36,3)=38; faces(36,4)=33;

%collego i neuroni di figli diversi degli ultimi anello tra loro per evitae buchi
faces(37,1)=5; faces(37,2)=9; faces(37,3)=30; faces(37,4)=17;
faces(38,1)=8; faces(38,2)=12; faces(38,3)=39; faces(38,4)=26;
faces(39,1)=11; faces(39,2)=6; faces(39,3)=21; faces(39,4)=35;


%definisco il vettore che contiene i dati per ciascun vertice
% disp(size(data));
 vett(1)=min(min(data));
 vett(2)=data(1,1);
 vett(3)=data(1,4);
 vett(40)=data(1,15);
% %figli di A
 vett(4)=data(2,5);
 vett(5)=data(2,16);
 vett(6)=data(2,2);
%figli di B
vett(7)=data(2,7);
vett(8)=data(2,17);
vett(9)=data(2,6);
%figli di C
vett(10)=data(2,19);
vett(11)=data(2,20);
vett(12)=data(2,18);
%figli di AB
vett(13)=data(3,10);
vett(14)=data(3,22);
vett(15)=data(3,9);
%figli di AC
vett(16)=data(3,12);
vett(17)=data(3,23);
vett(18)=data(3,11);
%figli di AA
vett(19)=data(3,8);
vett(20)=data(3,21);
vett(21)=data(3,3);
%figli di BB
vett(22)=data(3,26);
vett(23)=data(3,27);
vett(24)=data(3,25);
%figli di BC
vett(25)=data(3,29);
vett(26)=data(3,30);
vett(27)=data(3,28);
%figli di BA
vett(28)=data(3,14);
vett(29)=data(3,24);
vett(30)=data(3,13);
%figli di CB
vett(31)=data(3,35);
vett(32)=data(3,36);
vett(33)=data(3,34);
%figli di CC
vett(34)=data(3,38);
vett(35)=data(3,39);
vett(36)=data(3,37);
%figli di CA
vett(37)=data(3,32);
vett(38)=data(3,33);
vett(39)=data(3,31);



%figure
patch('Vertices', vertices, 'Faces', faces, 'FaceVertexCData', vett', 'FaceColor','interp'); %PATCH(X,Y,C) adds the "patch" or filled 2-D polygon defined by vectors X and Y to the current axes
%patch('Vertices', vertices, 'Faces', faces, 'FaceColor','interp'); %PATCH(X,Y,C) adds the "patch" or filled 2-D polygon defined by vectors X and Y to the current axes

colorbar;
%axis tight;

%plotto il primo anello
x=0;
y=0;
%x and y are the coordinates of the center of the circle
%r is the radius of the circle
%0.01 is the angle step, bigger values will draw the circle faster but
%you might notice imperfections (not very smooth)
ang=0:0.01:2*pi; 
xp=r1*cos(ang);
yp=r1*sin(ang);
hold on
plot(x+xp,y+yp,'m','LineWidth',1.5);

%plotto il secondo anello
xp=r2*cos(ang);
yp=r2*sin(ang);
plot(x+xp,y+yp,'m','LineWidth',1.5);

%plotto il terzo anello
xp=r3*cos(ang);
yp=r3*sin(ang);
plot(x+xp,y+yp,'m','LineWidth',1.5);

stringa = sprintf("Map of the Context Layer, Sim: %d", indice);
title(stringa,'FontSize',16);
axis([-3.5,3.5,-3.5,3.5]);



end