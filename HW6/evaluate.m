clear all
load data.mat
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