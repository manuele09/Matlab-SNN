function Plot_All_Ring (sim, t, ring) 
%plottiamo per ora solo il ring 0
index = [];
if ring == 0
    index = [0, 3, 14];
else
    index = [1, 4, 5, 6, 15, 16, 17, 18, 19];
end
for i=0:(size(index, 2) - 1)
        t.Layout.TileSpan = [1 1];
        nexttile(t);
        %Plot_Single_Context(sim, ring, i);
        Plot_Single_Context(sim, ring, i);
        xlim([200, 1200]);
        ylim([-100, 30]);
        
end
title(t, "Ring");
ylim([-90, 40]);

end

%primo anello: 0, 3, 14
%secondo anello: 1, 4, 5, 6, 15, 16, 17, 18, 19
%terzo anello: 2, 7, 8, 9, 10, 11, 12, 13, 20, 21, 22, 23, 24, 25, 26, 27, 28
% 29, 30, 31, 32, 33, 34, 35, 36, 37, 38



