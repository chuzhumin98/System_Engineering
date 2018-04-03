%% �õ������պ�����ʽΪy = ahat + bhat*x

function [ahat, bhat, F, Falpha] = linear_regression1(data, alpha)
    %% ���������a,b�Ĺ���ֵahat��bhat
    Xnorm = data(:,2)-mean(data(:,2));
    Ynorm = data(:,1)-mean(data(:,1));
    bhat = (Xnorm' * Ynorm) / (Xnorm' * Xnorm);
    ahat = mean(data(:,1)) - bhat * mean(data(:,2));
    sprintf('�ع�ֱ�߷���: y = %8.5f + %8.5f * x\n', ahat, bhat)
    %% ��F������лع鷽�̼���
    N = length(data);
    Falpha = finv(1-alpha, 1, N-2);
    Yhat = ahat + bhat*data(:,2);
    ESS = (Yhat - mean(data(:,1)))'* (Yhat - mean(data(:,1))); %����ƽ����
    RSS = (data(:,1) - Yhat)' * (data(:,1) - Yhat); %ʣ��ƽ����
    F = ESS * (N-2) / RSS; %����Fֵ
    if (F > Falpha)
        sprintf('������%5.3f�����ľܾ�ԭ���裬��Ϊx��y֮���������Թ�ϵ', 1-alpha)
    else
        sprintf('����û���㹻�����ľܾ�ԭ����')
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
end