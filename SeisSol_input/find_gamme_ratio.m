close all;
clear all;

%data from the simulations
gamma = [0.37, 0.66, 0.81, 0.85, 0.86, 0.865,0.8736, 0.8878, 0.95];
mw = [8.48034346942322, 8.24980398291671, 7.74134259785098, 7.54175421912558, 7.49330487989073, 5.90016724747872 ,5.49334275132674, 5.29311372159767, 4.51148308482790];
moment = [6.691372453373157E+021, 3.017907847593435E+021, 5.212113888262722E+020, 2.615961383442914E+020 ,2.212877229053298E+020,9.020920827196643E+017,1.108333811780820E+017, 7.451172662963868E+015];
%%
% gamma - mw
p = polyfit(gamma,mw,3);
x1 = linspace(0.37,0.95,1000);
y1 = polyval(p,x1);
figure
plot(gamma,mw,'o')
title('gamma-mw relation')

hold on
plot(x1,y1)
hold off

index = find(round(y1,4) == 6.5);
disp(x1(index))
%%
M_w_half6 = interp1(x1,y1,[0.865],'linear','extrap')

%%
%gamma mv
 
 p1 = polyfit(gamma,moment,3);
 x2 = linspace(0,0.95,1000);
 y2 = polyval(p1,x2);
 figure
 plot(gamma,moment,'o')
 title('gamma-moment relation')
 hold on
 plot(x2,y2)
 hold off
 xlim([0.37,0.95]);

%index = find(round(y2,1,'significant') == 6.5000);
%disp(x2(index))
%%


interp1(y2,x2,mag2moment(6.5),'linear','extrap')
interp1(y2,x2,mag2moment(6.5),'pp','extrap')
interp1(y1,x1,6.5,'pp','extrap')

function [Mw]=moment2mag(M_0)
    Mw = 2/3 * (log10(M_0) - 9.1); %p35, empirical relationship
end

function [M_0]=mag2moment(M_w)
    exponent = 3/2 * M_w + 9.1; %p35, empirical relationship
    M_0 = 10^exponent;
end