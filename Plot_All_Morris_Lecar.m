function Plot_All_Morris_Lecar (sim, t, n_classes) 
for i=0:(n_classes-1)
        t.Layout.TileSpan = [1 1];
        nexttile(t);
        Plot_Morris_Lecar(sim, i);
        
end
titolo = sprintf("Simulazione %d", sim);
title(t, titolo);
xlabel(t, "Steps");
ylabel(t, "Voltage");
end



