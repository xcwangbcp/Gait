function [Vt]  = TreadmillSpeed(raw,strat_line,end_line,M)

right_foot_x   = raw(strat_line:end_line,M.rfoot_colum(1));
[tx,X]         = smooth_not_detrend(right_foot_x ,M.Fs);
TD             = [tx;X.'];

figure

subplot(2,2,1)
plot(tx,X,'b');
title(' right foot X-dimension')
xlabel('t(s)')
ylabel('X(pixle)')

subplot(2,2,2)
plot(tx,X,'b');
title(' peaks and troughs')
xlabel('t(s)')
ylabel('X(pixle)')
hold on
[XMax,locsXMax] = findpeaks(TD(2,:));
txMax = TD(1,locsXMax);
plot(txMax,XMax,'r^')
hold on
minusTD = [tx;-X.'];
[minusXMin,locsXMin] = findpeaks(minusTD(2,:));
XMin = -minusXMin;
txMin = minusTD(1,locsXMin);
plot(txMin,XMin,'rv')
%disp(minusTD)
hold off

subplot(2,2,3)
plot(tx,X,'b');
title(' filtered peaks pairs')
xlabel('t(s)')
ylabel('X(pixle)')
hold on
[XMax,locsXMax] = findpeaks(TD(2,:));
txMax = TD(1,locsXMax);
plot(txMax,XMax,'r^')
hold on
minusTD = [tx;-X.'];
[minusXMin,locsXMin] = findpeaks(minusTD(2,:));
XMin = -minusXMin;
txMin = minusTD(1,locsXMin);
plot(txMin,XMin,'rv')
hold on

locstxMin = find(txMin>txMax(1));
times = min(length(locstxMin),length(txMax));
coef = [];
for i = 1:times
    if txMin(locstxMin(i)) - txMax(i) > 0.4 %time filter here, must more than 0.3(s)
        line([txMax(i),txMin(locstxMin(i))],[XMax(i),XMin(locstxMin(i))],'color','r')
        hold on
        t_to_regress = [TD(1,locsXMax(i) + 0.1*M.Fs:locsXMin(find(locsXMin > locsXMax(i),1))-0.1*M.Fs)];
        X_to_regress = [TD(2,locsXMax(i) + 0.1*M.Fs:locsXMin(find(locsXMin > locsXMax(i),1))-0.1*M.Fs)];
        [b,bint,r,rint,stats] = regress(X_to_regress.',[ones(size(t_to_regress')),t_to_regress']);
    end
end
hold off

subplot(2,2,4)
plot(tx,X,'b');
title(' linear regression line')
xlabel('t(s)')
ylabel('X(pixle)')
hold on
[XMax,locsXMax] = findpeaks(TD(2,:));
txMax = TD(1,locsXMax);
plot(txMax,XMax,'r^')
hold on
minusTD = [tx;-X.'];
[minusXMin,locsXMin] = findpeaks(minusTD(2,:));
XMin = -minusXMin;
txMin = minusTD(1,locsXMin);
plot(txMin,XMin,'rv')
hold on

locstxMin = find(txMin>txMax(1));
times = min(length(locstxMin),length(txMax));
coef = [];
for i = 1:times
    if txMin(locstxMin(i)) - txMax(i) > 0.4 %time filter here, must more than 0.3(s)
        t_to_regress = [TD(1,locsXMax(i) + 0.1*M.Fs:locsXMin(find(locsXMin > locsXMax(i),1))-0.1*M.Fs)];
        X_to_regress = [TD(2,locsXMax(i) + 0.1*M.Fs:locsXMin(find(locsXMin > locsXMax(i),1))-0.1*M.Fs)];
        [b,bint,r,rint,stats] = regress(X_to_regress.',[ones(size(t_to_regress')),t_to_regress']);
        if b(2) < -50 && stats(1) > 0.98 %speed filter and r^2 filter here
            z = b(1)+b(2)*t_to_regress;
            scatter(t_to_regress,X_to_regress,'k')
            hold on
            plot(t_to_regress,z,'k')
            hold on
            coef(end+1) = -b(2);
        end
    end 
end        
hold off       
        
Vt = mean(coef(:));   
end


