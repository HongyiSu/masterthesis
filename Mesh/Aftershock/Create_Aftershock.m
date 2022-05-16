clear all;
close all;
%main shock, lat = -22.6784; lon = 25.1558 
dd = importdata('aftershocks_XYZ_a.csv');


%%
fileID = fopen('aftershocks_XYZ_a.csv','w');
%[Lat,Lon] = utm2deg(x,y,utmzone)
for(i=1:length(X))
    [lat(i) lon(i)] = utm2deg(X(i),Y(i),'34 K');
    fprintf(fileID,'%10.6f\t%10.6f\t\n',lat(i),lon(i));
end
fclose(fileID);
ddd = importdata('aftershocks_XYZ_a.csv');

lat = ddd(:,1);
lon = ddd(:,2);

[x_0 y_0 zone]=deg2utm(-22.6784,25.1558 );

fileID2 = fopen('aftershocks_final.csv','w');
% [x,y,utmzone] = deg2utm(Lat,Lon)
fprintf(fileID2,'%s,%s,%s\t\n', 'x', 'y', 'z');
for(i=1:length(lat))
    [x,y, ~] = deg2utm(lat(i),lon(i));
    x=x-x_0;
    y=y-y_0;
    fprintf(fileID2,'%10.6f,%10.6f,%10.6f\n', x, y, Z(i) );
end
fclose(fileID2);
