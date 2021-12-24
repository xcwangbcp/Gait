function [tail] = TailPosition(raw,strat_line,end_line,filename)
%tail 28/29 49/50 52/53 55/56 58/59  clean: 17/18 29/30 32/33 35/36 38/39
% tail = zeros(end_line-strat_line+1,10);
tail = [raw(strat_line:end_line,28:29),raw(strat_line:end_line,49:50),raw(strat_line:end_line,52:53),...
    raw(strat_line:end_line,55:56),raw(strat_line:end_line,58:59)];
% tail_x =  zeros(end_line-strat_line+1,5);
% tail_y =  zeros(end_line-strat_line+1,5);

tail_x = [tail(:,1),tail(:,3),tail(:,5),tail(:,7),tail(:,9)];
tail_y = [tail(:,2),tail(:,4),tail(:,6),tail(:,8),tail(:,10)];




figure
subplot(221)
for i= 1:length(tail)
    plot(tail_x(i,:),tail_y(i,:),'marker','*')
    hold on
end 
set(gca,'YDir','reverse')
axis([150 450  180 380])
title(['Monkey', filename, ' Tail Position'])
% hand_t = title(['Monkey', filename, ' Tail Position']);
% v = get(hand_t,'Position');
% v(1) = 310; v(2)=75;         %????????????????????????????????:P 
% set(hand_t,'Position',v);
% hold off

subplot(222)
% for i=1:15
%     f = fit(tail_x(i,:)',tail_y(i,:)','poly2');% Linear polynomial curve
%     plot(f,mean(tail_x(i,:)),mean(tail_y(i,:)))
%     hold on
% end
x = mean(tail_x); y= mean(tail_y);
f = fit(x',y','poly2');
plot(f,x,y);
set(gca,'YDir','reverse')
axis([150 450  180 380])

subplot(223)
tail_x = tail_x-tail_x(:,1)+mean(tail_x(:,1));
tail_y = tail_y-tail_y(:,1)+mean(tail_y(:,1));
% plot(tail(:,1),tail(:,2),tail(:,3),tail(:,4),tail(:,5),tail(:,6),tail(:,7),tail(:,8),tail(:,9),tail(:,10))
for i= 1:length(tail)
    plot(tail_x(i,:),tail_y(i,:),'marker','o')
    hold on
end 
set(gca,'YDir','reverse')
xlabel('X coordinate in pixles')
ylabel('Y coordinate in pixles')
axis([150 450  180 380])




subplot(224)
scatter(tail(:,1),tail(:,2),4) %tail(:,3),tail(:,4),tail(:,5),tail(:,6),tail(:,7),tail(:,8),tail(:,9),tail(:,10));
hold on
scatter(tail(:,3),tail(:,4),4);
scatter(tail(:,5),tail(:,6),4);
scatter(tail(:,7),tail(:,8),4);
scatter(tail(:,9),tail(:,10),4);
set(gca,'YDir','reverse')
xlabel('X coordinate in pixles')
ylabel('Y coordinate in pixles')
axis([150 450  180 380])
box on
% title('Monkey 159 tail position,head to right')
% hold off
end

