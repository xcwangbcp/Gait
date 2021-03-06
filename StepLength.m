function [foot_cycle,hand_cycle,step_length] = StepLength(raw,strat_line,end_line,filename,M)

right_foot_x   = raw(strat_line:end_line,M.rfoot_colum(1));%46 26/27
right_foot_y   = raw(strat_line:end_line,M.rfoot_colum(2)); %47
right_hand_x   = raw(strat_line:end_line,M.rhand_colum(1));%22
right_hand_y   = raw(strat_line:end_line,M.rhand_colum(2));%23

% right foot
[tx,X,f,P1] = cycle_search(right_foot_x ,M.Fs);

figure

subplot(2,2,1)
plot(tx,X ,'b');
xlabel('t(s)')
ylabel('X(pixle)')



subplot(2,2,2)
% plot(f(2:200),P1(2:200),'r','marker','*') 
plot(f(2:end),P1(2:end))
xlabel('f (Hz)')
ylabel('|P1(f)|')
Fx=find(P1==max(P1(2:end)));
foot_cycle  = 1/f(Fx);
step_length = roundn(max(P1(2:end)),-2)*2;% in pixle
hold on 
text(f(Fx),max(P1(2:end)),['[',num2str(roundn(f(Fx),-2)),' , ',num2str(roundn(max(P1(2:end)),-2)),']']);
location_x = f(Fx)*2; location_y = P1(find(f==location_x));
text(location_x ,location_y,['[',num2str(roundn(location_x,-2)),' , ',num2str(roundn(location_y,-2)),']']);


% [tmax,vmax,tmin,vmin] = extrem_num(f,P1);
[ty,Y,f,Py] = cycle_search(right_foot_y,M.Fs);
subplot(2,2,3)
plot(ty,Y,'b');
xlabel('t(s)')
ylabel('Y(pixle)')

subplot(2,2,4)
% plot(f(2:30),Py(2:30),'r','marker','*') 
plot(f(2:end),Py(2:end));
xlabel('f (Hz)')
ylabel('|P1(f)|')
F1=find(Py==max(Py(2:end)));
hand_cycle = 1/f(F1);
hold on 
text(f(F1),max(Py(2:end)),['[',num2str(roundn(f(F1),-2)),' , ',num2str(roundn(max(Py(2:end)),-2)),']']);
% the second extrem value
location_x = f(F1)*2; location_y = Py(find(f==location_x));
text(location_x ,location_y,['[',num2str(roundn(location_x,-2)),' , ',num2str(roundn(location_y,-2)),']']);
hold off
% righ hand
% get the title center in the figure
hand_t =title(['Monkey', filename, '   right foot motion X&Y']);
v = get(hand_t,'Position');
v(1) = -1; v(2)=15;         
set(hand_t,'Position',v);


[tx,HX,f,P1] = cycle_search(right_hand_x ,M.Fs);
% gtext(['Monkey', filename, '   right foot motion X&Y'])you can set the
% text to any position you want

figure
subplot(2,2,1)
plot(tx,HX,'b');
xlabel('t(s)')
ylabel('X(pixle)')


subplot(2,2,2)
plot(f(2:end),P1(2:end))
xlabel('f (Hz)')
ylabel('|P1(f)|')
Fx=find(P1==max(P1(2:end)));
hold on 
text(f(Fx),max(P1(2:end)),['[',num2str(roundn(f(Fx),-2)),' , ',num2str(roundn(max(P1(2:end)),-2)),']']);
location_x = f(Fx)*2; location_y = P1(find(f==location_x));
text(location_x ,location_y,['[',num2str(roundn(location_x,-2)),' , ',num2str(roundn(location_y,-2)),']']);


[ty,HY,f,Py] = cycle_search(right_hand_y,M.Fs);
subplot(2,2,3)
plot(ty,HY,'b');
xlabel('t(s)')
ylabel('Y(pixle)')

subplot(2,2,4)
% plot(f(2:30),Py(2:30),'r','marker','*') 
plot(f(2:end),Py(2:end));
xlabel('f (Hz)')
ylabel('|P1(f)|')
F1=find(Py==max(Py(2:end)));

hold on 
text(f(F1),max(Py(2:end)),['[',num2str(roundn(f(F1),-2)),' , ',num2str(roundn(max(Py(2:end)),-2)),']']);
% the second extrem value
location_x = f(F1)*2; location_y = Py(find(f==location_x));
text(location_x ,location_y,['[',num2str(roundn(location_x,-2)),' , ',num2str(roundn(location_y,-2)),']']);
hold off
% get the title center in the figure
hand_t = title(['Monkey', filename, '   right hand motion X&Y']);
v      = get(hand_t,'Position');
v(1) = 1; v(2)=11.5;         
set(hand_t,'Position',v);

end

