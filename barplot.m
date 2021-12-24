function [e]=barplot(stepL,monkeyNum)


x=nanmean(stepL);
% b=bar(nanmean(stepL),'FaceColor',[1 1 1],'BarWidth',0.7);
y(1,1:4)=x(1:4);
y(2,1:4)=x(5:8);
y(3,1:4)=x(9:12);
figure;
b     = bar(y,'FaceColor','flat');
% errorbar(nanstd(stepL));
legend('Control','Nose','Gastrointestinal','Striatium')
xticklabels({'Group 1','Group2','Group3'})
color = [0.3,0.75,0.93;0.47,0.67,0.19;1,0.41,0.16;0.72,0.27,1];
% ch = get(b,'children');
Group_in4 = [x(1),x(5),x(9);x(2),x(6),x(10);x(3),x(7),x(11);x(4),x(8),x(12)]'; %Group2 = [x(2),x(6),x(10)];
%Group3 = [x(3),x(7),x(11)];Group4 = [x(4),x(8),x(12)]; 
% Group_mean = [(x(1)+x(5)+x(9))/3,(x(2)+x(6)+x(10))/3,(x(3)+x(7)+x(11))/3,(x(4)+x(8)+x(12))/3];
figure
b_Group=bar(1:4,mean(Group_in4),'FaceColor','flat');
e = std(Group_in4);
hold on
errorbar(1:4,mean(Group_in4),e);
legend('Control','Nose','Gastrointestinal','Striatium')
xticklabels({'Control','Nose','Gastrointestinal','Striatium'})

for k=1:size(y,2)
    b(k).CData         = color(k,:);
    b_Group.CData(k,:) = color(k,:);
end
e=x;
% set(ch{1},'FaceVertexCData',[1;1;1;1;2;2;2;2;3;3;3;3;4;4;4;4])
% [1 1 1;1 0 0;0 1 0;0 0 1;1 1 1;1 0 0;0 1 0;0 0 1;1 1 1;1 0 0;0 1 0;0 0 1])
hold on
% x = 1:monkeyNum;
% errorbar(x,nanmean(stepL),e,'LineStyle','none');
% xticklabels({'#95','#133','#137','#187','#2','#132','#195','#43','#76','#13','#159','#44'})
xtl=get(gca,'XTickLabel'); 
xt=get(gca,'XTick'); 
xtextp=xt;   
yt=get(gca,'YTick'); 
ytextp=(yt(1)-0.2*(yt(2)-yt(1)))*ones(1,length(xt)); 
text(xtextp,ytextp,xtl,'HorizontalAlignment','right','rotation',15,'fontsize',10); 
set(gca,'xticklabel','');
% axis([0 5 0 60])
end