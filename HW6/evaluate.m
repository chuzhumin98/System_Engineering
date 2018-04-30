clear all
load data.mat
%% ����������Ŀ��Ŀ�꺯����С�Ĺ�ϵ
for i=2:10
    label = kmeans_clustering(data, i);
    thisJ = 0; %�þ������µ�Ŀ�꺯��
    for k=1:i
        thisClusterData = data(label(:)==i,:); %�ҳ����ڸ��������
        cluster = mean(thisClusterData); %���������
        deltaClusterData = thisClusterData-repmat(cluster,length(thisClusterData),1); %��������֮��
        deltaClusterData = deltaClusterData .* deltaClusterData; %��ƽ����
        thisJ = thisJ + sum(deltaClusterData(:)); %���ϸ�������ƽ����
    end
    J(i-1) = thisJ;
end
plot(2:10, J, 'b-^','LineWidth',1.5,'MarkerFaceColor','m','MarkerSize',5)
xlabel('������Ŀ')
ylabel('J(w,y)')
title('J(w,y) vs k')
box on
saveas(gcf, 'img/J(w,k)_vs_k.png')
figure
%% ������ͬ�����ݹ�ģ�³����ʱ�ı仯
size = [100,200,400,800,1600,3000]; %��ͬ��ģ�����ݵ�
ks = [3,5,7]; %ͬʱ���Բ�ͬk�ı仯��ϵ
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