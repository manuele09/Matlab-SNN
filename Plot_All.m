sim = 0;
sim_test = 12;
n_classes = 3;
len1 = 3;
len2 = 3;
len_test = 3;
ring = 0;
rings = 3;

first_input = 1;
second_input = 0;
first_context = 0;
second_context = 0;
context_test = 0;
test_input = 0;
        
evo = 0;


% fig = figure();
% T = tiledlayout(len1, 1);
% contatore = 1;
% 
% %Motor 1
% for i=0:(len1 -1)
%     t=tiledlayout(T, 1, 1);
%     t.Layout.Tile = contatore;
%     t.Layout.TileSpan = [1 1];
%     nexttile(t);
% 
%     Plot_Single_Neuron(sim + i, 4, 1, 0)
%     hold on;
%     Plot_Single_Neuron(sim + i, 4, 1, 1);
% 
%     legend("Right", "Left");
%     titolo = sprintf("Simulazione %d", sim + i);
%     title(t, titolo);
%     xlabel(t, "Steps");
%     ylabel(t, "Voltage");
%     contatore = contatore + 1;
% end

% fig = figure();
% T = tiledlayout(1, len1);
% contatore = 1;
% title(T, "Persistance");
% for i=0:(len1 -1)
%     t=tiledlayout(T, n_classes, 1);
%     t.Layout.Tile = contatore;
%     Plot_All_Persistance(sim_test + i, t, n_classes);
%     contatore = contatore + 1;
% end
% 
% %Sameness
% title(T, "Sameness");
% for i=0:(len1 -1)
%     t=tiledlayout(T, n_classes, 1);
%     t.Layout.Tile = contatore;
%     Plot_All_Persistance(sim_test + i, t, n_classes);
%     contatore = contatore + 1;
% end


% fig = figure();
% T = tiledlayout(1, 3);
% contatore = 1;
% for i=0:(len1 -1)
%     t=tiledlayout(T, 9, 1);
%     t.Layout.Tile = contatore;
%     t.Layout.TileSpan = [1 1];
%     Plot_All_Ring(sim + i, t, 1);
%     contatore = contatore + 1;
% end


% fig = figure();
% T = tiledlayout(1, 1);
% t=tiledlayout(T, 8, 8);
% t.Layout.Tile = 1;
% Plot_All_Liquid(sim+1, t);
% saveas(fig, "../Figures/Liquid.fig");




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if (first_input ~= 0)
fig = figure();
T = tiledlayout(3, len1);
contatore = 1;

%INPUT 1
title(T, "Prima Sequenza");
for i=0:(len1 -1)
    t=tiledlayout(T, 4, 4);
    t.Layout.Tile = contatore;
    Plot_Inputs_Voltage(sim + i, t);
    contatore = contatore + 1;
end

%MORRIS LECAR 1
for i=0:(len1 -1)
    t=tiledlayout(T, n_classes, 1);
    t.Layout.Tile = contatore;
    Plot_All_Morris_Lecar(sim + i, t, n_classes);
    contatore = contatore + 1;
end


for i=0:(len1 -1)
    t=tiledlayout(T, n_classes, 1);
    t.Layout.Tile = contatore;
    Plot_All_Sum(sim + i, t, n_classes);
    contatore = contatore + 1;
end
saveas(fig, "../Figures/Input 1.fig");

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if (second_input ~= 0)
fig = figure();
T = tiledlayout(3, len2);
contatore = 1;

%INPUT 2
title(T, "Seconda Sequenza");
for i=0:(len2 -1)
    t=tiledlayout(T, 4, 4);
    t.Layout.Tile = contatore;
    Plot_Inputs_Voltage(sim + i + len1, t);
    contatore = contatore + 1;
end

%MORRIS LECAR 2
for i=0:(len2 -1)
    t=tiledlayout(T, n_classes, 1);
    t.Layout.Tile = contatore;
    Plot_All_Morris_Lecar(sim + i + len1, t, n_classes);
    contatore = contatore + 1;
end

for i=0:(len2 -1)
    t=tiledlayout(T, n_classes, 1);
    t.Layout.Tile = contatore;
    Plot_All_Sum(sim + i + len1, t, n_classes);
    contatore = contatore + 1;
end
saveas(fig, "../Figures/Input 2.fig");
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%CONTEXT LAYER 1
if (first_context ~= 0)
fig = figure();
colormap("turbo");
T = tiledlayout(3, len1);
title(T, "Prima Sequenza");
contatore = 1;

