clear all
%% 构造测试集
%% 构造可视化的测试集（原数据三维）
N1 = 200;
N2 = 200;
n1 = 3;
data1 = rand(N1+N2,n1); %随机生成数据
data1(N1+1:N1+N2,2) = data1(N1+1:N1+N2,2) - 1;
data1(N1+1:N1+N2,3) = data1(N1+1:N1+N2,3) - 1;
rerr1 = 0.10; %设置误差限
[pcs1, cprs_data1, cprs_c1] = pca_compress(data1, rerr1);
% plot3(data1(1:N1,1),data1(1:N1,2),data1(1:N1,3),'r.')
% hold on
% plot3(data1(N1+1:N1+N2,1),data1(N1+1:N1+N2,2),data1(N1+1:N1+N2,3),'b.')
% title('三维空间中的原数据')
% saveas(gcf, 'PCA_Initial.png')
% box on; grid on
% if (length(cprs_data1(1,:)) == 2)
%     figure
%     plot(cprs_data1(1:N1,1),cprs_data1(1:N1,2),'r.')
%     hold on
%     plot(cprs_data1(N1+1:N1+N2,1),cprs_data1(N1+1:N1+N2,2),'b.')
%     xlabel('第一主成分')
%     ylabel('第二主成分')
%     title('PCA压缩后的二维空间投影数据点')
%     saveas(gcf, 'PCA_Compress.png')
% end
recon_data1 = pca_reconstruct(pcs1, cprs_data1, cprs_c1);
%% 构造测试集，体会数据压缩的效果
N20 = 1000;
n2 = 1000;
data2 = rand(N20,n2); %随机生成数据
rerr2 = 0.10; %设置误差限
[pcs2, cprs_data2, cprs_c2] = pca_compress(data2, rerr2);
recon_data2 = pca_reconstruct(pcs2, cprs_data2, cprs_c2);