clear all;
close all;
data = importdata("Final_second_fault_utm.dat");
DD = data.data;
X = DD(:,1);
Y = DD(:,2);
figure
plot(X,Y,'o')
%%
k = (X(1)-X(end)) / (Y(1) - Y(end));
b  = Y(1) -k*X(1);

want_x = 90000;
want_y = k*want_x + b; 

X(5) = want_x;
Y(5) = want_y;
figure
plot(X,Y,'o')
%%


p = polyfit(X,Y,3);
x1 = 100000;
y1 = polyval(p,x1);

X(5)=x1;
Y(5)=y1;

figure;
plot(X,Y,'o')

%%

gamma = [0.37, 0.66, 0.81, 0.95];
mw = [8.48034346942322, 8.24980398291671, 7.74134259785098, 4.51148308482790];
moment = [6.691372453373157E+021, 3.017907847593435E+021, 5.212113888262722E+020, 7.451172662963868E+015];
p = polyfit(gamma,mw,7);
x1 = linspace(0.37,0.95,1000);
y1 = polyval(p,x1);
figure
plot(gamma,mw,'o')
title('gamma-mw relation')

hold on
plot(x1,y1)
hold off

index = find(round(y1,4) == 6.4978);
disp(x1(index))

% 
% p1 = polyfit(gamma,moment,7);
% x2 = linspace(0,0.95,100);
% y2 = polyval(p1,x2);
% figure
% plot(gamma,moment,'o')
% title('gamma-moment relation')
% hold on
% plot(x2,y2)
% hold off

