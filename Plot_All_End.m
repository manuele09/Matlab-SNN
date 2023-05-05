function Plot_All_End (sim, t, n_classes, rings) 
for i=0:(n_classes - 1)
        t.Layout.TileSpan = [1 1];
        nexttile(t);
        Plot_Single_Neuron(sim, 16, rings, i);
        
end
title(t, "End Neurons");
ylim([-90, 40]);

end



