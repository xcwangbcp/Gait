function [idx,C] = kmeans_selection(n1,n2,n3,k,data)
index = [n1,n2,n3];
label_set = {'StepLength';
    'StepFrequency';
    'StepSpeed';
    'TreadmillSpeed';
    'BackHeight';
    'KneeAngle'};
data1 = data(:,index);
[idx,C] = kmeans(data1,k);
color_set1 = [249/255,221/255,207/255
    230/255,241/255,213/255
    200/255,235/255,248/255
    252/255,240/255,202/255];

color_set2 = [255/255,0/255,0/255
    255/255,51/255,0/255
    255/255,102/255,0/255
    255/255,153/255,0/255
    255/255,255/255,0/255
    153/255,255/255,0/255
    0/255,255/255,0/255
    0/255,255/255,255/255
    0/255,0/255,255/255
    102/255,0/255,255/255
    255/255,0/255,255/255
    255/255,0/255,102/255];

for i = 1:k
    color = color_set1(i,:);
    scatter3(C(i,1),C(i,2),C(i,3),100,color,'*');
    xlabel(label_set(n1,:))
    ylabel(label_set(n2,:))
    zlabel(label_set(n3,:))
    hold on
end

for i = 1:size(data,1)
    color = color_set1(idx(i),:);
    scatter = scatter3(data1(i,1),data1(i,2),data1(i,3),1500,color,'filled');
    alpha(scatter,.3)
    hold on
end

for i = 1:size(data,1)
    if data(i,7) == 2
        color = color_set2(1,:);
        scatter3(data1(i,1),data1(i,2),data1(i,3),20,color,'filled')
        text(data1(i,1),data1(i,2),data1(i,3),'2')
        hold on
    elseif data(i,7) == 13
        color = color_set2(2,:);
        scatter3(data1(i,1),data1(i,2),data1(i,3),20,color,'filled')
        text(data1(i,1),data1(i,2),data1(i,3),'13')
        hold on
    elseif data(i,7) == 43
        color = color_set2(3,:);
        scatter3(data1(i,1),data1(i,2),data1(i,3),20,color,'filled')
        text(data1(i,1),data1(i,2),data1(i,3),'43')
        hold on
    elseif data(i,7) == 44
        color = color_set2(4,:);
        scatter3(data1(i,1),data1(i,2),data1(i,3),20,color,'filled')
        text(data1(i,1),data1(i,2),data1(i,3),'44')
        hold on
    elseif data(i,7) == 76
        color = color_set2(5,:);
        scatter3(data1(i,1),data1(i,2),data1(i,3),20,color,'filled')
        text(data1(i,1),data1(i,2),data1(i,3),'76')
        hold on
    elseif data(i,7) == 95
        color = color_set2(6,:);
        scatter3(data1(i,1),data1(i,2),data1(i,3),20,color,'filled')
        text(data1(i,1),data1(i,2),data1(i,3),'95')
        hold on
    elseif data(i,7) == 132
        color = color_set2(7,:);
        scatter3(data1(i,1),data1(i,2),data1(i,3),20,color,'filled')
        text(data1(i,1),data1(i,2),data1(i,3),'132')
        hold on
    elseif data(i,7) == 133
        color = color_set2(8,:);
        scatter3(data1(i,1),data1(i,2),data1(i,3),20,color,'filled')
        text(data1(i,1),data1(i,2),data1(i,3),'133')
        hold on
    elseif data(i,7) == 137
        color = color_set2(9,:);
        scatter3(data1(i,1),data1(i,2),data1(i,3),20,color,'filled')
        text(data1(i,1),data1(i,2),data1(i,3),'137')
        hold on
    elseif data(i,7) == 159
        color = color_set2(10,:);
        scatter3(data1(i,1),data1(i,2),data1(i,3),20,color,'filled')
        text(data1(i,1),data1(i,2),data1(i,3),'159')
        hold on
    elseif data(i,7) == 187
        color = color_set2(11,:);
        scatter3(data1(i,1),data1(i,2),data1(i,3),20,color,'filled')
        text(data1(i,1),data1(i,2),data1(i,3),'187')
        hold on
    elseif data(i,7) == 195
        color = color_set2(12,:);
        scatter3(data1(i,1),data1(i,2),data1(i,3),20,color,'filled')
        text(data1(i,1),data1(i,2),data1(i,3),'195')
        hold on
    end
end
hold off

       
       
       
       
       
        
    