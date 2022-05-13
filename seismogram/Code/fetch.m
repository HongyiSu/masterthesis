%Hongyi Su, M.Sc. candidate at LMU @ TUM 

function [data_obs data_syn obs_t syn_t fs_obs fs_syn max_syn_t max_obs_t chan station] = fetch_data(j,obs_list, syn_list,channel)

    %import observational data
    obs_name = char(obs_list(j));
    prefix = obs_name(1:12);
    postfix = obs_name(14:end);
    obs_final_name = [prefix channel postfix];


    obs = fread_sac(['/Users/hongyisu/Desktop/masterthesis/seismogram/obs/' obs_final_name]);
    obs_t = obs.t;
    obs_t = obs.t-obs.t(1);%make sure it starts from 0, for some stations, start time is not 0 second
    fs_obs = 1/(obs.t(2)-obs.t(1)); %return sampling frequency of observational waveform, also obs.hdr.delta
    max_obs_t = max(obs_t); %return corrected maximum observational time for plotting 
    
    chan = obs_final_name(11:13);
    station = obs_final_name(4:8);

    data_obs = obs.data;

    %import synthetic data (SeisSol FORMAT)
    % VARIABLES = "Time","xx","yy","zz","xy","yz","xz","u","v","w"
    fid  = fopen(['/Users/hongyisu/Desktop/masterthesis/seismogram/syn/' char(syn_list(j))]);
    data = textscan(fid,'%f%f%f%f%f%f%f%f%f%f','Delimiter','\t','HeaderLines',5);
    fid = fclose(fid);
    syn_t=cell2mat(data(1,1)); 
    fs_syn = 1/(syn_t(2)-syn_t(1)); %return sampling frequency of synthetic waveform
    max_syn_t = max(syn_t); %return corrected maximum synthetic time for plotting 
    syn_u=cell2mat(data(1,8));
    syn_v=cell2mat(data(1,9));
    syn_w=cell2mat(data(1,10));
    
    %get same channel
   
  if(chan == 'BHZ')
     data_syn = syn_w;
  end
  if(chan == 'BHN')
     data_syn = syn_v;
  end
  if(chan == 'BHE')
     data_syn = syn_u;
   end
end