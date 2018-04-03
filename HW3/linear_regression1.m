%% 得到的最终函数形式为y = ahat + bhat*x

function [ahat, bhat] = linear_regression1(data, alpha)
    %% 计算出参数a,b的估计值ahat和bhat
    Xnorm = data(:,2)-mean(data(:,2));
    Ynorm = data(:,1)-mean(data(:,1));
    bhat = (Xnorm' * Ynorm) / (Xnorm' * Xnorm);
    ahat = mean(data(:,1)) - bhat * mean(data(:,2));
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
    legend('拟合直线','数据点','Location','NorthEast')
    saveas(gcf, '一维线性拟合效果图.png')
end