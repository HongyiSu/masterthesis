clear all;
close all;
%main shock, lat = -22.6784; lon = 25.1558 
dd = importdata('aftershocks_YXZ.dat');
X = dd(:,1);
Y = dd(:,2);
Z = dd(:,3);
Z = -Z;
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

%[x_0 y_0 zone]=deg2utm(-22.6784,25.1558 );

fileID2 = fopen('aftershocks_final_utm.csv','w');
% [x,y,utmzone] = deg2utm(Lat,Lon)
fprintf(fileID2,'%s,%s,%s\t\n', 'x', 'y', 'z');
for(i=1:length(lat))
    [x,y, ~] = deg2utm(lat(i),lon(i));
    fprintf(fileID2,'%10.6f,%10.6f,%10.6f\n', x, y, Z(i) );
end
fclose(fileID2);


%%
% 
fileID2 = fopen('mainshock_utm.csv','w');
% [x,y,utmzone] = deg2utm(Lat,Lon)
lat = -22.6784; 
lon = 25.1558;
fprintf(fileID2,'%s,%s,%s\t\n', 'x', 'y', 'z');
z = -235000;
%for(i=1:length(lat))
[x,y, ~] = deg2utm(lat,lon);
fprintf(fileID2,'%10.6f,%10.6f,%10.6f\n', x, y, z );
%end
fclose(fileID2);
%%
clear all;
close all;
ddd = importdata('receiver5.dat');


