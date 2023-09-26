clear

%% Sameness
for k = 11:15
    system('SLN-CS_Sameness.exe');
    dirname = ['Sameness/SLN_' int2str(k)];
    mkdir(dirname);
    
    wsameness = zeros(16,1);
    wsosl = zeros(9,9,16);

    for n = 1:16
        n %#ok
        Plotta(n)
        close all
        [sam, sos] = PlottaSyn(n);
        if n > 1
            wsameness(n-1) = sam;
            wsosl(:,:,n-1) = sos;
        end
        load SLN
        load SLN_SYN
        save(['SLN' int2str(n)])
    end

    delete('SLN.mat')
    delete('SLN_SYN.mat')
    save('Pesi', 'wsameness', 'wsosl')
    
    movefile('SLN*.mat', dirname)
    movefile('Pesi.mat', dirname)
end

%% Classic
for k = 11:15
    system('SLN-CS_Classic.exe');
    dirname = ['Classic/SLN_' int2str(k)];
    mkdir(dirname);
    
    wsameness = zeros(16,1);
    wsosl = zeros(9,9,16);

    for n = 1:16
        n %#ok
        Plotta(n)
        close all
        [sam, sos] = PlottaSyn(n);
        if n > 1
            wsameness(n-1) = sam;
            wsosl(:,:,n-1) = sos;
        end
        load SLN
        load SLN_SYN
        save(['SLN' int2str(n)])
    end

    delete('SLN.mat')
    delete('SLN_SYN.mat')
    save('Pesi', 'wsameness', 'wsosl')
    
    movefile('SLN*.mat', dirname)
    movefile('Pesi.mat', dirname)
end

%% Finally...
delete('*.txt')
clear