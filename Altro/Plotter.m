function Plotter(ind,indInt,seq,nLearn,sav,points,subSeq)
%% function Plotter(ind,indInt,seq,nLearn,sav,points,subSeq)
% La funzione inizia una serie di procedure organizzate per plottare tutti
% i grafici necessari al'analisi della rete
% ind: vettore con indice delle epoche che si vogliono plottare
% indInt: vettore contenente un numero che indica quale simulationInternal
% considerare per ogni epoca
% seq: array di stringhe contenenti in ogni posizione l'elemento dato a
% ad ogni epoca indicata in ind, esempio se si riproduce la sequenza ABC il parametro da
% passare sarà  {'A' 'B' 'C'}
% nLearn: numero di epoche di leaning che si stanno graficando rispetto a
% quelle indicate in ind
% "opzionale" sav: true se si vogliono salvare le immagini nel file ppt,
% false se non lo si vuole fare
% "opzionale" points: true nel contesto stampa tutti i punti per ogni elemento, false stampa solo i punti per i neuroni vincitori in ogni anello
% "opzionale" subSeq: true ho il contesto con le sottosequenze attive (cioè in ogni anello ho un vincitore), false ho il vincitore solo nell'ultimo anello e gli anelli precedenti a questo sono inattivi

global fontsize spessore test maxIndPre container startStep saving

prova=[];
potM=[];
provaPrec=[];
maxIndPre=[];
container=cell(0);
contain=cell(1);
startStep=200;                      %indica lo step iniziale da cui si carica i dati (serve per eliminare la fase di feedforward, se si mette a 0 viene considerata se si mette 200 no)

if nargin<3
    seq=true;
    nLearn=0;
    sav=false;
    points=false;
    subSeq=true;   
elseif nargin<4
    nLearn=0;
    sav=false;
    points=false;
    subSeq=true;    
elseif nargin<5
    sav=false;
    points=false;
    subSeq=true;
elseif nargin<6
    points=false;
    subSeq=true;
elseif nargin<7
    subSeq=true;
end

saving=sav;


indicePrev=-1;



fontsize=30;                    %Fontsize usato in ogni plot, basta cambiarlo qui per cambiarlo in tutti i grafici
spessore=3;                   %spessore delle linee nei plots

et=1;

if(size(ind,2)==size(indInt,2)) && (size(ind,2)==size(seq,2) || seq)
    for f=1:numel(ind)
        etichetta=[];
        if f<=nLearn
            etichetta='Learning: ';
            test=0;
            et=1;
        else
            etichetta='Testing: ';
            test=1;
            et=nLearn+1;
        end
        for m=et:f
            etichetta=[etichetta,seq{m},' '];        
        end
        indice=ind(f);
        indiceInt=indInt(f);
        loader;                                             %creo la cartella corrispondente all'epoca dove salvo tutte le immagine prodotte inerenti all'epoca stessa
%         Plotta(indice);                                     %con questa istruzione produco i plots dell'input,sameness,persistance e morris-lecar
%           ContextMapEvo(indice,points,subSeq,etichetta);      %con questa istruzione produco i plots del contesto e dei neuroni di end sequence 
%           SubSequencesConstruction;                          %con questo script si costruiscono i dati per plottare i neuroni del contesto con le sottosequenze 
                                                             %ATTENZIONE: per ativare SubSequenceConstraction è necessiario attivare il plotter fornendo le epoche necessarie per avere la sequenza completa
                                                            
%         contain{1}=RasterPlot(indice);                                 %con questa istruzione produco il plot della LiquidState
%         avi_generator_raster(contain,'Liquid State');
%         contain{1}=Motor(indice);
%         avi_generator(contain,'Motor Neurons',{'Right', 'Left'});
%         
%         contain{1}=squeeze(potenziali15_ML);
%         avi_generator(contain,'Morris-Lecar Neurons',{'Class 1', 'Class 2'});
%       potM=[potM, Motor(indice)];
%        potM=[potM, potenzialiEnd];
%        indicePrev=indice;

    end
else
    disp('HAI INSERITO UN NUMERO DIVERSO DI ind e indInt o NUMERO DI ELEMENTI DELLA SEQUENZA SBAGLIATO');
end

%% zona riservata agli extra plot che necessitano di più epoche per essere eseguiti


%  SubSequences;
%  contain{1}=container{1}(:,1:1000);
%  contain{1}=container{1};
%  contain{1}(1,end-999:end)=potenziali16(1,1,1:1000);
%  avi_generator(contain,'Activity of the principal neurons of the Context Layer',seq);
% contain{1}=container{1}(:,1001:2000);
% avi_generator(contain,'Activity of the principal neurons of the Context Layer',{'A', 'B'});

contain{1}=potM;
%avi_generator(contain,'Motor Neurons',{'Right', 'Left'});

avi_generator(contain,'End Neurons',{'Ring 1', 'Ring 2', 'Ring 3'});

clear all
end