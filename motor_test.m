close all
clear 
Fs = 30;
filename_raw = 'D:\Code\Treadmill\ResultClean\data_13_0524.csv';
% filename_raw    = 'D:\Code\Treadmill\ResultRawww\.csv';
raw             = table2array(readtable(filename_raw));
% clean = table2array(readtable(filename_raw));
% raw = table2array(raw);
%     m s m s
time         = [ 1 46 1 54 ];
start_time_m = time(1);% in minutes
start_time_s = time(2);% im seconds
end_time_m   = time(3);
end_time_s   = time(4);

strat_line = 30*(60*start_time_m + start_time_s);
end_line   = 30*(60*end_time_m + end_time_s)-1;
str=[num2str(start_time_m),':',num2str(start_time_s),' to ',num2str(end_time_m),':',num2str(end_time_s)];
filename = [filename_raw(36:end-8),'-',str];
%1. step length start
[foot_cycle,hand_cycle,step_length] = StepLength(raw,strat_line,end_line,Fs,filename);

% 2. knee angle
[knee_anglemax,knee_cycle] = KneeAngle(raw,strat_line,end_line,filename);
knee_anglemax = mean(knee_anglemax);
% %3. back heigh
[back_heigth]  = BackHeigth(raw,strat_line,end_line,filename);
back_heigth    = mean(back_heigth);
% 
[Vt] = TreadmillSpeed(raw,strat_line,end_line,Fs,filename);
Vt = Vt/4; % change into cm/s
% %4. tail position
% [tail] = TailPosition(raw,strat_line,end_line,filename);
data.step_length     = step_length;
data.foot_frequence  = 1/foot_cycle;
data.hand_frequence  = 1/hand_cycle;
data.knee_frequence =  1/knee_cycle;

data.knee_anglemax  = knee_anglemax;
data.back_heigth    = back_heigth;

data.filename       = filename;

% disp('Do you want to save this data?')
% reply = input('Do you want save this data? Y/N [Y]:','s');
% if reply == 'Y'
%    s = filename(1:9);
%    save(s,'-struct','data');
% end 


disp('game over')



