clear all;
close all;

%load utm2deg and deg2utm
addpath /Users/hongyisu/Desktop/masterthesis/Mesh/Code

 

%main shock, lat = -22.6784; lon = 25.1558 
dd = importdata('aftershocks_from_Max.vtk');
%%
x = dd.data(:,1);
y = dd.data(:,2);
z = dd.data(:,3);
%%
%convert x,y back to lat and lon, the x, y need change place
for(i=1:length(x)) 
    [lat(i) lon(i)] = utm2deg(y(i),x(i),'34 K');
    %fprintf(fileID,'%10.6f\t%10.6f\t\n',lat(i),lon(i));
end

%%
[x_0 y_0 zone]=deg2utm(-22.6784,25.1558 );
fileID = fopen('aftershocks_recenter_0.csv','w');
fprintf(fileID,'%s,%s,%s\t\n', 'x', 'y', 'z');
for(i=1:length(lat))
    [X,Y, ~] = deg2utm(lat(i),lon(i));
    fprintf(fileID,'%10.6f,%10.6f,%10.6f\n', X-x_0, Y-y_0, -z(i) );
end
fclose(fileID);
%% 
% Create hypocenter csv
fileID = fopen('mainshock_recenter_0.csv','w');
fprintf(fileID,'%s,%s,%s\t\n', 'x', 'y', 'z');
fprintf(fileID,'%10.6f,%10.6f,%10.6f\n', 0, 0, -29000);
fclose(fileID);


