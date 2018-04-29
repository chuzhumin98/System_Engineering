%% ʵ��K-means�㷨�������ظ������ݵ�����Ӧ�ı�ǩ

function label = kmeans_clustering(data, num)
    %% ��ʼ���ĵ�ѡȡ�����������3�������㣬�������������ķ���
    N = length(data); %���ݵ�ĸ���
    randIndex = ceil(rand(3*num,1)*N);
    randPoints = data(randIndex,:); %�����ѡ��3*num������Ϊ��ѡ��������
    clusters = randPoints(1,:); %��һ���������ĵ�(num*n)
    for k=2:num %�����ҳ�������ʼ�ľ�������
        distances = []; %��¼���룬���ö�����
        for i=1:num*3
            mydist = [];
            for j=1:k-1
                mydist = [mydist; (clusters(j,:)-randPoints(i,:))*(clusters(j,:)-randPoints(i,:))'];
            end
            distances = [distances; min(mydist)]; %�Ƚϵ��ǵ��������ĵ���̾���
        end
        [maxValue, maxIndex] = max(distances);
        clusters = [clusters; randPoints(maxIndex,:)];
    end
    label = zeros(1,N); %��ʼ����ǩ
    %% ����K-means��������׶�
    while (true) 
        %% ���������´��ǩ�׶�
        for i=1:N
            delta = repmat(data(i,:),num,1)-clusters;
            [minValue, minIndex] = min(sum(delta .* delta,2));
            labelnew(i) = minIndex;
        end
        chabie = sum(abs(labelnew-label)); %�����ܵ�label����С��ֻ��Ϊ0ʱ��ֹͣ����
        if (chabie == 0)
             break
        end
        label = labelnew;
        %% ����������ǩ����ȷ���������Ľ׶�
        for i=1:num
            thisClusterData = data(label(:)==i,:);
            clusters(i,:) = mean(thisClusterData);
        end
    end
end