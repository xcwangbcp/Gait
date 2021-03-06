function [beta,phi] = GaitFilter(raw,strat_line,end_line,M)
right_foot_x = raw(strat_line:end_line,M.rfoot_colum(1));
right_hand_x = raw(strat_line:end_line,M.rhand_colum(1));

% phi(phi/pi)
[tx,X,f,P1,F_X] = cycle_search(right_hand_x ,M.Fs);
Fx=find(P1==max(P1(2:end)));
z = F_X(Fx);
theta_hand = angle(z);
[tx,X,f,P1,F_X] = cycle_search(right_foot_x ,M.Fs);
Fx=find(P1==max(P1(2:end)));
z = F_X(Fx);
theta_foot = angle(z);

phi = (theta_foot - theta_hand) / pi;
while phi > 1
    phi = phi-2;
end
while phi <= -1
    phi = phi+2;
end

% find peaks
TD = [tx;X.'];
[XMax,locsXMax] = findpeaks(TD(2,:));
txMax = TD(1,locsXMax);
minusTD = [tx;-X.'];
[minusXMin,locsXMin] = findpeaks(minusTD(2,:));
XMin = -minusXMin;
txMin = minusTD(1,locsXMin);

% find peak pairs and control the edges of the data
locstxMin = find(txMin>txMax(1));
back_times = min(length(locstxMin),length(txMax));

support_phase = [];

for i = 1:back_times-1
     if txMin(locstxMin(i)) - txMax(i) > 0.4  %time filter here, must more than 0.3(s)
         t_to_regress = [TD(1,locsXMax(i) + 0.1*M.Fs:locsXMin(find(locsXMin > locsXMax(i),1))-0.1*M.Fs)];
         X_to_regress = [TD(2,locsXMax(i) + 0.1*M.Fs:locsXMin(find(locsXMin > locsXMax(i),1))-0.1*M.Fs)];
         [b,bint,r,rint,stats] = regress(X_to_regress.',[ones(size(t_to_regress')),t_to_regress']);
         if b(2) < -50 && stats(1) > 0.98 %speed filter and r^2 filter here
             support_phase(end+1) = txMin(locstxMin(i)) - txMax(i);
         end
     end
end
beta = mean(support_phase(:)) * f(Fx); 
end


