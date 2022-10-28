function my_plot(obs_t, data_obs_d_f, syn_t, data_syn_d_f,max_obs_t,max_syn_t, station, chan, shift,j,k )
       
     plot(obs_t-shift,data_obs_d_f/max(abs(data_obs_d_f)),'r','LineWidth', 1.5);
%     plot(obs_t-shift,data_obs_d_f,'r','LineWidth', 1.5);
     if(j==1)
        th = title(strcat("BH",chan),'FontSize', 25,'fontweight','bold');
        titlePos = get(th ,'position');
        titlePos(2)= 1.5;
    %    titlePos(2) = 1.5*max(max(data_obs_d_f), max(data_syn_d_f));
        titlePos(1) = 30;
        set(th , 'position' , titlePos);
     end
     if(k==1)
        text(-20,-1,['\bf' station],'FontSize', 20);
 %       text(-30,0,['\bf' station],'FontSize', 20);

    end

     box off;
     axis off ;
     xlim([0,60]);
     xticks([0 20 40 60]);
     ylim([-4,2])
     
     %scale filtered observational data this factor written on the plot to get filtered synthetic data
     po1 = max(max_obs_t,max_syn_t); %for place the text
     text(60, 3, num2str(round(max(abs(data_syn_d_f))/max(abs(data_obs_d_f)),2)), 'FontSize', 16);

hold on

     %now plot synthetic data
    plot(syn_t,data_syn_d_f/max(abs(data_syn_d_f))-2,'k','LineWidth', 1.5); 
%     plot(syn_t,data_syn_d_f,'k','LineWidth', 1.5);
     box off
     axis off ;
     set(gcf,'color','w');
     
    if(j==7)
     axis on;
     set(gca,'YColor','none');
     xlabel('Time [second]', 'FontSize', 18, 'FontWeight','bold');
     a = get(gca,'XTickLabel');  
     set(gca,'XTickLabel',a,'fontsize',16,'FontWeight','bold')
     set(gca,'XTickLabelMode','auto');
    end
     
     hold off
end
   