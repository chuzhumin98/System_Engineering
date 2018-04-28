%% PCA的压缩函数，实现对于数据的PCA降维压缩
%  data: N*n 输入数据矩阵
%  rerr: 相对误差限
%  pcs:  n*m，每一列为一个主成分
%  cprs_data: N*m，压缩后的数据
%  cprs_c: 2*n，压缩的常数，第一行为均值，第二列为方差

function [pcs, cprs_data, cprs_c] = pca_compress(data, rerr)
    %% 进行数据的归一化操作
    cprs_c = [mean(data); sqrt(var(data))]; %得到压缩常数
    for i=1:length(data)
        data(i,:) = (data(i,:)-cprs_c(1,:)) ./ cprs_c(2,:);
    end
    %% 进行矩阵的特征值分解，并按特征值从大到小排列
    A = data' * data; %得到一个n*n的矩阵
    [V, Lambda] = eig(A); %得到相应的特征向量和特征值
    V = fliplr(V); %将矩阵倒序排列
    lambda = wrev(diag(Lambda)); %将特征向量倒序排列
    %% 找到所需的特征维数m
    for m = 1:length(lambda)
        if (sum(lambda(1:m))/sum(lambda) >= 1 - rerr)
            break
        end
    end
    m
    pcs = V(:,1:m); %主成分
    cprs_data = data * pcs;
end