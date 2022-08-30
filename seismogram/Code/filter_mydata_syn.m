function [data_syn_d_f]=filter_mydata_syn(data_syn, fs_syn, m, n)       
     
    
     data_syn_d = detrend(data_syn);

     %[b1,a1] = butter(2,[m/fs_obs/2 n/fs_obs/2], 'bandpass');
     %data_obs_d_f = filter(b1,a1,data_obs_d);

     [b2,a2] = butter(2,[m/(fs_syn/2) n/(fs_syn/2)], 'bandpass'); %4th order
     data_syn_d_f = filter(b2,a2,data_syn_d);
end