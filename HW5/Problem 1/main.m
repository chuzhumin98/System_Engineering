clear all
%% ������Լ�
%% ������ӻ��Ĳ��Լ���ԭ������ά��
N1 = 10;
n1 = 3;
data1 = rand(N1,n1); %�����������
rerr1 = 0.10; %���������
[pcs1, cprs_data1, cprs_c1] = pca_compress(data1, rerr1);
