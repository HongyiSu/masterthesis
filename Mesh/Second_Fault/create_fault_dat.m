%Hongyi Su, MSc. Candidate at LMU Muenchen & TUM, Germany
%hsu@geophysik.uni-muenchen.de
clear all;
close all;
addpath /Users/hongyisu/Desktop/masterthesis/Mesh/Code/deg2utm;
addpath /Users/hongyisu/Desktop/masterthesis/Mesh/Code/utm2deg;
%main shock, lat = -22.6784; lon = 25.1558 
Data = importdata("second_fault.dat"); 

X = Data(:,1);
Y = Data(:,2);

fileID = fopen('Botswana_second_fault_latlon.dat','w');

fprintf(fileID,'%10s\t%10s\t\n','lat','lon');
for(i=1:length(X))
    %syntax: utm2deg(x,y,utmzone)
    [lat(i) lon(i)] = utm2deg(X(i),Y(i),'34 K');
    fprintf(fileID,'%10.6f\t%10.6f\t\n',lat(i),lon(i));
end
fclose(fileID);





