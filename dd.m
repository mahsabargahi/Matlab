pm2d5= a.pm2d5;
time = a.time;
warning ('off','all');
time_num = (datenum(time)-floor(datenum(time)))*24*60*60;
fig = figure('Position', [0,0,850,1100]);
dim = 3;
subplot(3,2,1)
h = scatter(time,pm2d5,'.k');
h.MarkerFaceAlpha = .25;
h.MarkerEdgeAlpha = .25;
hold on
[p0,SI] = polyfit(time_num,pm2d5,dim);
[yfit,delta] = polyval(p0,time_num,SI);
plot(time,yfit,'r','LineWidth',3)
legend('data points','3-degree polynomial fitting')
xlabel('Minute')
ylabel('PM 2.5 (\mu g/m^3)')
title(['RMSE: ',num2str(sqrt(immse(yfit,pm2d5)))])
lambdas = [.01,0.001];
app = {'Ridge','Lasso'};
rng(1)
cv = cvpartition(size(pm2d5,1),'HoldOut',0.2);
idx_tmp = cv.test;
for i = 2:3
    subplot(3,2,i)
    h = scatter(time,pm2d5,'.k');
    h.MarkerFaceAlpha = .25;
    h.MarkerEdgeAlpha = .25;
    hold on
    [theta,intercept] = polycurvefitting_reg(time_num(~idx_tmp),pm2d5(~idx_tmp)',dim+1,lambdas(i-1),app{i-1});
    % polycurvefitting_reg
    [yfit] = polyval(theta,time_num);
    plot(time,yfit+intercept,'r','LineWidth',3)
    legend('data points',[app{i-1},', polynomial fitting'])
    xlabel('Time')
    ylabel('PM 2.5 (\mu g/m^3)')
    title(['RMSE: ',num2str(sqrt(mse(yfit(idx_tmp)+intercept,pm2d5(idx_tmp))))])
end
taus = [100,2000,20000];
span = [5,100,2000];
for i = 1:3
    subplot(3,2,3+i)
    h = scatter(time,pm2d5,'.k');
    h.MarkerFaceAlpha = .25;
    h.MarkerEdgeAlpha = .25;
    hold on
    %lowess
%     yhat = smooth(time_num,pm2d5,span(i),'loess');
%     yhat = smoothdata(pm2d5,'gaussian',span(i));
    [yhat] = mylowess(time_num,pm2d5,taus(i));
    plot(time,yhat,'r','LineWidth',3)
    legend('data points','Lowess','Location',"best")
    xlabel('Time')
    ylabel('PM 2.5 (\mu g/m^3)')
    title(['RMSE: ',num2str(sqrt(immse(yhat,pm2d5))),', \tau: ',num2str(taus(i))])
end
set(findall(gcf,'-property','FontSize'),'FontSize',12)