%Hongyi Su, MSc. Candidate at LMU Muenchen & TUM, Germany
%hsu@geophysik.uni-muenchen.de
clear all;
close all;
addpath utm2deg;
addpath deg2utm;
%main shock, lat = -22.6784; lon = 25.1558 

Data = importdata("Botswana_first_fault_latlon.dat");
Data = Data.data;
lat = Data(:,1);
lon = Data(:,2);

%Get utm coordinates for the first fault
fileID = fopen('Botswana_first_fault_utm.dat','w');
fprintf(fileID,'%s\t%s\t\n','X','Y');
for(i=1:length(lat))
    %syntax: [x,y,utmzone] = deg2utm(Lat,Lon)
    [X,Y,utmzone] = deg2utm(lat(i),lon(i));
    fprintf(fileID,'%10.6f\t%10.6f\t\n',X,Y);

end
fclose(fileID);
%%
%Get utm coordinates for epicentre of the main shock
lat_0 =  -22.6784;
lon_0 = 25.1558;
[x_0,y_0,utmzone_0] = deg2utm(lat_0,lon_0); 
%Now perform recentering
Data2 = importdata("Botswana_first_fault_utm.dat");
Data2 = Data2.data;
X = Data2(:,1);
Y = Data2(:,2);
X = X - x_0;
Y = Y - y_0;

fileID2 = fopen('Final_first_fault_utm.dat','w');
fprintf(fileID2,'%s\t%s\t%s\n','#X','Y','Z');
for(i=1:length(X))
    %place fault 5000 meters below the surface
    fprintf(fileID2,'%10.6f\t%10.6f\t%10.6f\n',X(i),Y(i),-5000); 
end
fclose(fileID2);



