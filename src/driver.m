%Hongyi Su, M.Sc. candidate at LMU @ TUM 
%Supervisors: Taufiqurrahman taufiqurrahman, Alice-Agnes Gabriel

clc;
close all;
clear all;

if(isdir([pwd '/figure' ]))
    disp(['directory exists!'])
else
    mkdir([pwd '/figure' ])
    disp(['create a new directory: ' pwd '/figure'])
end

filename = [pwd '/seis_name.txt'];
fileID = fopen(filename);
C = textscan(fileID,'%s %s','Delimiter',',');
%212,211,216
fclose(fileID);
syn_list = C{2};
obs_list = C{1};  

%%
%plot obs/syn waveform 
if(isdir([pwd '/figure/waveform' ]))
    disp(['directory exists!'])
else
    mkdir([pwd '/figure/waveform' ])
    disp(['create a new directory: ' pwd '/figure/waveform'])
end
%plotting
fig = figure;
fig.Units = 'centimeters';
fig.Position = [0 0 30 30/1.4];%define size of the figure
channel_3 = ["E", "N", "Z"];
count =0;
for(j=1:length(obs_list))
   for(k=1:length(channel_3))
   channel = char(channel_3(k));
   [data_obs data_syn obs_t syn_t fs_obs fs_syn max_syn_t max_obs_t chan station] = fetch(j, obs_list, syn_list, channel);

   m=0.1; %define low cut
   n=0.5; %define high cut
   [data_obs_d_f,data_syn_d_f]=filter_mydata(data_obs, data_syn, m, n);
   count=count+1;
   subplot(3,3,count)
   shift = 0; %shifted 3.885 second based on obre EW
   my_plot(obs_t, data_obs_d_f, syn_t, data_syn_d_f,max_obs_t, max_syn_t, station, chan, shift,j,k);
   end
end

saveas(fig,[pwd '/figure/waveform/all_waveform'],'jpg')

%%
close all
%plot obs/syn spectrum
if(isdir([pwd '/figure/spectrum' ]))
    disp(['directory exists!'])
else
    mkdir([pwd '/figure/spectrum' ])
    disp(['create a new directory: ' pwd '/figure/spectrum'])
end

fig1 = figure;
fig1.Units = "centimeters";
fig1.Position = [0 0 40/1.4 40];


count =0;
for(j=1:length(obs_list))
    for(k=1:length(channel_3))
    channel = char(channel_3(k));
   

   [data_obs data_syn obs_t syn_t fs_obs fs_syn max_syn_t max_obs_t chan station] = fetch(j, obs_list, syn_list, channel);
    
     %filtering
     m=0.2;
     n=0.5;
     [data_obs_d_f,data_syn_d_f]=filter_mydata(data_obs, data_syn, m, n);

     count=count+1;
     subplot(3,3,count);
     my_spectrum(data_syn_d_f,data_obs_d_f, station, chan,fs_syn,fs_obs,j,k);

    end
end
saveas(fig1,[pwd '/figure/spectrum/all_spectrum'],'jpg')







