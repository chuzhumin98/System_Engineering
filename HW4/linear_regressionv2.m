%% 实现一般情况的多元线性回归算法，并自适应的进行病态线性回归

function [chat, F, Falpha, CI] = linear_regressionv2(Y, X, alpha)
    %% 判断病态程度，并得到相应的所需特征维度
    %% 初始化判断病态时所需的数据
    N = length(Y); %数据点的个数
    n = length(X(1,:)); %特征的维数
    Xused = [ones(1,N); X']; %增广的因变量向量
    A = Xused * Xused'; %XX^T
    [V, Lambda] = eig(A); %得到相应的特征向量和特征值
    V = fliplr(V); %将矩阵倒序排列
    lambda = wrev(diag(Lambda)); %将特征向量倒序排列
    eta = 0.01; %设置一个筛选特征值的阈值
    %% 找到所需的特征维数m
    for m = 1:n+1
        if (sum(lambda(1:m))/sum(lambda) >= 1 - eta)
            break
        end
    end
    %% 用病态线性回归进行参数估计（多元线性回归在m=n+1时与之等价，在报告中会给予证明）
    Qm = V(:,1:m);
    Z = Qm' * Xused;
    dhat = (Z * Z')^(-1) * Z * Y;
    chat = Qm * dhat; %最终的系数表
    %% 进行F-检验
    Ybar = mean(Y); %Y的均值
    Yhat = chat' * Xused; %估计的自变量的值
    ESS = (Yhat - Ybar) * (Yhat - Ybar)'; %解释平方和
    RSS = (Yhat - Y') * (Yhat - Y')'; %剩余平方和
    freedom = m; %确定自由度
    m
    lambda
	if (sum(lambda(m+1:n+1)) < 1e-12)
		freedom = m - 1;
	end
    F = (N - freedom - 1) * ESS / freedom / RSS; %计算出来F值
    Falpha = finv(1-alpha, freedom, N-freedom-1);
    CI = []; %置信区间上下移动值
    if (F > Falpha)
        sprintf('我们有%5.3f的信心拒绝原假设，认为X和Y之间满足线性关系', 1-alpha)
        %% 通过F-检验后则计算置信区间
        S = sqrt(RSS/(N-freedom-1)); %标准差
        z = norminv(1-alpha/2,0,1);
        CI(1) = -S*z; %置信区间上下界的变化值
        CI(2) = S*z;
    else
        sprintf('我们没有足够的信心拒绝原假设')
    end
end