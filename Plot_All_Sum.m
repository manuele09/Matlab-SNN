function Plot_All_Sum (sim, t, n_classes) 
for i=0:(n_classes-1)
        t.Layout.TileSpan = [1 1];
        nexttile(t);
        Plot_Single_Neuron(sim, 15, 0, i);
        titolo = sprintf("Sum Neurons %d", i);
        title(titolo)
        
end
titolo = sprintf("Simulazione %d", sim);
title(t, titolo);
xlabel(t, "Steps");
ylabel(t, "Voltage");
end



