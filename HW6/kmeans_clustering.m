%% ʵ��K-means�㷨�������ظ������ݵ�����Ӧ�ı�ǩ

function label = kmeans_clustering(data, num)
    %% ��ʼ���ĵ�ѡȡ�����������3�������㣬�������������ķ���
    N = length(data); %���ݵ�ĸ���
    randIndex = ceil(rand(3*num,1)*N);
    randPoints = data(randIndex,:); %�����ѡ��3*num������Ϊ��ѡ��������
    
    label = [];
end