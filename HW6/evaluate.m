clear all
load data.mat
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