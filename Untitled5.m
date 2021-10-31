%plot(foshan_pm2d5,foshan_time);
%hold on;
%plot(tianjin_pm2d5,tianjin_time);
%xlabel('pm2d5'); 
%histogram(tianjin_pm2d5,100)
%xlabel('pm2d5')
%ylabel('count')
%title('Histogram of pm2d5 concentration-100bin')
%qqplot(tianjin_pm2d5)
%title('QQ-Plot of pm2d5 concentration')
%y = fft(tianjin_pm2d5-mean(tianjin_pm2d5));  
%f = (0:length(y)-1)*50/length(y);
%plot(f,abs(y));
%Fs = 1/3; % Sampling frequency
%T = 1/Fs; % Sampling period
%L = length(tianjin_pm2d5); % Length of signal
%Y = fft(tianjin_pm2d5-mean(tianjin_pm2d5)); % Calculating fft
%P2 = abs(Y/L); % Compute the magnitude
%P1 = P2(1:L/2+1); % Single-side spectrum
%f = Fs*(0:(L/2))/L; % Frequency axis 0 to Nyquist freq
%plot(f, P1)
%win_size = 43200; % window size
%mv_data= movmean(tianjin_pm2d5,win_size);
%plot(tianjin_time,mv_data);
%title('Tianjin- 12 hr moving average')

tianjin_pm2d5_day1=tianjin_pm2d5(1:28643);
tianjin_pm2d5_day1t=tianjin_time(1:28643);
tianjin_pm2d5_day2=tianjin_pm2d5(28644:54722);
tianjin_pm2d5_day2t=tianjin_time(28644:54722);
tianjin_pm2d5_day3=tianjin_pm2d5(54722:74896);
tianjin_pm2d5_day3t=tianjin_time(54722:74896);
tianjin_pm2d5_day4=tianjin_pm2d5(74897:95777);
tianjin_pm2d5_day4t=tianjin_time(74897:95777);
tianjin_pm2d5_day5=tianjin_pm2d5(95778:116314);
tianjin_pm2d5_day5t=tianjin_time(95778:116314);
tianjin_pm2d5_day6=tianjin_pm2d5(116315:135750);
tianjin_pm2d5_day6t=tianjin_time(116315:135750);
tianjin_pm2d5_day7=tianjin_pm2d5(135751:155963);
tianjin_pm2d5_day7t=tianjin_time(135751:155963);
tianjin_pm2d5_day8=tianjin_pm2d5(155964:177891);
tianjin_pm2d5_day8t=tianjin_time(155964:177891);
tianjin_pm2d5_day9=tianjin_pm2d5(177892:198542);
tianjin_pm2d5_day9t=tianjin_time(177892:198542);
tianjin_pm2d5_day10=tianjin_pm2d5(198543:216918);
tianjin_pm2d5_day10t=tianjin_time(198543:216918);
ytianjin=[mean(tianjin_pm2d5_day1) mean(tianjin_pm2d5_day2) mean(tianjin_pm2d5_day3) mean(tianjin_pm2d5_day4) mean(tianjin_pm2d5_day5) mean(tianjin_pm2d5_day6) mean(tianjin_pm2d5_day7) mean(tianjin_pm2d5_day8) mean(tianjin_pm2d5_day9) mean(tianjin_pm2d5_day10)];
f1 = repmat({'day1'},28642,1);
f2 = repmat({'day2'},26079,1);
f3 = repmat({'day3'},20175,1);
f4 = repmat({'day4'},20881,1);
f5 = repmat({'day5'},20537,1);
f6 = repmat({'day6'},19436,1);
f7 = repmat({'day7'},20213,1);
f8 = repmat({'day8'},21928,1);
f9 = repmat({'day9'},20651,1);
f10 = repmat({'day10'},18376,1);
f = [f1; f2; f3;f4;f5;f6;f7;f8;f9;f10];
%boxplot(tianjin_pm2d5,f);

%Fs = 1/3; % Sampling frequency
cut = 0.05; % Cut-off frequency
lowpassed_data = lowpass(tianjin_pm2d5,cut,Fs);
%plot(tianjin_time,lowpassed_data);
%title('tianjin lowpass filter 0.01HZ');
%win_size = 3600; % window size
%mv_data= movmean(tianjin_pm2d5,win_size);
Fs = 1/3; % Sampling frequency
T = 1/Fs; % Sampling period
L = length(tianjin_pm2d5); % Length of signal
Y = fft(lowpassed_data-mean(lowpassed_data)); % Calculating fft
P2 = abs(Y/L); % Compute the magnitude
P1 = P2(1:L/2+1); % Single-side spectrum
f = Fs*(0:(L/2))/L; % Frequency axis 0 to Nyquist freq
plot(f, P1);
title('fft with low pass filter 0.05');