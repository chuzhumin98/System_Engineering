clear all
[data] = textread('data.txt');
Y = data(:,5); %�Ա���
X = data(:,1:4); %�����
alpha = 0.05; %������ˮƽ
[beta, F, Falpha, CI] = linear_regressionv1(Y, X, alpha);
% [beta, F, Falpha, CI] = linear_regressionv2(Y, X, alpha);
% [beta, F, Falpha, CI] = linear_regressionv3(Y, X, alpha);