%% a)
close all; clear; clc;
subplot(3, 1, 1); hold on;

stem([-2, 0, 2], [1, 1, 1], "color", "black", LineWidth=1.5, Marker="^");

text(-2, 1.1, "0.25", "HorizontalAlignment", "left", "VerticalAlignment", "bottom");
text(0, 1.1, "1", "HorizontalAlignment", "left", "VerticalAlignment", "bottom");
text(2, 1.1, "0.25", "HorizontalAlignment", "left", "VerticalAlignment", "bottom");


axis([-8, 8, -1.4, 1.4]);
yticks([]);
xlabel("$f$ [kHz]");
ylabel("Re$(X(f))$");
title("Sketch of Real Part of Spectrum of Analog Signal $x(t)$");

% =========================================================================
subplot(3, 1, 2); hold on;

stem([4, 6], [-1, -1], "color", "black", LineWidth=1.5, Marker="v");
stem([-6, -4], [1, 1], "color", "black", LineWidth=1.5, Marker="^");

text(-6, 1.1, "-0.5j", "HorizontalAlignment", "left", "VerticalAlignment", "bottom");
text(-4, 1.1, "-1j", "HorizontalAlignment", "left", "VerticalAlignment", "bottom");
text(4, -1.4, "1j", "HorizontalAlignment", "left", "VerticalAlignment", "bottom");
text(6, -1.4, "0.5j", "HorizontalAlignment", "left", "VerticalAlignment", "bottom");

axis([-8, 8, -1.4, 1.4]);
yticks([]);
xlabel("$f$ [kHz]");
ylabel("Im$(X(f))$");
title("Sketch of Imaginary Part of Spectrum of Analog Signal $x(t)$");

% =========================================================================
subplot(3, 1, 3);
hold on;

plot(x(0:1e-6:1e-3))

axis([0, 1e+3, -2, 4.5]);
xticklabels(0:0.1:1)
xlabel("$t$ [ms]");
ylabel("$x(t)$");
title("Sketch of Analog Signal $x(t)$");

%% b)
close all; clear; clc;
subplot(2, 3, 1); hold on;

t = linspace(0, 1e-3, 10);
t = t(1:end-1);
x_1 = x(t);
stem(t.*1000000, x_1);
plot(x(0:1e-6:1e-3));

axis([0, 1e+3, -2, 4.5]);
xticklabels(0:0.5:1);
xlabel("$t$ [ms]");
ylabel("$x_1[t]$");
title("Sketch of Signal Sampled at 9kHz");
legend(["$x(t)$", "$x_1[t]$"])

% =========================================================================
subplot(2, 3, 2); hold on;

fs1 = 9e3;
t1 = 0:1/fs1:1e-3;
x_1_n = x(t1);

N = 256;

X_1 = fft(x_1_n, N);
f1_axis = (0:N-1)*(fs1/N);
plot(f1_axis, abs(X_1), Color="#50A050");

axis([0, fs1, 0, 11])
xlabel("$f$ (Hz)");
ylabel("$|X_1(f)|$");
title("Sketch of Spectrum of Signal Sampled at 9kHz");

% =========================================================================
subplot(2, 3, 3); hold on;

t_reconstruct = 0:1e-6:1e-3;
x_1_reconstruct = interp1(t1, x_1_n, t_reconstruct, "spline");
plot(t_reconstruct, x_1_reconstruct, Color="#D95319");

title("Reconstructed Signal $x_1(t)$");
xlabel("$t$ [ms]");
ylabel("$x_1(t)$");
axis([0, 1e-3, -2, 4.5]);
xticklabels(0:0.5:1);

% =========================================================================
subplot(2, 3, 4); hold on;


t = linspace(0, 1e-3, 15);
t = t(1:end-1);
x_2 = x(t);
stem(t.*1000000, x_2);
plot(x(0:1e-6:1e-3));

axis([0, 1e+3, -2, 4.5]);
xticklabels(0:0.5:1);
xlabel("$t$ [ms]");
ylabel("$x_2[t]$");
title("Sketch of Signal Sampled at 14kHz");
legend(["$x(t)$", "$x_2[t]$"])

% =========================================================================
subplot(2, 3, 5); hold on;

fs2 = 14e3;
t2 = 0:1/fs2:1e-3;
x_2_n = x(t2);

N = 256;

X_2 = fft(x_2_n, N);
f2_axis = (0:N-1)*(fs2/N);
plot(f2_axis, abs(X_2), Color="#50A050");

axis([0, fs2, 0, 16])
xlabel("$f$ (Hz)");
ylabel("$|X_2(f)|$");
title("Sketch of Spectrum of Signal Sampled at 14kHz");

% =========================================================================
subplot(2, 3, 6); hold on;

x_2_reconstruct = interp1(t2, x_2_n, t_reconstruct, "spline");
plot(t_reconstruct, x_2_reconstruct, Color="#D95319");

title("Reconstructed Signal $x_2(t)$");
xlabel("$t$ [ms]");
ylabel("$x_2(t)$");
axis([0, 1e-3, -2, 4.5]);
xticklabels(0:0.5:1);


function x = x(t)
    x = 1 ...
        + 0.5 * cos(2 * pi * 2000 * t) ...
        + 2 * sin(2 * pi * 4000 * t) ...
        + sin(2 * pi * 6000 * t);
end









