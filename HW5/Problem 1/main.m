clear all
%% 构造测试集
%% 构造可视化的测试集（原数据三维）
N1 = 10;
n1 = 3;
data1 = rand(N1,n1); %随机生成数据
rerr1 = 0.10; %设置误差限
[pcs1, cprs_data1, cprs_c1] = pca_compress(data1, rerr1);
