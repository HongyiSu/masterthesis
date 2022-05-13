function my_plot(obs_t, data_obs_d_f, syn_t, data_syn_d_f,max_obs_t,max_syn_t, station, chan, shift,j,k )
       
     plot(obs_t,data_obs_d_f/max(abs(data_obs_d_f)),'r','LineWidth', 1.2);
     if(j==1)
        th = title(chan,'FontSize', 20,'fontweight','bold');
        titlePos = get(th ,'position');
        titlePos(2) = 1.5;
        set(th , 'position' , titlePos);
     end
     if(k==1)
        text(-400,-1,['\bf' '\it' station],'FontSize', 18);
    end

     box off;
     %axis off ;
     %xlim([0,60]);

    % text(-6,-1,['\bf' '\it' station '(' chan ')'],'FontSize', 18);
     
     %scale filtered observational data this factor written on the plot to get filtered synthetic data
     po1 = max(max_obs_t,max_syn_t); %for place the text
     text(0.8*max_obs_t,1,num2str((max(abs(data_syn_d_f))/max(abs(data_obs_d_f)))), 'FontSize', 16);
    
hold on

     %now plot synthetic data
    
     plot(syn_t-shift,data_syn_d_f/max(abs(data_syn_d_f))-2,'k','LineWidth', 1.2); 
     
     %xlim([0,60]);
     box off
     axis off ;
     set(gcf,'color','w');
     
     hold off
end
   