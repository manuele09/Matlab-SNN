% Parametri del modello di Izhikevich
%regular spiking
% a = 0.1; %0.1
% b = 0.1; %0.26
% c = -65;
% d = 8;

a = 0.1; %0.1
b = 0.1; %0.26
c = -65;
d = 1;


% Parametri del tempo
dt = 0.08; % Risoluzione temporale (ms)
t_end = 1000; % Durata della simulazione (ms)
t = 0:dt:t_end;

% Array di frequenze
frequenze = [5, 10, 15, 20, 25]; % Frequenze dell'input sinusoidale (Hz)
n_frequenze = length(frequenze);
A = 10; % Ampiezza dell'input sinusoidale (mV)

% Inizializzazione delle variabili di stato
v = -65 * ones(size(t)); % Tensione di membrana (mV)
u = b * v; % Variabile di recupero

% Creazione della figura
figure;

for k = 1:n_frequenze
    % Calcolo dell'input sinusoidale per la frequenza corrente
    
    if (k == n_frequenze)
        input_sinusoidale = ones(size(t)) * A;
    else
        input_sinusoidale = A * sin(2 * pi * frequenze(k) * t / 1000);
    end
    
        % Simulazione del neurone di Izhikevich per la frequenza corrente
    spike_count = 0;
    for i = 1:numel(t)-1
        if (input_sinusoidale(i) > 0)
            input_sinusoidale(i) = A;
        else 
            input_sinusoidale(i) = -A;
        end
        v(i+1) = v(i) + dt * (0.04 * v(i)^2 + 5 * v(i) + 140 - u(i) + input_sinusoidale(i));
        u(i+1) = u(i) + dt * a * (b * v(i) - u(i));
        
        % Controllo del potenziale d'azione
        if v(i+1) >= 30
            v(i+1) = c;
            u(i+1) = u(i+1) + d;
            spike_count = spike_count + 1;
        end
    end
    
    % Calcolo del numero medio di spike
    spike_rate = spike_count / (t_end / 1000); % Spike al secondo (Hz)

    % Grafico sovrapposto dell'input sinusoidale e della tensione di membrana del neurone
    subplot(n_frequenze, 1, k);
    hold on;
    plot(t, input_sinusoidale, 'LineWidth', 1.5, 'DisplayName', sprintf('Input Sinusoidale (%d Hz)', frequenze(k)));
    plot(t, v, 'LineWidth', 1.5, 'DisplayName', 'Tensione di Membrana');
    title(sprintf('Frequenza: %d Hz, Spike Rate: %.2f Hz', frequenze(k), spike_rate));
    xlabel('Tempo (ms)');
    ylabel('Tensione (mV)');
    legend('show');
    hold off;
end
