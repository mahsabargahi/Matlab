%GPR for interpolation in Spatial domain
load hw4_2.mat
pm2d5= data.pm2d5;
time = data.time;
time_num = (datenum(time)-floor(datenum(time)))*24*60*60;
lat = data.lat;
lon = data.lon;
x = [normalize(time_num,'range'),normalize(lat,'range'),normalize(lon,'range')];
y = pm2d5; % process data

fig1 = figure('Position', [0,0,850,1100]);
n_subplot = 1;
kernel = 'exponential'; % select kernel
for cv_time = 1:5  % 5-fold cross validation for gpr model training
cv = cvpartition(size(y,1),'HoldOut',0.2);
idx_tmp = cv.test;
x_train = x(~idx_tmp,:);
y_train = y(~idx_tmp);
x_test = x(idx_tmp,:);
y_test = y(idx_tmp);
gprMdl = fitrgp(x_train,y_train,'KernelFunction',kernel);
[y_pred,~,~] = predict(gprMdl,x_test);
errors(cv_time) = rms(y_pred-y_test);
end
display(['RMSE: ',num2str(mean(errors))])
for i = 10:21
time_ = i/24;
subplot(6,2,i-9);
[lats, lons]=meshgrid(min(lat):0.0025:max(lat), min(lon):0.0025:max(lon));
x_plot = [repmat(time_,length(lats(:)),1),normalize(lats(:),'range'),normalize(lons(:),'range')];
[yplot,~,~] = predict(gprMdl,x_plot);
s = surf(lons,lats,reshape(yplot,size(lats))); 
shading interp 
view(0,90)
xlabel('Longitude')
ylabel('Latitude')
c = colorbar;
ylabel(c,'PM 2.5 (\mu g/m^3)') 
title(datestr(time_,'HH:MM:SS'),'fontsize',10)
ax = gca;
outerpos = ax.OuterPosition;
ti = ax.TightInset; 
left = outerpos(1) + ti(1);
bottom = outerpos(2) + ti(2);
ax_width = outerpos(3) - ti(1) - ti(3)-0.005;
ax_height = outerpos(4) - ti(2) - ti(4)-0.005;
ax.Position = [left bottom ax_width ax_height];
end


