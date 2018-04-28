%% 仅实现一般情况的多元线性回归算法

function [beta, F, Falpha, CI] = linear_regressionv1(Y, X, alpha)
    %% 计算出多元线性回归的参数估计
    N = length(Y); %数据点的个数
    n = length(X(1,:)); %特征的维数
    beta = zeros(n, 1); %初始化特征，常数项在最前面
    Xused = X'; %因变量向量
    A = Xused * Xused'; %XX^T
    B = Xused * Y;
    beta = A^(-1) * B; %获得参数向量
    %% 进行F-检验
    Ybar = mean(Y); %Y的均值
    Yhat = beta' * Xused; %估计的自变量的值
    ESS = (Yhat - Ybar) * (Yhat - Ybar)'; %解释平方和
    RSS = (Yhat - Y') * (Yhat - Y')'; %剩余平方和
    F = (N - n - 1) * ESS / n / RSS; %计算出来F值
    Falpha = finv(1-alpha, n, N-n-1);
    CI = []; %置信区间上下移动值
    if (F > Falpha)
        sprintf('我们有%5.3f的信心拒绝原假设，认为X和Y之间满足线性关系', 1-alpha)
        %% 通过F-检验后则计算置信区间
        S = sqrt(RSS/(N-n-1)); %标准差
        z = norminv(1-alpha/2,0,1);
        CI(1) = -S*z; %置信区间上下界的变化值
        CI(2) = S*z;
    else
        sprintf('我们没有足够的信心拒绝原假设')
    end
end