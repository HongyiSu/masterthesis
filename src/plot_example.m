%Hongyi Su, M.Sc. candidate at LMU @ TUM 
%Supervisors: Taufiqurrahman taufiqurrahman, Alice-Agnes Gabriel

clc;
close all;
clear all;

if(isdir([pwd '/example' ]))
    disp(['directory exists!'])
else
    mkdir([pwd '/example' ])
    disp(['create a new directory: ' pwd '/example'])
end

TT = importdata([pwd '/doc/report_2.0.txt']);
syn_list = TT.textdata(:,1); % extract synetic name list 
syn_list = syn_list(3:end); % skip headline
obs_list = TT.textdata(:,2); % extract synetic name list 
obs_list = obs_list(3:end); % skip headline
%%
%plot obs/syn waveform 
if(isdir([pwd '/example/waveform' ]))
    disp(['directory exists!'])
else
    mkdir([pwd '/example/waveform' ])
    disp(['create a new directory: ' pwd '/example/waveform'])
end

list_5 = [69, 42, 85, 119, 77]; %select stations here, refer to doc/report_2.0.txt, f.ex. scse = 1
%obre = 69, seal = 119, sndb = 85, vasq = 42, anav = 77;
channel_3 = ["NS", "EW", "Vertical"];
syn = 'syn_3D'; % {other possible input: syn_1D_rock, syn_1D_soil}

%loop over the five seleted stations and plot them
for(j=1:length(list_5))
    for(k=1:length(channel_3))
        
     i =list_5(j);
     channel = channel_3(k);
     station = obs_list{i};
        
     [data_obs data_syn obs_t syn_t fs_obs fs_syn max_syn_t max_obs_t] = fetch_data(obs_list{i},syn_list{i}, channel, syn);
     data_obs = data_obs/100; % in this specific study, unit conversion from cm>m
     %detrending
     data_obs_d = detrend(data_obs);
     data_syn_d = detrend(data_syn);
     %filtering
     %Design a 4th-order butterworth band-pass filter which passes
     %frequencies between 0.001 and 0.5 Hz   
     m=0.001; %define low cut
     n=0.5; %define high cut
     [b,a] = butter(2,[m n], 'bandpass');
     data_obs_d_f = filter(b,a,data_obs_d);
     data_syn_d_f = filter(b,a,data_syn_d);
     %plotting
     fig = figure;
     fig.Units = 'centimeters';
     fig.Position = [0 0 30 30/1.4];%define size of the figure
     %plot observational data
     h1 = subplot(211);
     plot(obs_t,data_obs_d_f,'k','LineWidth', 1.2);
     h1_pos=get(h1,'Position'); 
     box off;
     axis off ;
     xlim([0,60]);
     title([station ' & ' syn_list{i} ' ' char(channel) ' with butter [' num2str(m)... 
     ',' num2str(n) '] Hz, shift 3.885 s' ],'Interpreter','none');
     text(-4,min(data_obs_d_f),['\bf' '\it' station '(' char(channel) ')'],'FontSize', 24);
     %scale filtered observational data this factor written on the plot to get filtered synthetic data
     po1 = max(max_obs_t,max_syn_t); %for place the text
     text(po1,max(data_obs_d_f)*0.95,num2str((max(data_syn_d_f)/max(data_obs_d_f))), 'FontSize', 16);
    
     %now plot synthetic data
     h2 = subplot(212);
     plot(syn_t-3.885,data_syn_d_f,'r','LineWidth', 1.2); %shifted 3.885 second based on obre EW
     xlim([0,60])
     h2_pos=get(h2,'Position'); 
     box off
     axis off ;
     set(gcf,'color','w');
     set(h2,'Position',[h1_pos(1) h1_pos(2)+h1_pos(4)-0.65 h2_pos(3:end)]);

     
     
     saveas(fig,[pwd '/example/waveform' '/' station '_' char(channel) '_3D'],'jpg');
     close(fig);
    end
end
%%
%plot obs/syn spectrum
if(isdir([pwd '/example/spectrum' ]))
    disp(['directory exists!'])
else
    mkdir([pwd '/example/spectrum' ])
    disp(['create a new directory: ' pwd '/example/spectrum'])
end


list_5 = [69, 42, 85, 119, 77];
channel_3 = ["NS", "EW", "Vertical"];
syn = 'syn_3D';
for(j=1:length(list_5))
    for(k=1:length(channel_3))
        
     i =list_5(j);
     channel = channel_3(k);
     station = obs_list{i}; % for title of the figure  
     [data_obs data_syn obs_t syn_t fs_obs fs_syn max_syn_t max_obs_t] = fetch_data(obs_list{i},syn_list{i}, channel, syn);
     %detrend
     data_obs_d = detrend(data_obs);
     data_syn_d = detrend(data_syn);
     %filtering
     m=0.001;
     n=0.5;
     [b,a] = butter(2,[m n], 'bandpass');
     data_obs_d_f = filter(b,a,data_obs_d);
     data_syn_d_f = filter(b,a,data_syn_d);
     
     ns_syn = length(data_syn_d_f);
     f_syn = fs_syn*(0:ns_syn/2)/ns_syn;%sample individual frequency
     F_syn=fft(data_syn_d_f);%perform Fourier Transformation with fft
     A_syn=abs(F_syn(1:ns_syn/2+1));%take absolute value
     ns_obs = length(data_obs_d_f);
     f_obs = fs_obs*(0:ns_obs/2)/ns_obs;
     F_obs=fft(data_obs_d_f);
     A_obs=abs(F_obs(1:ns_obs/2+1));


    fig1 = figure;
    fig1.Units = 'centimeters';
    fig1.Position = [0 0 20 20/1.4];
    loglog(f_obs,A_obs, 'r');
    hold on
    loglog(f_syn,A_syn, 'k');
    grid on
    legend('observed','synthetic');
    xlabel('Frequency[Hz]');
    hAxis = axes('visible','off');
    h = text(-0.1,0.5,[station ' ' channel]);
    set(h,'fontsize',18,'rotation',90,'HorizontalAlignment','center');

    saveas(fig1,[pwd '/example/spectrum' '/' station '_' char(channel) '_spectrum_3D'],'jpg')
    close(fig1);
    end
end
