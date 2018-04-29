%% 实现K-means算法，并返回各个数据点所对应的标签

function label = kmeans_clustering(data, num)
    %% 初始中心的选取，采用随机挑3倍数量点，进而在其中挑的方法
    N = length(data); %数据点的个数
    randIndex = ceil(rand(3*num,1)*N);
    randPoints = data(randIndex,:); %随机挑选的3*num个点作为候选聚类中心
    
    label = [];
end