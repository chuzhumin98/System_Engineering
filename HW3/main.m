clear all
[myData] = textread('data.txt'); %导入数据
alpha = 0.05;
[ahat, bhat, F, Falpha, rsquare, CI] = linear_regression1(myData, alpha);
