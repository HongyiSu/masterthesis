function my_plot_syn(syn_t, data_syn_d_f, max_syn_t, station, chan, shift,j,k )
       
      plot(syn_t,data_syn_d_f,'k','LineWidth', 10); 

      set(gca,'XColor','none');
      b = get(gca,'YTickLabel');  
      set(gca,'YTickLabel',b,'fontsize',60,'FontWeight','bold')
      set(gca,'YTickLabelMode','auto');
      %ylim([-2e-3, 2e-3]);

    % if(j==1)
    %    chann = strcat("BH",chan);
     %   th = title(chann,'FontSize', 100,'fontweight','bold');
      %  titlePos = get(th ,'position');
      %  titlePos(2) = 1.6*max(data_syn_d_f);
      %  titlePos(1) = 20;
      %  set(th, 'position' , titlePos);
    % end

    if(k==1)
        h = text(-30,0,['\bf' station],'FontSize', 80);
        set(h,'Rotation',90);
        set(gca,'YColor','k');
        ylabel('Velocity [m/s]', 'FontSize', 50, 'FontWeight','bold');
    end

  
     box off
     %axis off ;
     set(gcf,'color','w');
     
    if(j==16)
     %axis on;
     set(gca,'XColor','k');
     xlabel('Time [second]', 'FontSize', 50, 'FontWeight','bold');
     %a = get(gca,'XTickLabel');  
     %set(gca,'XTickLabel',a,'fontsize',60,'FontWeight','bold')
     %set(gca,'XTickLabelMode','auto');
    end
     
end
   