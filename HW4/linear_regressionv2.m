%% ʵ��һ������Ķ�Ԫ���Իع��㷨��������Ӧ�Ľ��в�̬���Իع�

function [chat, F, Falpha, CI] = linear_regressionv2(Y, X, alpha)
    %% �жϲ�̬�̶ȣ����õ���Ӧ����������ά��
    %% ��ʼ���жϲ�̬ʱ���������
    N = length(Y); %���ݵ�ĸ���
    n = length(X(1,:)); %������ά��
    Xused = [ones(1,N); X']; %��������������
    A = Xused * Xused'; %XX^T
    [V, Lambda] = eig(A); %�õ���Ӧ����������������ֵ
    V = fliplr(V); %������������
    lambda = wrev(diag(Lambda)); %������������������
    eta = 0.01; %����һ��ɸѡ����ֵ����ֵ
    %% �ҵ����������ά��m
    for m = 1:n+1
        if (sum(lambda(1:m))/sum(lambda) >= 1 - eta)
            break
        end
    end
    %% �ò�̬���Իع���в������ƣ���Ԫ���Իع���m=n+1ʱ��֮�ȼۣ��ڱ����л����֤����
    m = 1;
    Qm = V(:,1:m);
    Z = Qm' * Xused;
    dhat = (Z * Z')^(-1) * Z * Y;
    chat = Qm * dhat; %���յ�ϵ����
    %% ����F-����
    Ybar = mean(Y); %Y�ľ�ֵ
    Yhat = chat' * Xused; %���Ƶ��������ֵ
    ESS = (Yhat - Ybar) * (Yhat - Ybar)'; %����ƽ����
    RSS = (Yhat - Y') * (Yhat - Y')'; %ʣ��ƽ����
    freedom = min(n, m);
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