clear all
%% 导入数据并将数据绘制到平面图中
load data.mat
% plot(data(:,1),data(:,2),'b.')
% xlabel('feature 1')
% ylabel('feature 2')
% title('data samples distribution')
% saveas(gcf, 'img/samples distribution.png')
label = kmeans_clustering(data, 2);