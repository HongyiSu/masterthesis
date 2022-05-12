clear all;
close all;
load data-NE212.mat0
t = linspace(1,str2num(npts)*str2num(delta),str2num(npts));
plot(t,data);