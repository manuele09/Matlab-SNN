function Plot_All_Liquid (sim, t) 
for i=0:7
    for j=0:7
        t.Layout.TileSpan = [1 1];
        nexttile(t);
        Plot_Single_Neuron(sim, 14, i, j);
        titolo = sprintf("Neuron %d-%d", i, j);
        title(titolo);
    end
end
titolo = sprintf("Liquid, Simulazione %d", sim);
title(t, titolo);
xlabel(t, "Steps");
ylabel(t, "Voltage");
end



