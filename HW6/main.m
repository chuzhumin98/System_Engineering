clear all
%% �������ݲ������ݻ��Ƶ�ƽ��ͼ��
load data.mat
plot(data(:,1),data(:,2),'b.')
xlabel('feature 1')
ylabel('feature 2')
title('data samples distribution')
saveas(gcf, 'img/samples distribution.png')
color = ['m.';'c.';'r.';'g.';'b.';'k.';'y.'];
for i=2:7
    label = kmeans_clustering(data, i);   
    if (i ~= 2)
        figure
    end  
    for j = 1:i
        plot(data(label(:)==j,1), data(label(:)==j,2),color(j,:))
        hold on
    end
    xlabel('feature 1')
    ylabel('feature 2')
    title(strcat('k-means with k=',num2str(i)))
    saveas(gcf, strcat('img/k-means with k=',num2str(i),'_3.png'))
end
