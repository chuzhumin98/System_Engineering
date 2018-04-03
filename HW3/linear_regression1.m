%% �õ������պ�����ʽΪy = ahat + bhat*x

function [ahat, bhat] = linear_regression1(data, alpha)
    %% ���������a,b�Ĺ���ֵahat��bhat
    Xnorm = data(:,2)-mean(data(:,2));
    Ynorm = data(:,1)-mean(data(:,1));
    bhat = (Xnorm' * Ynorm) / (Xnorm' * Xnorm);
    ahat = mean(data(:,1)) - bhat * mean(data(:,2));
    %% �������ͼ��
    Xmin = min(data(:,2)); %���������еĺ����꼫��Сֵ
    Xmax = max(data(:,2));
    low = Xmin - 0.1*(Xmax-Xmin);
    high = Xmax + 0.1*(Xmax-Xmin);
    X = linspace(low,high,500);
    Y = ahat + bhat * X;
    plot(X, Y, 'b','LineWidth',2)
    hold on
    plot(data(:,2), data(:,1),'r.','MarkerSize',15)
    legend('���ֱ��','���ݵ�','Location','NorthEast')
    saveas(gcf, 'һά�������Ч��ͼ.png')
end