for i=0:(len1 -1)
    t=tiledlayout(T, 1, 1);
    t.Layout.Tile = contatore;
    t.Layout.TileSpan = [1 1];
    nexttile(t);
    if evo==1
        ContextMapEvo(sim + i, -1);
    else
        ContextMap(sim + i, -1);
    end
    contatore = contatore + 1;
end

for i=0:(len1 -1)
    t=tiledlayout(T, n_classes, 1);
    t.Layout.Tile = contatore;
    t.Layout.TileSpan = [1 1];
    Plot_All_Ring(sim + i, t, ring);
    contatore = contatore + 1;
end

%END NEURONS 1
%ha layer = 16
%ha row= NUM_RINGS
%ha column da 0 a NUM_RINGS
for i=0:(len1 -1)
    t=tiledlayout(T, n_classes, 1);
    t.Layout.Tile = contatore;
    t.Layout.TileSpan = [1 1];
    Plot_All_End(sim + i, t, n_classes, rings);
    contatore = contatore + 1;
end
saveas(fig, "../Figures/Context First Sequence.fig");
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%CONTEXT LAYER 2
if (second_context ~= 0)
fig = figure();
colormap("turbo");
T = tiledlayout(3, len2);
title(T, "Seconda Sequenza");
contatore = 1;

for i=0:(len2 -1)
    t=tiledlayout(T, 1, 1);
    t.Layout.Tile = contatore;
    t.Layout.TileSpan = [1 1];
    nexttile(t);
    if evo==1
        ContextMapEvo(sim + i + len1, -1);
    else
        ContextMap(sim + i + len1, -1);
    end
    contatore = contatore + 1;
end
%END NEURONS 1
%ha layer = 16
%ha row= NUM_RINGS
%ha column da 0 a NUM_RINGS

for i=0:(len2 -1)
    t=tiledlayout(T, n_classes, 1);
    t.Layout.Tile = contatore;
    t.Layout.TileSpan = [1 1];
    Plot_All_Ring(sim + i + len1, t, ring);
    contatore = contatore + 1;
end

for i=0:(len2 -1)
    t=tiledlayout(T, n_classes, 1);
    t.Layout.Tile = contatore;
    t.Layout.TileSpan = [1 1];
    Plot_All_End(sim + i + len1, t, n_classes, rings);
    contatore = contatore + 1;
end
saveas(fig, "../Figures/Context Second Sequence.fig");
end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%CONTEXT LAYER TEST
if (context_test ~= 0)
fig = figure();
colormap("turbo");
T = tiledlayout(3, len_test);
title(T, "Test");
contatore = 1;

for i=0:(len_test -1)
    t=tiledlayout(T, 1, 1);
    t.Layout.Tile = contatore;
    t.Layout.TileSpan = [1 1];
    nexttile(t);
    
    if evo==1
       ContextMapEvo(sim_test + i, -1);
    else
        ContextMap(sim_test + i, -1);
    end
    contatore = contatore + 1;
end

for i=0:(len_test -1)
    t=tiledlayout(T, n_classes, 1);
    t.Layout.Tile = contatore;
    t.Layout.TileSpan = [1 1];
    Plot_All_Ring(sim_test + i, t, ring);
    contatore = contatore + 1;
end

%END NEURONS TEST
%ha layer = 16
%ha row= NUM_RINGS
%ha column da 0 a NUM_RINGS

for i=0:(len_test - 1)
    t=tiledlayout(T, n_classes, 1);
    t.Layout.Tile = contatore;
    t.Layout.TileSpan = [1 1];
    Plot_All_End(sim_test + i, t, n_classes, rings);
    contatore = contatore + 1;
end
saveas(fig, "../Figures/Context Test Sequence.fig");
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%INPUT Test
if (test_input ~= 0)
fig = figure();
T = tiledlayout(3, len_test);
title(T, "Input Test");
contatore = 1;

for i=0:(len_test - 1)
    t=tiledlayout(T, 4, 4);
    t.Layout.Tile = contatore;
    Plot_Inputs_Voltage(sim_test + i, t);
    contatore = contatore + 1;
end

%MORRIS LECAR Test
for i=0:(len_test - 1)
    t=tiledlayout(T, n_classes, 1);
    t.Layout.Tile = contatore;
    Plot_All_Morris_Lecar(sim_test + i, t, n_classes);
    contatore = contatore + 1;

end

for i=0:(len_test - 1)
    t=tiledlayout(T, n_classes, 1);
    t.Layout.Tile = contatore;
    Plot_All_Sum(sim_test + i, t, n_classes);
    contatore = contatore + 1;
end
saveas(fig, "../Figures/Input Test.fig");
end


