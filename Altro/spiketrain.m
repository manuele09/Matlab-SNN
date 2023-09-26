%testa la simulazione di 3 tipi di Neuoroni: 
%Izhikevich, Morris-Lecar, Integratore
%Non ha nessuna utilità

%function spiketrain()
I=0;
IBias=5;
V=-70;    %queste sono le condizioni iniziali per l'equazione del neurone
U=-14;
%spiking neuron
A=0.02;
B=0.2;
C=-65;
D=1.5;
%alt neuron
% A=0;
% B=-0.1;
% C=-55;
% D=0;
%class1
% A=0.02;
% B=-0.1;
% C=-55;
% D=6;

potential=[];
%u=[];

for k=1:1000

v = V + 0.05 * ((0.04 * V * V) + (5.0 * V) + 140.0 - U + I + IBias);
u = U + 0.05 * A * ((B * V) - U);
if (v > 30)
			
				V = C;
				U = U + D;	
else
			
				V = v;
				U = u;
end
potential(k)=v;

end
figure
plot(potential);

%% Morris Lecar
Vk=-84;
Vl=-60;
Vca=120;
gca=4.4;
gk=8;
gl=2;
V1=-1.2;
V2=18;
V3=2;
V4=30;
V=-60;
W=0.01;
%da questi ultimi due parametri dipende la frequenza del segnale che attiva il neurone

%10Hz:
I=61.2;
kf=0.105;
% %9Hz
% I=61.25;
% kf=0.095;
% %8Hz
% I=61.35;
% kf=0.082;
% %7Hz
% I=61.4;
% kf=0.074;
% %6Hz
% I=61.45;
% kf=0.067;
% %5Hz
% I=61.5;
% kf=0.055;


% %5Hz
% I= 61.5; %61.35; %valore in mA per avere freq = 8 Hz
% kf= 0.055; %0.082;

%%Articolo prof
% Vk=-0.7;
% Vl=-0.5;
% Vca=1;
% gca=2;
% gk=8; %
% gl=2; %
% V1=-0.01;
% V2=0.15;
% V3=-0.198;
% V4=0.1;
% V=-60;  %
% W=0.01; %

%da questi ultimi due parametri dipende la frequenza del segnale che attiva il neurone
% I= 100; %0.255; %61.4; %valore in mA per avere freq = 7 Hz
% kf= 0.074;  %3.236*10^-4;%  0.074;

%questo dovrebbe essere il dt di campionamento
dt=1;
%dt2=1;
tend=1000;

Vt=[];
Wt=[];
yt=[];
flag_peak=[];
c1=0;

%data = importdata('Dati\Z_pesi_fissi0-235.txt');

for z=1:dt:tend
%----Segnale sinusoidale a freq f in Hz in input al neurone
f=10*0.001;
y =I*(sin(2*pi*f*z/dt)); %sin or square
%y=I*potenziali17(1,1,z)*100;
%y=60;
%y=I*data(z)*100;

% if(abs(y)>I)
%     y=I*sign(y);
% end
% 
% if(y>0)
%     y=I;
% else y=-I;
% end

%----Equazioni del Modello di Morris-Lecar e relativo calcolo del potenziale
minf=.5*(1+tanh((V-V1)/V2));
winf=.5*(1+tanh((V-V3)/V4));
tauw=3*(cosh((V-V3)/(2*V4)))^-1;
    V=V+dt*kf*(y - gca*minf*(V-Vca)-gk*W*(V-Vk)-gl*(V-Vl));
    W=W+dt*kf*(winf-W)/tauw;
% Vt(z)=V;
% Wt(z)=W;
% yt(z)=y;
Vt=[Vt V];
Wt=[Wt W];
yt=[yt y];

%----Se il neurone supera la soglia, emette lo spike
if (V > 30) && ((c1==0)||(z-flag_peak(end)>15))
flag_peak(c1+1) = z;
        c1=c1+1;
        %V=-60; %queste ultime due righe le ho aggiunte io in quanto dopo lo spike in teoria si dovrebbe resettare il neurone 
        %W=0.01;
end

end
figure
plot(Vt);
hold on
plot(yt,'r');
%plot(Wt,'g');
const=30*ones(1,tend/dt);
%plot(const,'m');        %plotto questo valore costante in modo da individuare facilmente gli spike emessi
xlabel('step','fontsize',14)
ylabel('membrane potential [mV]','fontsize',14)
% set(gca,'FontSize',14)
title('Membrane potentials of the MorrisLecar Output Layer','fontsize',14)
%end


%% Neurone integratore

integration_step=0.08;
tau=50;%50;
delay=0;
Idef=[];
gain=1;
w=1;
tend=1000;
% flag_peak2=flag_peak+1000;
% flag_peak=[flag_peak flag_peak2];
Ibias=0;
for j=1:2
    
    if j~=1
        %flag_peak=[];
        h=(j-1)*1000;
        Ibias=Idef(h);
 	%I=0;
    else
        h=0;
        Ibias=0;
    end
    
%I=Ibias;

for z=1:dt:tend
Is=0;
for k=1:numel(flag_peak)
    tspk=flag_peak(k);
    if (tspk <=z)
        t=integration_step*(z-tspk+delay);
        it=gain*(t/tau)*exp(1-t/tau);
        Is=Is+it;
    end 
end

I=(Is)*w;
Ibias=0.999*(I+Ibias);
Idef(z+h)=Ibias;
end

end
figure
plot(Idef);





