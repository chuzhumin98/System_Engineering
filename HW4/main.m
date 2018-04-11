clear all
[data] = textread('data.txt');
Y = data(:,5); %自变量
X = data(:,1:4); %因变量
alpha = 0.05; %显著性水平
[beta, F, Falpha, CI] = linear_regressionv3(Y, X, alpha);
% plot(X(:,4),Y,'.','MarkerSize',10)