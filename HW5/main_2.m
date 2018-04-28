clear all
%% 导入数据及数据预处理部分
[counties] = xlsread('counties.xlsx');
X = counties(:,1:14); %自变量
Y = counties(:,15); %因变量
Ybar = mean(Y);
Y = Y - Ybar;
rerr = 0.10; %设置误差限
%% PCA降维
[pcs, cprs_data, cprs_c] = pca_compress(X, rerr);
%% 多元线性回归
[tildebeta, F, Falpha, CI] = linear_regressionv1(Y, cprs_data, 0.05); %设置显著性水平为-0.95
%% 数据还原
beta = pcs * tildebeta; %还原到原始空间
y0 = Ybar - sum(beta' .* cprs_c(1,:) ./ cprs_c(2,:)); %计算常数项
beta0 = beta' ./ cprs_c(2,:);
%% 低维空间中绘图
% plot(cprs_data(:,1),Y,'b.')
% xlabel('第一主成分')
% ylabel('因变量取值')
% title('因变量 vs 第一主成分')
% saveas(gcf, 'pca1-Y.png')
% figure
% plot(cprs_data(:,2),Y,'b.')
% xlabel('第二主成分')
% ylabel('因变量取值')
% title('因变量 vs 第二主成分')
% saveas(gcf, 'pca2-Y.png')
% plot(cprs_data(:,9),Y,'b.')
% xlabel('第九主成分')
% ylabel('因变量取值')
% title('因变量 vs 第九主成分')
% saveas(gcf, 'pca9-Y.png')