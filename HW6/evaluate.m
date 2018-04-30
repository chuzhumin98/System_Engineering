clear all
load data.mat
%% 分析聚类数目与目标函数大小的关系
for i=2:10
    label = kmeans_clustering(data, i);
    thisJ = 0; %该聚类数下的目标函数
    for k=1:i
        thisClusterData = data(label(:)==i,:); %找出属于该类的样本
        cluster = mean(thisClusterData); %求聚类中心
        deltaClusterData = thisClusterData-repmat(cluster,length(thisClusterData),1); %计算向量之差
        deltaClusterData = deltaClusterData .* deltaClusterData; %求平方差
        thisJ = thisJ + sum(deltaClusterData(:)); %加上该类的误差平方和
    end
    J(i-1) = thisJ;
end
plot(2:10, J, 'b-^','LineWidth',1.5,'MarkerFaceColor','m','MarkerSize',5)
xlabel('聚类数目')
ylabel('J(w,y)')
title('J(w,y) vs k')
box on
saveas(gcf, 'img/J(w,k)_vs_k.png')
figure
%% 分析不同的数据规模下程序耗时的变化
size = [100,200,400,800,1600,3000]; %不同规模的数据点
ks = [3,5,7]; %同时测试不同k的变化关系
for i=1:length(size)
    shuffleOrder = randperm(length(data));
    thisSizeData = data(shuffleOrder(1:size(i)),:);
    for j=1:length(ks)
        tic
        for k=1:5
            label = kmeans_clustering(thisSizeData, ks(j));
        end
        t(j,i) = toc;
    end
end
plot(1:6,t(1,:),'r-^','LineWidth',1.5,'MarkerSize',5)
hold on
plot(1:6,t(2,:),'b-.d','LineWidth',1.5,'MarkerSize',5)
plot(1:6,t(3,:),'k--o','LineWidth',1.5,'MarkerSize',5)
set(gca, 'xTick', 1:6);  
set(gca,'XTickLabel',{'100','200','400','800','1600','3000'})  
xlabel('data size')
ylabel('cost time')
title('time vs size')
legend('k=3','k=5','k=7','Location','NorthWest')
box on; grid on
saveas(gcf, 'img/time-size.png')