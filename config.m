configs.title_font_size = 40; %title dimension
configs.axis_font_size = 20; %x e y label dimension
configs.tick_font_size = 30; %axis numbers and legend dimension
configs.line_width = 1.5; %line width

configs.liquid_layer = 14;

%%%%%%%%%%%%%%%%%%%%%%%
configs.output_layer = 15;
configs.sum_row = 0;
configs.morris_row = 1;
configs.persistance_row = 2;
configs.sameness_row = 3;
%%%%%%%%%%%%%%%%%%%%%%%

configs.context_layer = 16;

configs.motor_layer = 4;
configs.motor_row = 1;

save("config.mat", "configs");

%How to use:
% loadedConfig = load('config.mat');
% configurazione = loadedConfig.configs;
% disp(configurazione.context_layer);
