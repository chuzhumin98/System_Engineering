clear all
[myData] = textread('data.txt'); %��������
alpha = 0.05;
[ahat, bhat, F, Falpha, rsquare, CI] = linear_regression1(myData, alpha);
