Vk = -84;
Vl = -60;
Vca = 120;
gca = 4.4;
gk = 8;
gl = 2;
V1 = -1.2;
V2 = 18;
V3 = 2;
V4 = 30;

kf = 0.35;
A = 500;


% Parametri del tempo
dt = 1; % Risoluzione temporale (ms)
t_end = 1000; % Durata della simulazione (ms)
t = 0:dt:t_end;

% Array di frequenze
 frequenze = [5, 10, 15, 20, 25]; % Frequenze dell'input sinusoidale (Hz)
%frequenze = [25, 30, 35, 40, 45]; % Frequenze dell'input sinusoidale (Hz)
%frequenze = [45, 50, 55, 60, 65]; % Frequenze dell'input sinusoidale (Hz)

n_frequenze = length(frequenze);


% Inizializzazione delle variabili di stato
v = -60 * ones(size(t)); % Tensione di membrana (mV)
w = 0.01 * ones(size(t));

% Creazione della figura
figure;

for k = 1:n_frequenze
    % Calcolo dell'input sinusoidale per la frequenza corrente
    
    if (k == n_frequenze)
        input = ones(size(t)) * A;
    else
        input = A * sin(2 * pi * frequenze(k) * t / 1000);
    end
    
        % Simulazione del neurone di Izhikevich per la frequenza corrente
    spike_count = 0;
    for i = 1:numel(t)-1
        if (input(i) > 0)
            input(i) = A;
        else 
            input(i) = -A;
        end

        minf = 0.5*(1+tanh((v(i)-V1)/2));
        winf = 0.5*(1+tanh((v(i)-V3)/V4));
        tauw = 3/((cosh((v(i)-V3)/(2*V4))));

        v(i+1)=v(i)+dt*kf*(input(i) - gca*minf*(v(i)-Vca)-gk*w(i)*(v(i)-Vk)-gl*(v(i)-Vl));
        w(i+1)=w(i)+dt*kf*(winf-w(i))/tauw;

        
        % Controllo del potenziale d'azione
        if v(i+1) >= 30
            v(i+1) = c;
            w(i+1) = w(i+1) + d;
            spike_count = spike_count + 1;
        end
    end
    
    % Calcolo del numero medio di spike
    spike_rate = spike_count / (t_end / 1000); % Spike al secondo (Hz)

    % Grafico sovrapposto dell'input sinusoidale e della tensione di membrana del neurone
    subplot(n_frequenze, 1, k);
    hold on;
    plot(t, input, 'LineWidth', 1.5, 'DisplayName', sprintf('Input Sinusoidale (%d Hz)', frequenze(k)));
    plot(t, v, 'LineWidth', 1.5, 'DisplayName', 'Tensione di Membrana');
    title(sprintf('Frequenza: %d Hz, Spike Rate: %.2f Hz', frequenze(k), spike_rate));
    xlabel('Tempo (ms)');
    ylabel('Tensione (mV)');
    legend('show');
    hold off;
end
