%Hongyi Su, M.Sc. candidate at LMU @ TUM 

function [data_syn syn_t fs_syn max_syn_t station] = fetch_data(j,obs_list, syn_list,channel0)

    %import observational data
    obs_name = string(obs_list(j));%char(obs_list(j));
    sta_name= obs_name;
    station =  sta_name;

%     if(channel0=='Z') %0e 1n 2z
%         %load ../obs/case2/data-NE208_new_2.mat;
%         load(['../obs/data-' sta_name '_2' '.mat'])
%         data_obs =data;
%         obs_t = linspace(0,str2num(npts)*str2num(delta),str2num(npts));
%         fs_obs  = str2num(sampling_rate);
%         max_obs_t = max(obs_t);
         %chan = channel;
%         station =  sta_name;
%     end
%     if(channel0=='E') %0e 1n 2z
%         load(['../obs/data-' sta_name '_0' '.mat'])
%         data_obs =data;
%         obs_t = linspace(0,str2num(npts)*str2num(delta),str2num(npts));
%         fs_obs  = str2num(sampling_rate);
%         max_obs_t = max(obs_t);
%         chan = channel;
%         station =  sta_name;
%      end
%      if(channel0=='N') %0e 1n 2z
%         load(['../obs/data-' sta_name '_1' '.mat'])
%         data_obs =data;
%         obs_t = linspace(0,str2num(npts)*str2num(delta),str2num(npts));
%         fs_obs  = str2num(sampling_rate);
%         max_obs_t = max(obs_t);
%         chan = channel;
%         station =  sta_name;
%     end
    
     


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