%Hongyi Su, M.Sc. candidate at LMU @ TUM 
%Supervisors: Taufiqurrahman taufiqurrahman, Alice-Agnes Gabriel
close all;
clear all;
addpath deg2utm/;

TT = importdata('doc/report_2.0.txt');
abc=TT.data; 
sta_list = TT.textdata(:,2);
sta_list = sta_list(3:end);
dist2fault = abc(:,3);

TT_lon = abc(:,1);
TT_lat = abc(:,2);
TT_x = [];
TT_y = [];
for j=1:length(abc)
    [TT_x(j) TT_y(j) ~]=deg2utm(TT_lat(j),TT_lon(j)); 
end
fig = figure;
fig.Units = 'centimeters';
fig.Position = [0 0 60 60/1.6]; 

for i=1:length(TT_x)
    h4 = plot(TT_x(i),TT_y(i),'Color','g','DisplayName', 'observational',...
        'Marker','.', 'MarkerSize',dist2fault(i));
    text(TT_x(i),TT_y(i),sta_list(i));
    hold on
end
%obre 69; seal 119; sndb 85; vasq 42; anav 77
%list_5 = [69 119 85 42 77];
%fccb 64, sati 15, balp 96, eliz 70, lact 65
%list_5 = [64 15 96 70 65];
%lacy 52, pacd 9, plmd 88, uclg 34, vrns 67
list_5 = [52 9 88 34 67];
for(i=1:length(list_5))
    plot(TT_x(list_5(i)),TT_y(list_5(i)),'Color','r','DisplayName', 'observational',...
        'Marker','o', 'MarkerSize',dist2fault(list_5(i)));
end
 text(TT_x(121)*1.004,TT_y(121)*0.999,'71.5km [for reference]');
 title('Location of the 5 selected stations (red circled)','FontSize', 20);
 saveas(fig,[pwd '/example/' 'Selected_location_fccb'],'jpg');