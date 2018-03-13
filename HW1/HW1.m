clear all %clear useless data if existed
%% for problem 1
mydata = importdata('data.mat'); %import data we concern about
mydataN = length(mydata); %store the length of data
time = linspace(1,mydataN,mydataN) / (2*60); %the time axis united by hour
plot(time, mydata,'-','Color',[0 0.8 0.4],'LineWidth',0.8) %plot the curve
xlim([0 24]) %set the limit of x axis
set(gca,'xtick',linspace(4,24,6)) %set the tick of x axis
ylim([0 7500]) %set the limit of y axis
set(gca,'ytick',linspace(1,7,7).*1000) %set the tick of y axis
title('高速公路流量随时间变化曲线') %set the title of the graph
xlabel('时间(h)') %set the label of x axis
ylabel('流量(辆/h)') %set the label of y axis
box on
grid on
set(gca,'FontName','等线','FontSize',18,'LineWidth',1) %set more details for axis
set(gcf,'position',[100,100,800,800]) %set the size and position of graph
set(gca,'position',[.13 .17 .80 .74]); %set the position of the axis
saveas(gcf, '初始流量变化曲线.png') %save this graph in disk
figure

%% for problem 2
Nset = [10, 30]; 
for (k = 1:2)
    avgsmooth = [];
    for (n = 1:mydataN)
        if (n == 1) 
            avgsmooth = [avgsmooth; mydata(n)]; %when n=1,just append itself
        else
            if (n <= Nset(k))
                avgsmooth = [avgsmooth; mean(mydata(1:n-1))]; %when 1<n<=N, mean all the history data
            else
                avgsmooth = [avgsmooth; mean(mydata(n-Nset(k):n-1))]; %otherwise, using the last N data to mean
            end
        end
    end
    if (k == 1)
        plot(time, avgsmooth,'-','Color',[0 0.8 0.4],'LineWidth',0.8) %plot the curve
        hold on
    else
        plot(time, avgsmooth,'-','Color',[0.8 0.33 0.33],'LineWidth',0.8) %plot the curve
    end
end
xlim([0 24]) %set the limit of x axis
set(gca,'xtick',linspace(4,24,6)) %set the tick of x axis
ylim([0 7500]) %set the limit of y axis
set(gca,'ytick',linspace(1,7,7).*1000) %set the tick of y axis
title('移动平均方法平滑后流量随时间变化曲线') %set the title of the graph
xlabel('时间(h)') %set the label of x axis
ylabel('流量(辆/h)') %set the label of y axis
legend({'N=10','N=30'},'Location','NorthEast')
box on
grid on
set(gca,'FontName','等线','FontSize',18,'LineWidth',1) %set more details for axis
set(gcf,'position',[100,100,800,800]) %set the size and position of graph
set(gca,'position',[.13 .17 .80 .74]); %set the position of the axis
saveas(gcf, '移动平均法的流量变化曲线.png') %save this graph in disk
figure

%% problem 3
%% next we'll compare for different alpha
alphaset = [0.2; 0.05];
for k = 1:2
   expsmooth = [mydata(1)]; %store the smooth result
   alpha = alphaset(k);
   alpha_1 = 1 - alpha;
   for (n = 2:mydataN) 
       St = alpha*mydata(n-1)+alpha_1*expsmooth(n-1); %use this formula to smooth
       expsmooth = [expsmooth; St];
   end
   if (k==1)
       plot(time, expsmooth,'-','Color',[0.2 0.8 0.2],'LineWidth',0.8) %plot the curve
       hold on
   else
       plot(time, expsmooth,'-','Color',[0.9 0.3 0.3],'LineWidth',0.8) %plot the curve
   end
end
xlim([0 24]) %set the limit of x axis
set(gca,'xtick',linspace(4,24,6)) %set the tick of x axis
ylim([0 7500]) %set the limit of y axis
set(gca,'ytick',linspace(1,7,7).*1000) %set the tick of y axis
title('指数平滑法在不同平滑常数下的流量变化曲线') %set the title of the graph
xlabel('时间(h)') %set the label of x axis
ylabel('流量(辆/h)') %set the label of y axis
legend({'\alpha = 0.2','\alpha = 0.05'},'Location','NorthEast')
box on
grid on
set(gca,'FontName','等线','FontSize',18,'LineWidth',1) %set more details for axis
set(gcf,'position',[100,100,800,800]) %set the size and position of graph
set(gca,'position',[.13 .17 .80 .74]); %set the position of the axis
saveas(gcf, '指数平滑法在不同平滑常数下的流量变化曲线.png') %save this graph in disk
figure

%% next we'll compare different exponential's effects
alpha = 0.2;
alpha_1 = 1 - alpha;
expsmooth = [mydata(1), mydata(1)]; %store different exponent's smooth result
for (n = 2:mydataN) 
    St1 = alpha*mydata(n-1)+alpha_1*expsmooth(n-1); %calculate the first exponent smooth result
    St2 = alpha*St1+alpha_1*expsmooth(n-1,2); %calculate the second exponent smooth result
    expsmooth = [expsmooth; St1, St2]; %append the smooth result at end
end
plot(time, expsmooth(:,1),'-','Color',[0.2 0.9 0.8],'LineWidth',0.8) %plot the curve of exp 1
hold on
plot(time, expsmooth(:,2),'-','Color',[0.5 0.4 0.3],'LineWidth',0.8) %plot the curve of exp 2
xlim([0 24]) %set the limit of x axis
set(gca,'xtick',linspace(4,24,6)) %set the tick of x axis
ylim([0 7500]) %set the limit of y axis
set(gca,'ytick',linspace(1,7,7).*1000) %set the tick of y axis
title('指数平滑法在不同指数下的流量变化曲线') %set the title of the graph
xlabel('时间(h)') %set the label of x axis
ylabel('流量(辆/h)') %set the label of y axis
legend({'exp = 1','exp = 2'},'Location','NorthEast')
box on
grid on
set(gca,'FontName','等线','FontSize',18,'LineWidth',1) %set more details for axis
set(gcf,'position',[100,100,800,800]) %set the size and position of graph
set(gca,'position',[.13 .17 .80 .74]); %set the position of the axis
saveas(gcf, '指数平滑法在不同指数下的流量变化曲线.png') %save this graph in disk