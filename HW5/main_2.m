clear all
%% �������ݼ�����Ԥ������
[counties] = xlsread('counties.xlsx');
X = counties(:,1:14); %�Ա���
Y = counties(:,15); %�����
Ybar = mean(Y);
Y = Y - Ybar;
rerr = 0.10; %���������
%% PCA��ά
[pcs, cprs_data, cprs_c] = pca_compress(X, rerr);
%% ��Ԫ���Իع�
[tildebeta, F, Falpha, CI] = linear_regressionv1(Y, cprs_data, 0.05); %����������ˮƽΪ-0.95
%% ���ݻ�ԭ
beta = pcs * tildebeta; %��ԭ��ԭʼ�ռ�
y0 = Ybar - sum(beta' .* cprs_c(1,:) ./ cprs_c(2,:)); %���㳣����
beta0 = beta' ./ cprs_c(2,:);
%% ��ά�ռ��л�ͼ
% plot(cprs_data(:,1),Y,'b.')
% xlabel('��һ���ɷ�')
% ylabel('�����ȡֵ')
% title('����� vs ��һ���ɷ�')
% saveas(gcf, 'pca1-Y.png')
% figure
% plot(cprs_data(:,2),Y,'b.')
% xlabel('�ڶ����ɷ�')
% ylabel('�����ȡֵ')
% title('����� vs �ڶ����ɷ�')
% saveas(gcf, 'pca2-Y.png')
% plot(cprs_data(:,9),Y,'b.')
% xlabel('�ھ����ɷ�')
% ylabel('�����ȡֵ')
% title('����� vs �ھ����ɷ�')
% saveas(gcf, 'pca9-Y.png')