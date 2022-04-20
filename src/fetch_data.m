%Hongyi Su, M.Sc. candidate at LMU @ TUM 
%Supervisors: Taufiqurrahman taufiqurrahman, Alice-Agnes Gabriel
%
%This function is used for return the desired observational & syntheic data,
%as well as their smapling frequency [Hz] and duration [seconds]
%
%Input: f.ex. obs_sta = 'wads', f.ex. syn_sta = 'receiver-00005', channel = {'EW', 'NS', 'Vertical'}
%Output: data_obs, data_syn, fs_obs, fs_syn, max_syn_t, max_obs_t;

function [data_obs data_syn obs_t syn_t fs_obs fs_syn max_syn_t max_obs_t] = fetch_data(obs_sta,syn_sta, channel, syn)

    %import observational data
    obs = importdata([pwd '/data/obs/datanew/' obs_sta]);
    obs_t = obs.data(:,1); 
    obs_t = obs_t-obs_t(1);%make sure it starts from 0, for some stations, start time is not 0 second
    fs_obs = 1/(obs_t(2)-obs_t(1)); %return sampling frequency of observational waveform
    max_obs_t = max(obs_t); %return corrected maximum observational time for plotting 
    obs_ns = obs.data(:,2);
    obs_ew = obs.data(:,3);
    obs_v = obs.data(:,4);
   
    %import synthetic data (SeisSol FORMAT)
    % VARIABLES = "Time","xx","yy","zz","xy","yz","xz","u","v","w"
    fid  = fopen(['data/' syn '/datanew/' syn_sta]);
    %syn_1D_rock
    %syn_1D_soil
    data = textscan(fid,'%f%f%f%f%f%f%f%f%f%f','Delimiter','\t','HeaderLines',5);
    fid = fclose(fid);
    syn_t=cell2mat(data(1,1)); 
    fs_syn = 1/(syn_t(2)-syn_t(1)); %return sampling frequency of synthetic waveform
    max_syn_t = max(syn_t); %return corrected maximum synthetic time for plotting 
    syn_u=cell2mat(data(1,8));
    syn_v=cell2mat(data(1,9));
    syn_w=cell2mat(data(1,10));
    
    %get desired channel
    %perform unit conversion, acceleration to velcocity conversion
   if(strmatch(channel, 'Vertical'))
        data_obs = (obs_t(2)-obs_t(1))*cumtrapz(obs_v);
        data_syn = syn_w;
    elseif (strmatch(channel, 'NS'))
        data_obs = (obs_t(2)-obs_t(1))*cumtrapz(obs_ns);
        data_syn = syn_v;
    elseif (strmatch(channel, 'EW'))
        data_obs = (obs_t(2)-obs_t(1))*cumtrapz(obs_ew);
        data_syn = syn_u;
   end
end
