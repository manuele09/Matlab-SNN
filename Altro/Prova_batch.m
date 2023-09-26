clear
wsameness = zeros(16,1);
wsosl = zeros(9,9,16);

for n = 11:16
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

save('Pesi', 'wsameness', 'wsosl')
