function [data_obs_d_f,data_syn_d_f]=filter_mydata(data_obs, data_syn, fs_obs, fs_syn, m, n)       
     
    
     %filtering
     %Design a 4th-order butterworth band-pass filter which passes
     %frequencies between 0.001 and 0.5 Hz   
%      m=0.1; %define low cut
%      n=0.5; %define high cut
     [b,a] = butter(2,[m/fs_obs/2 n/fs_obs/2], 'bandpass');
     data_obs_f = filter(b,a,data_obs);
     [b,a] = butter(2,[m/fs_syn/2 n/fs_syn/2], 'bandpass');
     data_syn_f = filter(b,a,data_syn);
     %detrending
     data_obs_d_f = detrend(data_obs_f);
     data_syn_d_f = detrend(data_syn_f);

end