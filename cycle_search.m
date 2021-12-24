function [t,X,f,P1,F_X] = cycle_search(X,Fs)
                % Sampling frequency 
T = 1/Fs;       % Sampling period 
L = length(X);
% L = height(X);  % Length of signal
t = (0:L-1)*T; % Time vector 



% plot(t,X,'b');
% title('Monkey 133 right foot X-dimension move')
% xlabel('t(s)')
% ylabel('X(pixle)')
% X = table2array(X);
X = X-mean(X);
X = smooth(X);
X = detrend(X); % Remove a linear trend from a vector, usually for FFT processing.
F_X = fft(X);
P2 = abs(F_X/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;


end 
