clear 
close all
% raw  = struct;
% raw.M02  = M02;  raw.M13 = M13;    raw.M43 = M43;
% raw.M44  = M44;  raw.M76 = M76;    raw.M95 = M95;
% raw.M132 = M132; raw.M133 = M133; raw.M137 = M137;
% raw.M159 = M159; raw.M187 = M187; raw.M195 = M195;
% save raw
monkeyNum = 12;
load('Gait_raw.mat')
c=cell(1,12);
c{1}=M02;
N = 22;
stepL     = zeros(N,monkeyNum); 
stepF     = zeros(N,monkeyNum);
stepV     = zeros(N,monkeyNum);
millV     = zeros(N,monkeyNum);
backH     = zeros(N,monkeyNum);
kneeA     = zeros(N,monkeyNum);


stepL(1:22,1)  = M95(:,1);
stepL(1:10,2)  = M133(:,1);
stepL(1:9,3)   = M137(:,1);
stepL(1:3,4)   = M187(:,1);

stepL(1:13,5)  = M02(:,1);% no much good data
stepL(1:11,6)  = M132(:,1);
stepL(1:7,7)   = M195(:,1);
stepL(1:17,8)  = M43(:,1);

stepL(1:2,9)   = M76(:,1);
stepL(1:6,10)  = M13(:,1);
stepL(1:15,11) = M159(:,1);  %no much good data
stepL(1:19,12) = M44(:,1);
stepl = processData(stepL,monkeyNum);
[e]=barplot(stepl,monkeyNum);
ylabel('step length in cm')
title('12 monkyes steplength on the treadmill')


stepF(1:22,1)  = M95(:,2);
stepF(1:10,2)  = M133(:,2);
stepF(1:9,3)   = M137(:,2);
stepF(1:3,4)   = M187(:,2);

stepF(1:13,5)  = M02(:,2);% no much good data
stepF(1:11,6)  = M132(:,2);
stepF(1:7,7)   = M195(:,2);
stepF(1:17,8)  = M43(:,2);

stepF(1:2,9)   = M76(:,2);
stepF(1:6,10)  = M13(:,2);
stepF(1:15,11) = M159(:,2);  %no much good data
stepF(1:19,12) = M44(:,2);
stepf = processData(stepF,monkeyNum);
[e]=barplot(stepf,monkeyNum);
ylabel('step frequence in HZ')
title('12 monkyes step frquence on the treadmill')



stepV(1:22,1)  = M95(:,3);
stepV(1:10,2)  = M133(:,3);
stepV(1:9,3)   = M137(:,3);
stepV(1:3,4)   = M187(:,3);
stepV(1:13,5)  = M02(:,3);% no much good data
stepV(1:11,6)  = M132(:,3);
stepV(1:7,7)   = M195(:,3);
stepV(1:17,8)  = M43(:,3);
stepV(1:2,9)   = M76(:,3);
stepV(1:6,10)  = M13(:,3);
stepV(1:15,11) = M159(:,3);  %no much good data
stepV(1:19,12) = M44(:,3);
stepv = processData(stepV,monkeyNum);
[e]=barplot(stepv,monkeyNum);
ylabel('step velocity in m/s')
title('12 monkyes walk speed on the treadmill')

millV(1:22,1)  = M95(:,4);
millV(1:10,2)  = M133(:,4);
millV(1:9,3)   = M137(:,4);
millV(1:3,4)   = M187(:,4);
millV(1:13,5)  = M02(:,4);% no much good data
millV(1:11,6)  = M132(:,4);
millV(1:7,7)   = M195(:,4);
millV(1:17,8)  = M43(:,4);
millV(1:2,9)   = M76(:,4);
millV(1:6,10)  = M13(:,4);
millV(1:15,11) = M159(:,4);  %no much good data
millV(1:19,12) = M44(:,4);
millV(millV==0)=nan; 
millV_mean=nanmean(millV);
figure
plot(millV_mean);
hold on
plot(nanmean(stepV))
ylabel('speed in m/s')
[e] = barplot(abs(stepV-millV_mean),monkeyNum);

backH(1:22,1)  = M95(:,5);
backH(1:10,2)  = M133(:,5);
backH(1:9,3)   = M137(:,5);
backH(1:3,4)   = M187(:,5);
backH(1:13,5)  = M02(:,5);% no much good data
backH(1:11,6)  = M132(:,5);
backH(1:7,7)   = M195(:,5);
backH(1:17,8)  = M43(:,5);
backH(1:2,9)   = M76(:,5);
backH(1:6,10)  = M13(:,5);
backH(1:15,11) = M159(:,5);  %no much good data
backH(1:19,12) = M44(:,5);
backh   = processData(backH,monkeyNum);
barplot(backh);
title('Back Heighth')
ylabel('Back Heighth (pixle)')

kneeA(1:22,1)  = M95(:,6);
kneeA(1:10,2)  = M133(:,6);
kneeA(1:9,3)   = M137(:,6);
kneeA(1:3,4)   = M187(:,6);
kneeA(1:13,5)  = M02(:,6);% no much good data
kneeA(1:11,6)  = M132(:,6);
kneeA(1:7,7)   = M195(:,6);
kneeA(1:17,8)  = M43(:,6);
kneeA(1:2,9)   = M76(:,6);
kneeA(1:6,10)  = M13(:,6);
kneeA(1:15,11) = M159(:,6);  %no much good data
kneeA(1:19,12) = M44(:,6);
kneea   = processData(kneeA,monkeyNum);
barplot(barplot(kneea));
title('Knee Angle')

function [update]   = processData(raw,n)
% raw((k+3*theta)<raw)=0;
% raw(raw<(k-3*theta))=0;
raw(raw<0)  = 0;
raw(raw==0) = nan;
% get the data which is in the mean+-3sigma
for MonkeyN=1:n
    k      = nanmean(raw(:,MonkeyN));
    theta  = nanstd(raw(:,MonkeyN));
    for dataN = 1:22
        if  raw(dataN,MonkeyN)>(k+3*theta)||raw(dataN,MonkeyN)<(k-3*theta)
            raw(dataN,MonkeyN)=100;
        end
    end
end

for MonkeyN=1:n
    if 22-numel(find(isnan(raw(:,MonkeyN))))>4
        [u,v]=max(raw(:,MonkeyN));
        [s,t]=min(raw(:,MonkeyN));
        raw(v,MonkeyN)=nan;
        raw(t,MonkeyN)=nan;
    end
end
update=raw;
end

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
