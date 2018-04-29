%% 实现K-means算法，并返回各个数据点所对应的标签

function label = kmeans_clustering(data, num)
    %% 初始中心的选取，采用随机挑3倍数量点，进而在其中挑的方法
    N = length(data); %数据点的个数
    randIndex = ceil(rand(3*num,1)*N);
    randPoints = data(randIndex,:); %随机挑选的3*num个点作为候选聚类中心
    clusters = randPoints(1,:); %第一个聚类中心点(num*n)
    for k=2:num %依次找出其他初始的聚类中心
        distances = []; %记录距离，采用二范数
        for i=1:num*3
            mydist = [];
            for j=1:k-1
                mydist = [mydist; (clusters(j,:)-randPoints(i,:))*(clusters(j,:)-randPoints(i,:))'];
            end
            distances = [distances; min(mydist)]; %比较的是到各个簇心的最短距离
        end
        [maxValue, maxIndex] = max(distances);
        clusters = [clusters; randPoints(maxIndex,:)];
    end
    label = zeros(1,N); %初始化标签
    %% 进行K-means聚类迭代阶段
    while (true) 
        %% 对样本重新打标签阶段
        for i=1:N
            delta = repmat(data(i,:),num,1)-clusters;
            [minValue, minIndex] = min(sum(delta .* delta,2));
            labelnew(i) = minIndex;
        end
        chabie = sum(abs(labelnew-label)); %计算总的label差别大小，只有为0时才停止迭代
        if (chabie == 0)
             break
        end
        label = labelnew;
        %% 根据样本标签重新确定聚类中心阶段
        for i=1:num
            thisClusterData = data(label(:)==i,:);
            clusters(i,:) = mean(thisClusterData);
        end
    end
end