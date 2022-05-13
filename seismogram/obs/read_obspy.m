clear all;
close all;
load data-NE208_0DISP.mat
t = linspace(1,str2num(npts)*str2num(delta),str2num(npts));
plot(t,data);
xlim([30,50])