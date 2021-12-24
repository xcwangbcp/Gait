function [t,X] = smooth_not_detrend(X,Fs)
T = 1/Fs;
L = length(X);
t = (0:L-1)*T;
X = X-mean(X);
X = smooth(X);
end
