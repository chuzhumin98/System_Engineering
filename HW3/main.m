clear all
[myData] = textread('data.txt'); %��������
alpha = 0.05;
[ahat, bhat] = linear_regression1(myData, alpha);
