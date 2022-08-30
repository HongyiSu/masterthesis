function my_spectrum_syn(data_syn_d_f, station, channel,fs_syn, j,k)
     
     ns_syn = length(data_syn_d_f);
     f_syn = fs_syn*(0:ns_syn/2)/ns_syn;%sample individual frequency
     F_syn=fft(data_syn_d_f);%perform Fourier Transformation with fft
     A_syn=abs(F_syn(1:ns_syn/2+1));%take absolute value
     

    loglog(f_syn,A_syn, 'k','LineWidth', 5);
    
  
    % ylim([10^-8 10^2]);
   % hold on

    %loglog(f_syn,A_syn, 'k');
    %ylim([10^-14 10^-6])
    
    %xlim([0 10^2])
    
    if(j==16)
        xticks([10^-2 10^-1 10^0 10^1]);
        xlabel('Frequency[Hz]','FontSize', 60,'Fontweight','bold');
        %a = get(gca,'XTickLabel');  
        %set(gca,'XTickLabel',a,'fontsize',18,'FontWeight','bold')
        %set(gca,'XTickLabelMode','auto');
        a = get(gca,'XTickLabel');  
        set(gca,'XTickLabel',a,'fontsize',60,'FontWeight','bold')
        set(gca,'XTickLabelMode','auto');
    elseif(j==9)
        title(strcat("BH", channel),'FontSize', 60,'fontweight','bold')
        set(gca,'Xticklabel',[])
    else
        set(gca,'Xticklabel',[])
    end

    if(k==1)
        %ylim([10^-10, 10^1])
        %yticks([10^-8 10^-6 10^-4 10^-2 10^0]);
        ylabel(station,'FontSize', 60,'fontweight','bold')
        
        a = get(gca,'YTickLabel');  
        set(gca,'YTickLabel',a,'fontsize',60,'FontWeight','bold')
        set(gca,'YTickLabelMode','auto');
    else
        yticks([]);
        set(gca,'YColor','none')
    end

    set(gca,'box','off')
    set(gcf,'color','w');
    grid on
    set(gca,'YGrid', 'off')
    set(gca, 'xminorgrid', 'on')
    set(gca,'MinorGridLineStyle','-')
    set(gca,'GridLineStyle','-')
end