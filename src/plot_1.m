%%import data
fid  = fopen(['seismogram/botswana_model1_60s-receiver-00001-00002.dat']);
data = textscan(fid,'%f%f%f%f%f%f%f%f%f%f','Delimiter','\t','HeaderLines',5);
fid = fclose(fid);
syn_t=cell2mat(data(1,1)); 
fs_syn = 1/(syn_t(2)-syn_t(1)); %return sampling frequency of synthetic waveform
max_syn_t = max(syn_t); %return corrected maximum synthetic time for plotting 
syn_u=cell2mat(data(1,8));
syn_v=cell2mat(data(1,9));
syn_w=cell2mat(data(1,10));

%%filter data


shift = 0;
%%plot data
plot(syn_t-shift,data_syn_d_f/max(abs(data_syn_d_f))-2,'k','LineWidth', 1.2); 
    % if(j==1)
    %    title([char(channel)],'FontSize', 20,'fontweight','bold');
    % end
 xlim([0,60]);
 box off
 axis off ;
 set(gcf,'color','w');
