fig = figure();
len2 = 3;
sim = 12;
T = tiledlayout(2, len2);
contatore = 1;
n_classes = 4;

%MORRIS LECAR 2
for i=0:(len2 -1)
    t=tiledlayout(T, n_classes, 1);
    t.Layout.Tile = contatore;
    Plot_All_Morris_Lecar(sim + i, t, n_classes);
    contatore = contatore + 1;
end

for i=0:(len2 -1)
    t=tiledlayout(T, n_classes, 1);
    t.Layout.Tile = contatore;
    Plot_All_Sum(sim + i, t, n_classes);
    contatore = contatore + 1;
end