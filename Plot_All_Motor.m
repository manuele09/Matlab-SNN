function Plot_All_Motor (sim, t) 
for i=0:1
        t.Layout.TileSpan = [1 1];
        nexttile(t);
        Plot_Single_Neuron(sim, 4, 1, i)
        
end
titolo = sprintf("Simulazione %d", sim);
title(t, titolo);
xlabel(t, "Steps");
ylabel(t, "Voltage");
end



