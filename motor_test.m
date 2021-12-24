close all
clear 
Fs = 30;
% filename_raw = 'D:\Code\Treadmill\ResultClean\data_60-1104.csv';
filename_raw   = 'D:\Code\Treadmill\ResultClean\data_13_0524.csv';
% raw             = table2array(readtable(filename_raw));
% raw            = table2array(readtable(filename_raw));
[raw,Txt,RAW]  = xlsread('35-11-04.csv');
% interest_columns = ['head_x';'head_y';'neck_x';'neck_y';'back_x';'back_y';'right_hand_x';...
%     'right_hand_y';'right_thigh_x';'right_knee_x';'right_knee_y';'right_foot_x';'right_foot_y';...
% 'tail_x';'tail_y';'neck_p';'tail_p';'back_p'];
M.head_column  = findcolum(Txt,'head_x','head_y');
M.neck_colum   = findcolum(Txt,'neck_x','neck_y');
M.back_colum   = findcolum(Txt,'back_x','back_y');
M.tail_colum   = findcolum(Txt,'tail_x','tail_y');
M.rhand_colum  = findcolum(Txt,'right_hand_x','right_hand_y');
M.rfoot_colum  = findcolum(Txt,'right_foot_x','right_foot_y');
M.thigh_colum  = findcolum(Txt,'right_thigh_x','right_thigh_y');
M.knee_colum   = findcolum(Txt,'right_knee_x','right_knee_y');
M.backH_likelyh = findcolum(Txt,'neck_p','back_p','tail_p');
% raw = table2array(raw);
%     m s m s
% raw = cell2array(raw)
time         = [1 46 1 54];

start_time_m = time(1);% in minutes
start_time_s = time(2);% im seconds
end_time_m   = time(3);
end_time_s   = time(4);

start_line = 30*(60*start_time_m + start_time_s);
end_line   = 30*(60*end_time_m + end_time_s)-1;
str        = [num2str(start_time_m),':',num2str(start_time_s),' to ',num2str(end_time_m),':',num2str(end_time_s)];
filename   = [filename_raw(35:end-8),'-',str];
%1. step length start
[beta,phi] = GaitFilter(raw,start_line,end_line,Fs,M);
%[foot_cycle,hand_cycle,step_length] = StepLength(raw,start_line,end_line,Fs,filename);
[Fx] = StepLength(raw,start_line,end_line,Fs,filename,M);

% 2. knee angle
[knee_anglemax,knee_cycle] = KneeAngle(raw,start_line,end_line,filename,M);
knee_anglemax = [num2str(round(mean(knee_anglemax),2)),'±',num2str(round(std(knee_anglemax),2))]
% 
% %3. back heigh
[back_heigth]  = BackHeigth(raw,start_line,end_line,filename,M);
back_heigth = [num2str(round(mean(back_heigth),2)),'±',num2str(round(std(back_heigth),2))]
% 
% %4. tail position
% [tail] = TailPosition(raw,start_line,end_line,filename);
%5. treadmill speed
[Vt] = TreadmillSpeed(raw,start_line,end_line,Fs,filename);
Vt = Vt/400;


% % data.step_length     = step_length;
% data.foot_frequence  = 1/foot_cycle;
% data.hand_frequence  = 1/hand_cycle;
% data.knee_frequence =  1/knee_cycle;
% 
% data.knee_anglemax  = knee_anglemax;
% data.back_heigth    = back_heigth;
% 
% data.filename       = filename;
% 
% % disp('Do you want to save this data?')
% reply = input('Do you want save this data? Y/N [Y]:','s');
% if reply == 'Y'
%    s = filename(1:9);
%    save(s,'-struct','data');
% end 
% %
disp('game over')

function [column]  = findcolum(Txt,A,B,C)
        switch nargin  
            case 2
                 Aa        = strcmp(Txt(1:end),A);
                 column(1) = find(Aa==1);
            case 3
                Aa        = strcmp(Txt(1:end),A);       
                Ba        = strcmp(Txt(1:end),B);
                column(1) = find(Aa==1);
                column(2) = find(Ba==1);
            otherwise
                Aa        = strcmp(Txt(1:end),A);       
                Ba        = strcmp(Txt(1:end),B);
                Ca        = strcmp(Txt(1:end),C);
                column(1) = find(Aa==1);
                column(2) = find(Ba==1);
                column(3) = find(Ca==1);
        end 
         
end





