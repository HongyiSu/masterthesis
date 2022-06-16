%Hongyi Su, M.Sc. candidate at LMU @ TUM 

clc;
%close all;
clear all;

if(isdir([pwd '/figure' ]))
    disp(['directory exists!'])
else
    mkdir([pwd '/figure' ])
    disp(['create a new directory: ' pwd '/figure'])
end

filename = [pwd '/seis_case4b.txt'];
fileID = fopen(filename);
C = textscan(fileID,'%s %s','Delimiter',',');
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
fig.Position = [0 0 50 50/3];%define size of the figure
channel_3 = ["E", "N", "Z"];
count =0;
row_len =length(C);
for(j=1:length(obs_list))
   for(k=1:length(channel_3))
   channel0 = char(channel_3(k));
   [data_obs data_syn obs_t syn_t fs_obs fs_syn max_syn_t max_obs_t chan station] = fetch(j, obs_list, syn_list, channel0);

   m=0.2; %define low cut
   n=0.6; %define high cut
   [data_obs_d_f,data_syn_d_f]=filter_mydata(data_obs, data_syn, fs_syn,fs_obs, m, n);



   count=count+1;
   subplot(row_len,3,count);
    shift = 0; %shifted 
    my_plot(obs_t, data_obs_d_f, syn_t, data_syn_d_f,max_obs_t, max_syn_t, station, chan, shift,j,k);
   end
end
%max(syn)/max(obs), k is syn
saveas(fig,[pwd '/figure/waveform/waveform_case4b_[0.2,0.6]_30.jpg'])

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
    % m=0.01;
    % n=12;
    % [data_obs_d_f,data_syn_d_f]=filter_mydata(data_obs, data_syn,fs_syn,fs_obs, m, n);

     count=count+1;
     subplot(row_len,3,count);
     my_spectrum(data_syn_d_f,data_obs_d_f, station, chan,fs_syn,fs_obs,j,k);

    end
end
%k is the syn
saveas(fig1,[pwd '/figure/spectrum/spectrum_case4bi'],'jpg')







