clear
close all
clc

Omega = 1 * pi;
w = linspace(-Omega, Omega, 4001);

n = -10:10;
x_vals = x(n);

X = dtft(x_vals, n, w);

plotting(Omega, w, X, "no_print")


function y = u(n)
    y = 1.*(n>=0);
end

function y = x(n)
    y = ((0.8).^abs(n)) .* (u(n+10) - u(n-11));
end

function X = dtft(x, n, w)
    % DTFT Computes Discrete-time Fourier transform
    % @param    x: finite duration sequence over n
    % @param    n: sample position vector
    % @param    w: frquency location vector
    % @return   X: DTFT values computed at w frequencies

    X = x * exp(-1j .* n' * w);

    % X = zeros(1, length(w));
    % for i=1:length(w)
    %     total = 0;
    %     for k=1:length(x_vals)
    %         total = total + x_vals(k) * exp(-1j * w(i) * n(k));
    %     end
    %     X(i) = total;
    % end

end

function plotting(Omega, w, X, file_name)
    pis = -floor(Omega / pi):floor(Omega / pi);

    % magnitude response
    subplot(2, 1, 1);
    plot(w, abs(X));
    xticks(pis * pi);
    xticklabels(sprintf("%d \\pit", pis).split("t"));
    if length(pis) > 3
        xline(pis * pi);
    end
    title('Magnitude Response');
    xlabel('\Omega');
    ylabel('|X(e^{j\Omega})|');
    
    % phase response
    subplot(2, 1, 2);
    plot(w, angle(X));
    xticks(pis * pi);
    xticklabels(sprintf("%d\\pit", pis).split("t"));
    if length(pis) > 3
        xline(pis * pi);
    end
    title('Phase Response');
    xlabel('\Omega');
    ylabel('Phase of X(e^{j\Omega})');
    
    sgtitle( ...
        sprintf('Magnitude and Phase Response of X(e^{j\\Omega}) for %d\\pi \\leq \\Omega \\leq %d\\pi', ...
        min(pis), max(pis)));

    if file_name ~= "no_print"
        saveas(gcf,'file_name.png');
    end
end
