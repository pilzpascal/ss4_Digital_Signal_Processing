% FIR - filter design using the windowing method: rectangular window

fs = 20e3;                          % sampling frequency

% tolerance scheme
f_pass = 3.4e3;                     % passband cutoff frequency
f_stop = 4e3;                       % stopband cutoff frequency
Omega_pass = 2*pi*f_pass/fs;  	                % passband cutoff radian frequency
Omega_stop = 2*pi*f_stop/fs;   	            % stopband cutoff radian frequency

Delta_1 = 0.05;  			        % passband tolerance
Delta_2 = 10^(-45/20); 			            % stopband tolerance

% filter parameters
N = 20;        				        % filter order
Omega_0 = (Omega_pass + Omega_stop) / 2; 	                    % corner radian frequency

% impulse response (causal, order N)
n = -N/2:N/2;
h = (Omega_0/pi) * sinc(n * Omega_0);

% apply window (e.g., hamming, kaiser,...) on h
w = ones(1,numel(h));   % rectangular window
h = h.*w;


% frequency response
M = 1024;                           % number of frequency samples
[H,Omega] = freqz(h, 1, M);

% Graphics
% tolerance scheme for display
TSu = (1+Delta_1)*ones(1,M);        % upper tolerance border
TSl = zeros(1,M);                   % lower tolerance border
for k=1:M
  if k <= Omega_pass/pi*M
    TSl(k) = 1-Delta_1;
  end
  if k >= Omega_stop/pi*M
    TSu(k) = Delta_2;
  end
end
figure(1), clf
subplot(3,1,1)
n = 0:N;
stem(n,h), grid on                  % impulse response
xlabel('n \rightarrow'), ylabel('h[n] \rightarrow')
axis([0 N -.2 .5]);
subplot(3,1,2), plot(Omega/pi,abs(H),Omega/pi,TSu,'r',Omega/pi,TSl,'r')
axis([0 1 0 1.2]); grid
xlabel('\Omega / \pi \rightarrow')
ylabel('|H(\Omega)| \rightarrow')
subplot(3,1,3), plot(Omega/pi,20*log10(abs(H)),Omega/pi,20*log10(TSu),'r',...
Omega/pi,20*log10(TSl+1e-12),'r')
axis([0 1 -60 5]); grid
xlabel('\Omega / \pi \rightarrow')
ylabel('20*log|H(\Omega)| [dB] \rightarrow')
pause

% repeat filter design for filter order N = 90
N = 90; 

% impulse response (causal, order N)
n = -N/2:N/2;
h = (Omega_0/pi) * sinc(n * Omega_0);

% apply window (e.g., hamming, kaiser,...) on h
w = ones(1,numel(h));   % rectangular window
h = h.*w;

% frequency response
[H,Omega] = freqz(h, 1, M);

% ----------------------------------------------- graphics
figure(2), clf
subplot(3,1,1)
n = 0:N;
stem(n,h), grid % impulse response
xlabel('n \rightarrow'), ylabel('h[n] \rightarrow')
axis([0 N -.2 .5]);
subplot(3,1,2), plot(Omega/pi,abs(H),Omega/pi,TSu,'r',Omega/pi,TSl,'r')
axis([0 1 0 1.2]); grid
xlabel('\Omega / \pi \rightarrow')
ylabel('|H(\Omega)| \rightarrow')
subplot(3,1,3), plot(Omega/pi,20*log10(abs(H)),Omega/pi,20*log10(TSu),'r',...
Omega/pi,20*log10(TSl+1e-12),'r')
axis([0 1 -60 5]); grid
xlabel('\Omega / \pi \rightarrow')
ylabel('20*log|H(\Omega)| [dB] \rightarrow')
% end