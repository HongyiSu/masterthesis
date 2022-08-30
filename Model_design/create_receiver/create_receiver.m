%Hongyi Su, MSc. Candidate at LMU Muenchen & TUM, Germany
%hsu@geophysik.uni-muenchen.de

%Station info data downloaded from IRIS DMC
clear all;
close all;
addpath /Users/hongyisu/Desktop/masterthesis/Model_design/Code;
addpath /Users/hongyisu/Desktop/masterthesis/Model_design/Code/utm2deg;
%main shock, lat = -22.6784; lon = 25.1558 
%Data = importdata("stations16.txt"); 

filename = 'stations16.txt';
fid  = fopen(filename);
data = textscan(fid,'%s%s%f%f%f%s%s%s','Delimiter','|','HeaderLines',3);
fid = fclose(fid);
network = data{:,1};
sta = data{:,2};
lat = data{:,3};
lon = data{:,4};
elevation = data{:,5};


%%

sta = string(sta);

fileID = fopen('recevier16_35K_center_correct.csv','w');

[x_0 y_0 zone_0] = deg2utm(-22.6784, 25.1558);
        fprintf(fileID,'%6s,%6s,%6s,%6s\n','X','Y', 'elevation','station');
for(i=1:length(lat)) 
    %syntax: utm2deg(x,y,utmzone)
    [X Y zone] = deg2utm(lat(i),lon(i));
    X = X-x_0;
    Y = Y-y_0;
    if(zone == "35 K" || zone == "35 J")
        fprintf(fileID,'%10.6f,%10.6f,%10.6f,%6s\n',X,Y, elevation(i),strcat(string(sta(i))));
    end
    if(zone == "34 K" || zone == "34 J")
        fprintf(fileID,'%10.6f,%10.6f,%10.6f,%6s\n',X-6*111000*cos(lat(i)*pi/180),Y, elevation(i),strcat(string(sta(i))));
    end
end
fclose(fileID);
%% 

%seissol receiver input

sta = string(sta);

fileID = fopen(['recevier16_35K.dat'],'w');

[x_0 y_0 zone_0] = deg2utm(-22.6784, 25.1558);
        %fprintf(fileID,'%6s,%6s,%6s,%6s\n','X','Y', 'elevation','station');
for(i=1:length(lat)) 
    %syntax: utm2deg(x,y,utmzone)
    [X2 Y2 zone] = deg2utm(lat(i),lon(i));
    X2 = X2-x_0;
    Y2 = Y2-y_0;
    if(zone == "35 K" || zone == "35 J")
        fprintf(fileID,'%10.6f   %10.6f   %10.6f\n',X2,Y2, 0.0);
    end
    if(zone == "34 K" || zone == "34 J")
        fprintf(fileID,'%10.6f   %10.6f   %10.6f\n',X2-6*111000*cos(lat(i)*pi/180),Y2, 0.0);
    end
end
fclose(fileID);


%%
figure
for(i=1:16)
    plot(lon(i),lat(i),'bo');
    text(lon(i),lat(i), string(sta(i)));
    hold on

end
xlabel('lon')
ylabel('lat')
title('From lat and lon')

for(i=1:length(lat)) 
    %syntax: utm2deg(x,y,utmzone)
    [X(i) Y(i) zone] = deg2utm(lat(i),lon(i));
    zone_o(i) = string(zone); 
end



[x_0 y_0 zone_0] = deg2utm(-22.6784, 25.1558);
figure
for(i=1:16)
    if(zone_o(i) == "34 J" || zone_o(i) == "34 K")
        plot(X(i)-6*111000*cos(lat(i)*pi/180),Y(i),'bo');
        text(X(i)-6*111000*cos(lat(i)*pi/180),Y(i), string(sta(i)));
        hold on
    end
    if(zone_o(i) == "35 J" || zone_o(i) == "35 K")
        plot(X(i),Y(i),'bo');
        text(X(i),Y(i), string(sta(i)));
        hold on
    end
    
end
plot(x_0,y_0,'ro')
title('All')
xlabel('lon')
ylabel('lat')

%%

dd = importdata('recevier16_35K.dat');
x=dd(:,1);
y=dd(:,2);
for(i=1:16)
    dist(i) = sqrt(x(i)^2+y(i)^2+29000^2);
end

