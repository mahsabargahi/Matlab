pm2d5= data.pm2d5;
time = data.time;
time_second = (datenum(time)-floor(datenum(time)))*24*60*60;
humidity=data.hmd;
x=time_second;
y=pm2d5;
[p0,SI] = polyfit(x,y,20); 

% p0 contains parameters of polynomial fitting
% SI contains error estimation
[yfit,delta] = polyval(p0,x,SI);
plot(x,y,'bo')
hold on
plot(x,yfit,'r-')
plot(x,yfit+2*delta,'m--',x,yfit-2*delta,'m--')
title('Linear Fit of Data with 95% Prediction Interval')
legend('Data','Linear Fit','95% Prediction Interval')

lambda = 0.01 % Regularization parameter;
xx=yfit;
dim = size(xx,2);% dimension of feature;
theta = inv((xx'*xx)+lambda*eye(dim))*xx'*y;
y_ridge = xx*theta;
mean((y-y_ridge).^2) %cost function

plot(x,y,'bo')
hold on
plot(x,y_ridge,'r-')



lambda = 0.001 % Regularization parameter
[theta2,FitInfo] = lasso(x,y,'Lambda',lambda);
intercept = FitInfo.Intercept; % Intercept
y_lasso=theta2*x+intercept;
mean((y-y_lasso).^2) %cost function
% fit linear model with lasso


ysmooth5 = smooth(x,y,5,'loess');
ysmooth100 = smooth(x,y,100,'loess');
ysmooth1000 = smooth(x,y,1000,'loess');

subplot(2,3,1);
plot(x,y,'.')
hold on
plot(x,yfit,'r-')
title('20-degree polynomial fit of Data')
legend('Data','20-degree polynomial Fit')
xlabel('time_second')
ylabel('pm2d5')


subplot(2,3,2);
plot(x,y,'.')
hold on
plot(x,yridge1,'r-')
title('Ridge polynomial fit of Data')
legend('Data','ridge polynomial Fit-alpha=0.001')
xlabel('time_second')
ylabel('pm2d5')

subplot(2,3,3); 
plot(x,y,'.')
hold on
plot(x,ylasso1,'r-')
title('Lasso polynomial fit of Data')
legend('Data','lasso polynomial Fit-alpha=0.001')
xlabel('time_second')
ylabel('pm2d5')


subplot(2,3,4); 
plot(x,y,'.')
hold on
plot(x,ysmooth5,'r-')
legend('Data','Smoothed data with span 5 ')
xlabel('time_second')
ylabel('pm2d5')



subplot(2,3,5); 
plot(x,y,'.')
hold on
plot(x,ysmooth100,'r-')
legend('Data','Smoothed data with span 100')
xlabel('time_second')
ylabel('pm2d5')

subplot(2,3,6); 
plot(x,y,'.')
hold on
plot(x,ysmooth1000,'r-')
legend('Data','Smoothed data with span 1000 ')
xlabel('time_second')
ylabel('pm2d5')

[p1,S1] = polyfit(y_lasso,y,20); 
[yfit1,delta1] = polyval(p1,y_lasso,S1);

subplot(1,3,1); 
plot(x,y,'.')
hold on
plot(x,smooth(x,y,100,'loess'),'r-')
legend('Data','Smoothed data sigma 100 ')
xlabel('time_second')
ylabel('pm2d5')



subplot(1,3,2); 
plot(x,y,'.')
hold on
plot(x,smooth(x,y,2000,'loess'),'r-')
legend('Data','Smoothed data sigma 2000')
xlabel('time_second')
ylabel('pm2d5')

subplot(1,3,3); 
plot(x,y,'.')
hold on
plot(x,smooth(x,y,20000,'loess'),'r-')
legend('Data','Smoothed data sigma 20000 ')
xlabel('time_second')
ylabel('pm2d5')


test=[time_second,humidity];
[p1,S1] = polyfit(test,y,20); 
[yfit1,delta1] = polyval(p1,test,S1);

num_d = length(x);
dim=20
 v_m = ones(num_d,dim);
 for i = 1:dim
 v_m(:,i) = x.^(dim-i);
 end
 theta = ((v_m'*v_m)+lambda*eye(dim))\v_m'*y;
 intercept = 0;
y_las=x*theta


y11=y1p1.y1p1;
y12=y1p1.y1p2;
y13=y1p1.y1p3;
y14=y1p1.y1p4;

subplot(2,2,1);
plot(x,y,'.')
hold on
plot(x,y11,'r-')
title('Linear Fit of Data')
legend('Data','Linear Fit')
xlabel('time_second')
ylabel('pm2d5')


subplot(2,2,2); 
plot(x,y,'.')
hold on
plot(x,y12,'r-')
title('Linear Fit of Data with features time + humidity')
legend('Data','Linear Fit')
xlabel('time_second')
ylabel('pm2d5')




subplot(2,2,3); 
plot(x,y,'.')
hold on
plot(x,y13,'r-')
title('Linear Fit of Data with features time + humidity+speed')
legend('Data','Linear Fit')
xlabel('time_second')
ylabel('pm2d5')


subplot(2,2,4); 
plot(x,y,'.')
hold on
plot(x,y14,'r-')
title('Linear Fit of Data with features time+humidity+speed+temperature')
legend('Data','Linear Fit')
xlabel('time_second')
ylabel('pm2d5')

yridge1=yridge2.yrid;
ylasso1=yridge2.ylass;



