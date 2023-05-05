function Plot_All_Persistance (sim, t, n_classes) 
for i=0:(n_classes-1)
        t.Layout.TileSpan = [1 1];
        nexttile(t);
        Plot_Single_Neuron(sim, 15, 2, i);
        hold on;
        Plot_Single_Neuron(sim, 15, 3, i);
        legend("Persistance", "Sameness");
        
end
titolo = sprintf("Simulazione %d", sim);
title(t, titolo);
xlabel(t, "Steps");
ylabel(t, "Voltage");
end



