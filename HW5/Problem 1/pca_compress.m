%% PCA��ѹ��������ʵ�ֶ������ݵ�PCA��άѹ��
%  data: N*n �������ݾ���
%  rerr: ��������
%  pcs:  n*m��ÿһ��Ϊһ�����ɷ�
%  cprs_data: N*m��ѹ���������
%  cprs_c: 2*n��ѹ���ĳ�������һ��Ϊ��ֵ���ڶ���Ϊ����

function [pcs, cprs_data, cprs_c] = pca_compress(data, rerr)
    %% �������ݵĹ�һ������
    cprs_c = [mean(data); sqrt(var(data))]; %�õ�ѹ������
    for i=1:length(data)
        data(i,:) = (data(i,:)-cprs_c(1,:)) ./ cprs_c(2,:);
    end
    %% ���о��������ֵ�ֽ⣬��������ֵ�Ӵ�С����
    A = data' * data; %�õ�һ��n*n�ľ���
    [V, Lambda] = eig(A); %�õ���Ӧ����������������ֵ
    V = fliplr(V); %������������
    lambda = wrev(diag(Lambda)); %������������������
    %% �ҵ����������ά��m
    for m = 1:length(lambda)
        if (sum(lambda(1:m))/sum(lambda) >= 1 - rerr)
            break
        end
    end
    m
    pcs = V(:,1:m); %���ɷ�
    cprs_data = data * pcs;
end