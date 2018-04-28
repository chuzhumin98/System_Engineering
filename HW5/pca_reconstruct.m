%% PCA���ݻָ��㷨��������ԭѹ���������
%  pcs:  n*m��ÿһ��Ϊһ�����ɷ�
%  cprs_data: N*m��ѹ���������
%  cprs_c: 2*n��ѹ���ĳ�������һ��Ϊ��ֵ���ڶ���Ϊ����
%  recon_data: N*n���ָ��������

function recon_data = pca_reconstruct(pcs, cprs_data, cprs_c)
   recon_data = cprs_data * pcs' * (pcs * pcs')^(-1); %ע��������빫ʽ���в�ͬ������һ��ת��
   for i = 1:length(recon_data)
       recon_data(i,:) = cprs_c(2,:) .* recon_data(i,:) + cprs_c(1,:);
   end
end