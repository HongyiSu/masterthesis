%Hongyi Su, MSc. Candidate at LMU Muenchen & TUM, Germany
%hsu@geophysik.uni-muenchen.de
clear all;
close all;
addpath utm2deg;
addpath deg2utm;
%main shock, lat = -22.6784; lon = 25.1558 
Data = importdata("Botswana_second_fault_utm.dat"); 

X = Data.data(:,1);
Y = Data.data(:,2);
Z = -5000*ones(length(X),1);

fileID = fopen('Botswana_second_utm_z.dat','w');

%fprintf(fileID,'%10s\t%10s\t%10s\t\n','X','Y','Z' );
for(i=1:length(X))
    fprintf(fileID,'%10.6f\t%10.6f\t%10.6f\t\n',X(i), Y(i),Z(i));
end
fclose(fileID);
