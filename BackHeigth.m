function [back_heigth] = BackHeigth(raw,start_line,end_line,filename,M)
% neck some times is difficult to track by deeplabcut, when we see some
% likely hood is lower than 0.9, these first several lines is to only keep
% the data which is more than 0.9.
likelyhood           = [raw(start_line:end_line,M.backH_likelyh(1));...
    raw(start_line:end_line,M.backH_likelyh(2));...
    raw(start_line:end_line,M.backH_likelyh(3))];
likelyhood(likelyhood<0.9) = 0;
likelyhood           =  reshape(likelyhood,end_line-start_line+1,3);
mutiply_results      = likelyhood(:,1).*likelyhood(:,2).*likelyhood(:,3);
location1_backHeigth = find(mutiply_results~=0);
% neck4/5 back25/26 base28/29     clean 1/3 14/15 17/18

neck(:,1:2)         = raw(location1_backHeigth,M.neck_colum(1):M.neck_colum(2));
back(:,1:2)         = raw(location1_backHeigth,M.back_colum(1):M.back_colum(2));
tail_base(:,1:2)    = raw(location1_backHeigth,M.tail_colum(1):M.tail_colum(2));
location2_backHeigth= find(neck(:,1)>back(:,1)&neck(:,1)>tail_base(:,1));
invalid_line        = length(location2_backHeigth);
% neck                = zeros(invalid_line,2);
% back                = zeros(invalid_line,2);
% tail_base           = zeros(invalid_line,2);

neck_processed(:,1:2)         = neck(location2_backHeigth,:);
back_processed(:,1:2)         = back(location2_backHeigth,:);
tail_base_processed(:,1:2)    = tail_base(location2_backHeigth,:);

back_heigth         = zeros(length(location2_backHeigth),1);
back_heigth_x       = [neck_processed(:,1),back_processed(:,1),tail_base_processed(:,1)];
back_heigth_y       = [neck_processed(:,2),back_processed(:,2),tail_base_processed(:,2)];

x1 = back_processed(:,1);     y1 = back_processed(:,2);
x2 = neck_processed(:,1);     y2 = neck_processed(:,2);
x3 = tail_base_processed(:,1);y3 = tail_base_processed(:,2);

figure
subplot(211)
for i= 1:invalid_line
     plot(back_heigth_x(i,:),back_heigth_y(i,:),'marker','*')
     s = 1/2*(x1(i)*y2(i)+x2(i)*y3(i)+x3(i)*y1(i)-x1(i)*y3(i)-x2(i)*y1(i)-x3(i)*y2(i));
     back_heigth (i,1) = s/norm(neck(i,:)-tail_base(i,:));
     hold on
end
set(gca,'YDir','reverse')
axis([250 600 150 300])
title(['Monkey', filename, ' Back Heighth'])

subplot(212)
back_heigth_x = back_heigth_x-back_heigth_x(:,2)+mean(back_heigth_x(:,2));
back_heigth_y = back_heigth_y-back_heigth_y(:,2)+mean(back_heigth_y(:,2));
for i= 1:invalid_line
     plot(back_heigth_x(i,:),back_heigth_y(i,:),'marker','*')
     s = 1/2*(x1(i)*y2(i)+x2(i)*y3(i)+x3(i)*y1(i)-x1(i)*y3(i)-x2(i)*y1(i)-x3(i)*y2(i));
     back_heigth (i,1) = s/norm(neck(i,:)-tail_base(i,:));
     hold on
end
set(gca,'YDir','reverse')
axis([250 600 150 300])

figure 
subplot(311)
plot((1:length(back_heigth))/30,back_heigth);
ylabel('heigth in (pixles) ')
xlabel('Time(seconds)')
title('Back heigth')
title(['Monkey', filename, ' Back Heighth'])
% set(gca,'YLim',[0 20]);

subplot(312)
bar((1:length(back_heigth))/30,back_heigth);
ylabel('heigth in (pixles) ')
xlabel('Time(seconds)')

subplot(313)
histogram(back_heigth)
title('Histogram')
end

