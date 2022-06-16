%Hongyi Su, MSc. Candidate at LMU Muenchen & TUM, Germany
%hsu@geophysik.uni-muenchen.de
clear all;
close all;
addpath utm2deg;
addpath deg2utm;
%main shock, lat = -22.6784; lon = 25.1558 

%Data = importdata("Botswana_first_fault_latlon.dat");
Data = importdata("fault_updated_first.csv") %UTM 34S
%%
%Data = Data.data;
x = Data(:,1);
y = Data(:,2);
% get the lat and lon
for(i=1:length(x))
    [lat(i),lon(i)]=utm2deg(x(i),y(i),'34 K'); %34 K, not 34 S
end
%%

%epicentre of the main shock
lat_0 =  -22.6784;
lon_0 = 25.1558;
%Get utm coordinates for epicentre of the main shock
[x_0,y_0,utmzone_0] = deg2utm(lat_0,lon_0); 

%Get utm coordinates for the first fault

fileID = fopen('Botswana_first_update.dat','w');
fprintf(fileID,'#%s\t%s\t\n','X','Y');
Z = -5000;
for(i=1:length(lat))
    [X,Y,utmzone] = deg2utm(lat(i),lon(i));
    fprintf(fileID,'%10.6f\t%10.6f\t%10.6f\t\n',X-x_0,Y-y_0, Z);

end
fclose(fileID);
