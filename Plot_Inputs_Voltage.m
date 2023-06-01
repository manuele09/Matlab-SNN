function Plot_Inputs_Voltage(sim, t)


for i=0:1
    for j=0:3
        t.Layout.TileSpan = [1 1];
        nexttile(t);
        Plot_Single_Neuron(sim, 1, i, j);
        ylim([-100, 40]);
        
    end
end
titolo = sprintf("Simulazione %d", sim);
title(t, titolo);
xlabel(t, "Steps");
ylabel(t, "Voltage");
end

