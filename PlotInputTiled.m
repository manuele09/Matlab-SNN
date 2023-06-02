len1 = 4;
sim = 8;
fig = figure();
T = tiledlayout(2, 2);
contatore = 1;

%INPUT 1
title(T, "Prima Sequenza");
for i=0:(len1 -1)   
    t=tiledlayout(T, 2, 4);
    t.Layout.Tile = contatore;
    Plot_Inputs_Voltage(sim + i, t);
    contatore = contatore + 1;
end