%% ʵ��һ������Ķ�Ԫ���Իع��㷨��������Ӧ�Ľ��в�̬���Իع�,
% ��v2��Ҫ�������Ǽ��������ݱ�׼��

function [beta, F, Falpha, CI] = linear_regressionv3(Y, X, alpha)
    %% �жϲ�̬�̶ȣ����õ���Ӧ����������ά��
    %% ��ʼ���жϲ�̬ʱ��������ݣ�ͬʱ���й�һ������
    N = length(Y); %���ݵ�ĸ���
    n = length(X(1,:)); %������ά��
    mu = [0]; %���滯ʱ�ľ�ֵ
    sigma = [1]; %���滯ʱ�ı�׼��
    Xused = [ones(1,N)]; %��һ�����������Ա�������
    for i = 1:n
        mu = [mu; mean(X(:,i))];
        sigma = [sigma; sqrt(var(X(:,i)))];
        Xused = [Xused; (X(:,i)' - mean(X(:,i)))/sqrt(var(X(:,i)))];
    end
    A = Xused * Xused'; %XX^T
    [V, Lambda] = eig(A); %�õ���Ӧ����������������ֵ
    V = fliplr(V); %������������
    lambda = wrev(diag(Lambda)); %������������������
    lambda
    eta = 0.01; %����һ��ɸѡ����ֵ����ֵ
    %% �ҵ����������ά��m
    for m = 1:n+1
        if (sum(lambda(1:m))/sum(lambda) >= 1 - eta)
            break
        end
    end
    %% �ò�̬���Իع���в������ƣ���Ԫ���Իع���m=n+1ʱ��֮�ȼۣ��ڱ����л����֤����
    m
    Qm = V(:,1:m);
    Z = Qm' * Xused;
    dhat = (Z * Z')^(-1) * Z * Y;
    chat = Qm * dhat; %���յ�ϵ����
    %% �����õĲ������й�һ���ķ��任
    beta = zeros(n+1, 1); %��ʼ������������������ǰ��
    beta = chat;
    beta(1) = chat(1)-mu' * (chat ./ sigma); %�õ����任��ĳ���ֵ
    beta(2:n+1) = chat(2:n+1) ./ sigma(2:n+1);
    %% ����F-����
    Ybar = mean(Y); %Y�ľ�ֵ
    Yhat = chat' * Xused; %���Ƶ��������ֵ
    ESS = (Yhat - Ybar) * (Yhat - Ybar)'; %����ƽ����
    RSS = (Yhat - Y') * (Yhat - Y')'; %ʣ��ƽ����
    freedom = min(n, m); %ȷ�����ɶ�
    F = (N - freedom - 1) * ESS / freedom / RSS; %�������Fֵ
    Falpha = finv(1-alpha, freedom, N-freedom-1);
    CI = []; %�������������ƶ�ֵ
    if (F > Falpha)
        sprintf('������%5.3f�����ľܾ�ԭ���裬��ΪX��Y֮���������Թ�ϵ', 1-alpha)
        %% ͨ��F-������������������
        S = sqrt(RSS/(N-freedom-1)); %��׼��
        z = norminv(1-alpha/2,0,1);
        CI(1) = -S*z; %�����������½�ı仯ֵ
        CI(2) = S*z;
    else
        sprintf('����û���㹻�����ľܾ�ԭ����')
    end
end