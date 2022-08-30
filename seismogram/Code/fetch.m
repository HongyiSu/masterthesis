%Hongyi Su, M.Sc. candidate at LMU @ TUM 

function [data_obs data_syn obs_t syn_t fs_obs fs_syn max_syn_t max_obs_t station] = fetch(j,obs_list, syn_list,channel0, station)

    %import observational data

    chan = channel0;
    obs_name = char(obs_list(j));
    sta_name= obs_name(1:5);
    station = sta_name;
    if(channel0=='Z') %0e 1n 2z
        %load ../obs/case2/data-NE208_new_2.mat;
        load(['../obs/data_60s-' sta_name '_2' '.mat'])
        data_obs =data;
        obs_t = linspace(0,str2num(npts)*str2num(delta),str2num(npts));
        fs_obs  = str2num(sampling_rate);
        max_obs_t = max(obs_t);
        %chan = channel;
        station =  sta_name;
    end
    if(channel0=='E') %0e 1n 2z
        load(['../obs/data_60s-' sta_name '_0' '.mat'])
        data_obs =data;
        obs_t = linspace(0,str2num(npts)*str2num(delta),str2num(npts));
        fs_obs  = str2num(sampling_rate);
        max_obs_t = max(obs_t);
        %chan = channel;
        station =  sta_name;
     end
     if(channel0=='N') %0e 1n 2z
        load(['../obs/data_60s-' sta_name '_1' '.mat'])
        data_obs =data;
        obs_t = linspace(0,str2num(npts)*str2num(delta),str2num(npts));
        fs_obs  = str2num(sampling_rate);
        max_obs_t = max(obs_t);
        %chan = channel;
        station =  sta_name;
    end
    
     


%     obs_name = char(obs_list(j));
%     prefix = obs_name(1:12);
%     postfix = obs_name(14:end);
%     obs_final_name = [prefix channel postfix];
% 
% 
%     obs = fread_sac(['/Users/hongyisu/Desktop/masterthesis/seismogram/obs/2017-04-03-mww65-botswana-event-time/' obs_final_name]);
%     obs_t = obs.t;
%     obs_t = obs.t-obs.t(1);%make sure it starts from 0, for some stations, start time is not 0 second
%     fs_obs = 1/(obs.t(2)-obs.t(1)); %return sampling frequency of observational waveform, also obs.hdr.delta
%     max_obs_t = max(obs_t); %return corrected maximum observational time for plotting 
%     
%     chan = obs_final_name(11:13);
%     station = obs_final_name(4:8);
% 
%     data_obs = obs.data;





    %import synthetic data (SeisSol FORMAT)
    % VARIABLES = "Time","xx","yy","zz","xy","yz","xz","u","v","w"
    fid  = fopen(['/Users/hongyisu/Desktop/masterthesis/seismogram/syn/' char(syn_list(j))]);
    data = textscan(fid,'%f%f%f%f%f%f%f%f%f%f','Delimiter','\t','HeaderLines',8);
    fid = fclose(fid);
    syn_t=cell2mat(data(1,1));
    % syn_t=syn_t(1:2000);
    fs_syn = 1/(syn_t(2)-syn_t(1)); %return sampling frequency of synthetic waveform
    max_syn_t = max(syn_t); %return corrected maximum synthetic time for plotting 
    syn_u=cell2mat(data(1,8));
    %syn_u = syn_u(1:2000);
    syn_v=cell2mat(data(1,9));
     %syn_v = syn_v(1:2000);
    syn_w=cell2mat(data(1,10));
     %syn_w = syn_w(1:2000);
    
    %get same channel
   
  if(channel0 == 'Z')
     data_syn = syn_w;
  end
  if(channel0 == 'N')
     data_syn = syn_v;
  end
  if(channel0 == 'E')
     data_syn = syn_u;
   end
end