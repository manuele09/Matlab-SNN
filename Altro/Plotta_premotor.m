for n = 11:16
    load(['SLN' int2str(n)])
    figure
    plot(vmat4)
    title(['Epoch ' int2str(n)])
end