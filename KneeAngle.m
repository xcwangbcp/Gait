function [knee_anglemax,knee_cycle] =  KneeAngle(raw,strat_line,end_line,filename,M)
Fs = 30; % frame rate,sample rate

% thigh40/41 knee43/44 foot46/47  clean 20/21 23/24 26/27
knee_angle_x_raw      = [raw(strat_line:end_line,M.thigh_colum(1)),raw(strat_line:end_line,M.knee_colum(1)),raw(strat_line:end_line,M.rfoot_colum(1))];
knee_angle_y_raw      = [raw(strat_line:end_line,M.thigh_colum(2)),raw(strat_line:end_line,M.knee_colum(2)),raw(strat_line:end_line,M.rfoot_colum(2))];

thigh = [knee_angle_x_raw(:,1),knee_angle_y_raw(:,1)];
knee  = [knee_angle_x_raw(:,2),knee_angle_y_raw(:,2)];
foot  = [knee_angle_x_raw(:,3),knee_angle_y_raw(:,3)];

angle = zeros(length(knee(:,1)),1);

figure
subplot(211)
for i=1:length(knee(:,1))
    plot(knee_angle_x_raw(i,:),knee_angle_y_raw(i,:),'marker','+')
    angle(i,1) = acosd((norm(thigh(i,:)-knee(i,:))^2 + norm(knee(i,:)-foot(i,:))^2-norm(thigh(i,:)-foot(i,:))^2)/(2*norm(thigh(i,:)-knee(i,:))*norm(knee(i,:)-foot(i,:))));
    hold on
end

set(gca,'YDir','reverse')
title('Knee Angle')
title(['Monkey', filename, ' Knee Angle'])
axis([200 400 200 400])
t = (1:length(angle))/30;

subplot(212)
knee_angle_x_norm = knee_angle_x_raw-knee_angle_x_raw(:,1)+mean(knee_angle_x_raw(:,1));
knee_angle_y_norm = knee_angle_y_raw-knee_angle_y_raw(:,1)+mean(knee_angle_y_raw(:,1));
for i=1:length(knee_angle_x_raw)
    plot(knee_angle_x_norm(i,:),knee_angle_y_norm(i,:),'marker','+')
    hold on
end

set(gca,'YDir','reverse')
axis([200 400 200 400])

figure
subplot(311)
[tx,X,f,P1] = cycle_search(angle ,Fs);
plot(f(2:end),P1(2:end))
% title('Monkey 159 right foot X-dimension Spectrum of S(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')
Fx=find(P1==max(P1(2:end)));
knee_cycle = 1/f(Fx);
hold on 
text(f(Fx),max(P1(2:end)),['[',num2str(roundn(f(Fx),-2)),' , ',num2str(roundn(max(P1(2:end)),-2)),']']);
location_x = f(Fx)*2; location_y = P1(find(f==location_x));
text(location_x ,location_y,['[',num2str(roundn(location_x,-2)),' , ',num2str(roundn(location_y,-2)),']']);
title('Froiur transform of the knee angle')

subplot(312)
plot(t,angle)
ylabel('Degree ')
xlabel('Time(Seconds)')
title('Right Thigh Angel')
title(['Monkey', filename, ' Right Leg Knee Angle'])
[knee_anglemax,tmax] = findpeaks(angle,t,'MinPeakDistance',0.7);
hold on
plot(tmax, knee_anglemax, 'r+');

subplot(313)
dgree_thigh2Hor = atand((knee(:,2)-thigh(:,2))./(knee(:,1)-thigh(:,1)));
plot(t,dgree_thigh2Hor)
reverse = max(dgree_thigh2Hor)-dgree_thigh2Hor;
[reversemax,tmin] = findpeaks(reverse,t,'MinPeakDistance',0.7);
hold on 
plot(tmin,max(dgree_thigh2Hor)-reversemax,'g+');
ylabel('Degree')
xlabel('Time(seconds)')
title('Degree from the thigh to horizontal')
end