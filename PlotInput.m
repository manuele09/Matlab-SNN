loadedConfig = load('config.mat');
config = loadedConfig.configs;


sim_start = 12;

fig = figure('units','normalized','outerposition',[0 0 1 1]);
path = "./FiguresArticolo/Prove/OnlyNoise/";
T = tiledlayout(1, 1);
t = tiledlayout(T, 2, 4);
Plot_Inputs_Voltage(sim_start + 0, t);
t = title(T, "Membrane Potential of the Input Layer");
t.FontSize = config.title_font_size;
x = xlabel(T, "Simulation Steps");
x.FontSize = config.axis_font_size;
y = ylabel(T, "Membrane Potential (mV)");
y.FontSize = config.axis_font_size;
saveas(fig, path + "0.fig");
saveas(fig, path + "0.png");

% 
% fig = figure('units','normalized','outerposition',[0 0 1 1]);
% T = tiledlayout(1, 1);
% t = tiledlayout(T, 2, 4);
% Plot_Inputs_Voltage(sim_start + 1, t);
% t = title(T, "Membrane Potential of the Input Layer");
% t.FontSize = config.title_font_size;
% x = xlabel(T, "Simulation Steps");
% x.FontSize = config.axis_font_size;
% y = ylabel(T, "Membrane Potential (mV)");
% y.FontSize = config.axis_font_size;
% saveas(fig, path + "1.fig");
% saveas(fig, path + "1.png");
% 
% fig = figure('units','normalized','outerposition',[0 0 1 1]);
% T = tiledlayout(1, 1);
% t = tiledlayout(T, 2, 4);
% Plot_Inputs_Voltage(sim_start + 2, t);
% t = title(T, "Membrane Potential of the Input Layer");
% t.FontSize = config.title_font_size;
% x = xlabel(T, "Simulation Steps");
% x.FontSize = config.axis_font_size;
% y = ylabel(T, "Membrane Potential (mV)");
% y.FontSize = config.axis_font_size;
% saveas(fig, path + "2.fig");
% saveas(fig, path + "2.png");
% 
% fig = figure('units','normalized','outerposition',[0 0 1 1]);
% T = tiledlayout(1, 1);
% t = tiledlayout(T, 2, 4);
% Plot_Inputs_Voltage(sim_start + 3, t);
% t = title(T, "Membrane Potential of the Input Layer");
% t.FontSize = config.title_font_size;
% x = xlabel(T, "Simulation Steps");
% x.FontSize = config.axis_font_size; 
% y = ylabel(T, "Membrane Potential (mV)");
% y.FontSize = config.axis_font_size;
% saveas(fig, path + "3.fig");
% saveas(fig, path + "3.png");