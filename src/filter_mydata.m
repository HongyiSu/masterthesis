function [data_obs_d_f,data_syn_d_f]=filter_mydata(data_obs, data_syn, m, n)  
     
     
     
     %detrending
     data_obs_d = detrend(data_obs);
     data_syn_d = detrend(data_syn);
     %filtering
     %Design a 4th-order butterworth band-pass filter which passes
     %frequencies between 0.001 and 0.5 Hz   
%      m=0.1; %define low cut
%      n=0.5; %define high cut
     [b,a] = butter(2,[m n], 'bandpass');
     data_obs_d_f = filter(b,a,data_obs_d);
     data_syn_d_f = filter(b,a,data_syn_d);

end