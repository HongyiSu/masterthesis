clear all;
close all;
data = importdata('first_fault_plane.dat');

X = data(:,1);
Y = data(:,2);

fileID = fopen('first_fault.dat','w');

for(i=1:length(X))
fprintf(fileID,'%10.6f\t%10.6f\t\n',Y(i),X(i));
end

fclose(fileID);