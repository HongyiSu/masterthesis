%Hongyi Su, M.Sc. candidate at LMU @ TUM 

function [data_obs data_syn obs_t syn_t fs_obs fs_syn max_syn_t max_obs_t station] = fetch(j,obs_list, syn_list,channel0, station)

    chan = channel0;
    obs_name = char(obs_list(j));
    sta_name= obs_name(1:5);
    station = sta_name;

    if(channel0=='Z') %0e 1n 2z
        data_obs_read = load(['../obs/data_filtered/data_60s_filtered-' sta_name '_2' '.mat']);
        data_syn_read = load(['../syn/syn_filtered/Model-R6-' sta_name '_2' '.mat']);

        %data_syn_read = load(['../syn/syn_filtered/Model-L4-' sta_name '_2' '.mat']);
    end 

    if(channel0=='E') %0e 1n 2z
        data_obs_read = load(['../obs/data_filtered/data_60s_filtered-' sta_name '_0' '.mat']);
        data_syn_read = load(['../syn/syn_filtered/Model-R6-' sta_name '_0' '.mat']);
      %  data_syn_read = load(['../syn/syn_filtered/Model-L4-' sta_name '_0' '.mat']);
    end

     if(channel0=='N') %0e 1n 2z
        data_obs_read = load(['../obs/data_filtered/data_60s_filtered-' sta_name '_1' '.mat']);
        data_syn_read = load(['../syn/syn_filtered/Model-R6-' sta_name '_1' '.mat']);
      %  data_syn_read = load(['../syn/syn_filtered/Model-L4-' sta_name '_1' '.mat']);
     end


     data_syn =  data_syn_read.data;
     data_obs =  data_obs_read.data;
     syn_t = linspace(0,str2num(data_syn_read.npts)*str2num(data_syn_read.delta),str2num(data_syn_read.npts));
     obs_t = linspace(0,str2num(data_obs_read.npts)*str2num(data_obs_read.delta),str2num(data_obs_read.npts));
     fs_syn  = str2num(data_syn_read.sampling_rate);
     fs_obs  = str2num(data_obs_read.sampling_rate);
     max_obs_t = max(obs_t);
     max_syn_t = max(syn_t);
     station =  sta_name;


     
end
