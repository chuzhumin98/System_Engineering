%% PCA数据恢复算法，用来还原压缩后的数据
%  pcs:  n*m，每一列为一个主成分
%  cprs_data: N*m，压缩后的数据
%  cprs_c: 2*n，压缩的常数，第一行为均值，第二列为方差
%  recon_data: N*n，恢复后的数据

function recon_data = pca_reconstruct(pcs, cprs_data, cprs_c)
   recon_data = cprs_data * pcs' * (pcs * pcs')^(-1); %注意矩阵定义与公式略有不同，做了一个转置
   for i = 1:length(recon_data)
       recon_data(i,:) = cprs_c(2,:) .* recon_data(i,:) + cprs_c(1,:);
   end
end