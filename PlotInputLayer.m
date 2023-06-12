function PlotInputLayer(sim_start, titolo)
loadedConfig = load('config.mat');
config = loadedConfig.configs;


%fig = figure('units','normalized','outerposition',[0 0 1 1]);
fig = figure('Position', [830, 260, 700, 370]);
%path = "./FiguresArticolo/Prove/OnlyNoise/";
T = tiledlayout(1, 1);
t = tiledlayout(T, 2, 4);
Plot_Inputs_Voltage(sim_start + 0, t);
ti = title(T, strcat('Membrane Potential of the Input Layer: \color{red}', titolo), 'Interpreter', 'tex');

%ti = title(T, "Membrane Potential of the Input Layer: ");
%text(0.5, 0.9, titolo, 'Color', 'r');

ti.FontSize = config.title_font_size;
x = xlabel(T, "Simulation Steps");
x.FontSize = config.axis_font_size;
y = ylabel(T, "Membrane Potential (mV)");
y.FontSize = config.axis_font_size;
%saveas(fig, path + "0.fig");
%saveas(fig, path + "0.png");

end

