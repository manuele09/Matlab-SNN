function Plot_All_Liquid (sim, t) 
for i=0:2
    for j=0:2
        %t.Layout.TileSpan = [1 1];
        nexttile(t);
        
        Plot_Single_Neuron(sim, 14, i, j);
        %titolo = sprintf("Neuron %d-%d", i, j);
        %title(titolo);
    end
end

title(t, "Liquid Layer", "Fontsize", 40)
xlabel(t, "Simulation Steps", "Fontsize", 40);
ylabel(t, "Membrane Potential (mV)", "Fontsize", 40);

end



