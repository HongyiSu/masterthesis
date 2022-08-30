%Hongyi Su, M.Sc. candidate at LMU @ TUM 

clc;
%close all;
clear all;
close all;

if(isdir([pwd '/figure' ]))
    disp(['directory exists!'])
else
    mkdir([pwd '/figure' ])
    disp(['create a new directory: ' pwd '/figure'])
end
caseid = "case5r6_syn";
filename = [strcat(pwd, '/seis_', caseid, '.txt')];
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

h4=figure;
set(h4,'PaperSize',[50 150]); %set the paper size to what you want  

%fig = figure;
%fig.Units = 'centimeters';
%fig.Position = [0 0 20 30];%define size of the figure


channel_3 = ["E", "N", "Z"];
count =0;
row_len =length(obs_list);
for(j=1:8)
   for(k=1:length(channel_3))
   channel0 = char(channel_3(k));
   [data_syn syn_t fs_syn max_syn_t station] = fetch_data_syn(j, obs_list, syn_list, channel0);
   m=0.2; %define low cut frequency
   n=0.6; %define high cut frequency
   [data_syn_d_f]=filter_mydata_syn(data_syn, fs_syn, m, n);
   data_syn_d_f = data_syn;
   count=count+1;
   subplot(row_len,3,count);
   shift = 0; %shifted 
   my_plot_syn(syn_t, data_syn_d_f, max_syn_t, station, channel0, shift,j,k);
   end
end
%max(syn)/max(obs), k is syn



%path = strcat(pwd, '/figure/waveform/waveform_60s_syn', caseid, '_[', string(m), ',', string(n), ']_.jpg');
%saveas(fig,path)


print(h4,'syn_seismo_9_60s_raw_filtered','-dpdf','-fillpage','-r200') % then print it


%%
%plot obs/syn spectrum
if(isdir([pwd '/figure/spectrum' ]));
    disp(['directory exists!']);
else
    mkdir([pwd '/figure/spectrum' ]);
    disp(['create a new directory: ' pwd '/figure/spectrum']);
end

h5=figure;

%set(h5,'PaperSize',[25 50]); %set the paper size to what you want

set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperSize', [8.5*4 (14+4)*4]);

channel_3 = ["E", "N", "Z"];
row_len =length(obs_list);

count =0;
for(j=9:16)
    for(k=1:length(channel_3))
        channel = char(channel_3(k));
        [data_syn syn_t fs_syn max_syn_t station] = fetch_data_syn(j, obs_list, syn_list, channel);
        count=count+1;
        subplot(row_len,3,count);
        my_spectrum_syn(data_syn, station, channel, fs_syn, j, k);
    end
end
%k is the syn

%path1 = strcat(pwd, '/figure/spectrum/spectrum_', caseid, '.jpg');
%saveas(fig1,path1)

print(h5,['syn_spectrum_9_sta_60s'],'-dpdf','-fillpage','-r200') % then print it

