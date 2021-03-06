%% 得到的最终函数形式为y = ahat + bhat*x

function [ahat, bhat, F, Falpha, rsquare, CI] = linear_regression1(data, alpha)
    %% 计算出参数a,b的估计值ahat和bhat
    Xnorm = data(:,2)-mean(data(:,2));
    Ynorm = data(:,1)-mean(data(:,1));
    bhat = (Xnorm' * Ynorm) / (Xnorm' * Xnorm);
    ahat = mean(data(:,1)) - bhat * mean(data(:,2));
    sprintf('回归直线方程: y = %8.5f + %8.5f * x\n', ahat, bhat)
    %% 用F检验进行回归方程检验
    N = length(data);
    Falpha = finv(1-alpha, 1, N-2);
    Yhat = ahat + bhat*data(:,2);
    ESS = (Yhat - mean(data(:,1)))'* (Yhat - mean(data(:,1))); %解释平方和
    RSS = (data(:,1) - Yhat)' * (data(:,1) - Yhat); %剩余平方和
    rsquare = ESS/(ESS+RSS);
    F = ESS * (N-2) / RSS; %计算F值
    if (F > Falpha)
        sprintf('我们有%5.3f的信心拒绝原假设，认为x和y之间满足线性关系', 1-alpha)
        %% 计算置信区间
        S = sqrt(RSS/(N-2));
        z = norminv(1-alpha/2,0,1);
        CI(1) = -S*z; %置信区间上下界的变化值
        CI(2) = S*z;
        %% 绘制相关图像
        Xmin = min(data(:,2)); %所给数据中的横坐标极大极小值
        Xmax = max(data(:,2));
        low = Xmin - 0.1*(Xmax-Xmin);
        high = Xmax + 0.1*(Xmax-Xmin);
        X = linspace(low,high,500);
        Y = ahat + bhat * X;
        plot(X, Y, 'b','LineWidth',2)
        hold on
        plot(data(:,2), data(:,1),'r.','MarkerSize',15)
        plot(X, Y+CI(1), 'm','LineWidth',1)
        plot(X, Y+CI(2), 'm', 'LineWidth',1)
        legend('拟合直线','数据点','置信区间上下边界','Location','NorthEast')
        xlabel('x坐标轴')
        ylabel('y坐标轴')
        title('一元线性回归拟合效果图')
        box on
        grid on
        saveas(gcf, '一维线性拟合效果图.png')
    else
        sprintf('我们没有足够的信心拒绝原假设')
    end
end