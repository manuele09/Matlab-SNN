%non fa altro che plottare un seno
%inutile

% f=7;
% dt=1;
% I= 61.4;
% tend=1000;
% z=1:dt:tend;
% y =I*(sin(2*3.14*f*z));
% plot(y);
yt=[];

tstart=0;dt=1;tend=100;%lavoriamo in millisecondi
 sigfreq=8*0.001;

for t=tstart:dt:tend
    %----Segnali per la ricerca delle frequenze
    %y = 50*sin(2*pi*sigfreq*t/dt);
    y = 50*sin(pi*t/100);
     yt=[yt y];
end

%figure
hold on
plot(yt);