function [stat]=noise_stat(prove)
incremento=0;
stat=[];                    %matrice costituita da 4 colonne: prima colonna numero di learning andati a buon fine, la seconda il numero di test andati a buon fine, 
                            %la terza il numero di esperimenti in cui sia
                            %il learning che il test sono andato a buon
                            %fine e la quarta il numero di trials
                            %effettuati. Il numero di righe è pari al
                            %numero di rumori provati.

 for i=1:prove
   matrice=[];
   matrice=importdata(['Dati\Noise_',num2str(incremento*i),'.txt']);
   %matrice=dati.data;
   learnOk=0;
   testOk=0;
   lpiut=0;
   for j=1:size(matrice,1)
       if(matrice(j,1)==0)&&(matrice(j,2)==0)           %se il parametro è zero il learning o test è andato bene
           lpiut=lpiut+1;
           testOk=testOk+1;
           learnOk=learnOk+1;  
       else
           if(matrice(j,1)==0)
                learnOk=learnOk+1;
           end
    
           if(matrice(j,2)==0)
                testOk=testOk+1;
           end
       end
   
    stat(i,1)=learnOk;
    stat(i,2)=testOk;
    stat(i,3)=lpiut;
    stat(i,4)=size(matrice,1);
    
 end
end