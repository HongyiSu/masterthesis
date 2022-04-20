function [data_obs_d_f,data_syn_d_f]=filter_mydata( data_obs, data_syn, m, n)  
% 
%      i =list_5_j;
% 
%      channel = channel_3_k;
%      station = obs_list{i};
%         
%      [data_obs data_syn obs_t syn_t fs_obs fs_syn max_syn_t max_obs_t] = fetch_data(obs_list{i},syn_list{i}, channel, syn);
%      data_obs = data_obs/100; % in this specific study, unit conversion from cm>m
%      
     
     
     %detrending
     data_obs_d = detrend(data_obs);
     data_syn_d = detrend(data_syn);
     %filtering
     %Design a 4th-order butterworth band-pass filter which passes
     %frequencies between 0.001 and 0.5 Hz   
%      m=0.001; %define low cut
%      n=0.5; %define high cut
     [b,a] = butter(2,[m n], 'bandpass');
     data_obs_d_f = filter(b,a,data_obs_d);
     data_syn_d_f = filter(b,a,data_syn_d);

end