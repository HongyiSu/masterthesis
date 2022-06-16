%Hongyi Su, MSc. Candidate at LMU Muenchen & TUM, Germany
%hsu@geophysik.uni-muenchen.de
clear all;
close all;
addpath /Users/hongyisu/Desktop/masterthesis/Mesh/Code/deg2utm;
addpath /Users/hongyisu/Desktop/masterthesis/Mesh/Code/utm2deg;
%main shock, lat = -22.6784; lon = 25.1558 
Data = importdata("receiver5.dat"); 

lat = Data.data(:,1);
lon = Data.data(:,2);
sta = Data.textdata;
sta = string(sta);

fileID = fopen('recevier_35K_center.dat','w');

[x_0 y_0 ~] = deg2utm(-22.6784, 25.1558);

for(i=[2,4]) %select NE208, NE212
    %syntax: utm2deg(x,y,utmzone)
    [X Y ~] = deg2utm(lat(i),lon(i));
    X = X-x_0;
    Y = Y-y_0;
    fprintf(fileID,'%10.6f\t%10.6f\t%10.6f\t%10s\n',X,Y, 0.0,strcat('!',string(sta(i))));
end
fclose(fileID);