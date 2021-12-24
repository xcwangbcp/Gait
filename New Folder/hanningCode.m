clc;clear all;close all;

FS = 1000;
TS = 1/FS;
f  = 100;
N  = 4096;
t  = (0:N-1)*TS;

sig   = floor(256*cos(2*pi*f*t));
freq  = (0:N-1)/N*FS;

y_ori = fft(sig);
y_new = zeros(1,N);
for m=2:N-1
    y_new(1,m) = 0.5*y_ori(1,m) - 0.25*y_ori(1,m-1) - 0.25*y_ori(1,m+1);
end

figure;
hold on;
plot(freq,abs(y_ori),'r');
plot(freq,abs(y_new),'b');
legend('FFT','FFT add window');
hold off;
title('不对FFT结果进行log运算');

figure;
hold on;
plot(freq,20*log10(abs(y_ori)),'r');
plot(freq,20*log10(abs(y_new)),'b');
legend('FFT','FFT加窗');
hold off;
title('对FFT结果进行log运算');
%%————————————————
