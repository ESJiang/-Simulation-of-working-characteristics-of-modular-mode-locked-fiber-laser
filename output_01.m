%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
yw01 = abs(fftshift(moniw_01)).^2;
yw02 = abs(fftshift(moniw_02)).^2;
yw03 = abs(fftshift(moniw_03)).^2;
yw04 = abs(fftshift(moniw_04)).^2;
yw05 = abs(fftshift(moniw_05)).^2;
yw06 = abs(fftshift(moniw_06)).^2;

yt01 = abs(monit_01).^2;
yt02 = abs(monit_02).^2;
yt03 = abs(monit_03).^2;
yt04 = abs(monit_04).^2;
yt05 = abs(monit_05).^2;
yt06 = abs(monit_06).^2;
%%%%%%%%%%%%%%%%%%%%%%%%% 经增益光纤后的时域脉冲%%%%%%%%%%%%%%%%%%%
moni_02_norm=(abs(monit_02(1:length(t)).^2)/max(abs(monit_02)).^2);
energyt=trapz(t',moni_02_norm);
moni_02_norm = yt02/max(yt02);

figure(4)
plot(t,moni_02_norm,'b','linewidth',2)
set(gca,'XLim',[-40,40],'FontSize',14,'FontName','Times New Roman','FontWeight','bold')
xlabel('Time(ps)'), ylabel('Intensity(W)')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%% 经增益后的脉冲光谱%%%%%%%%%%%%%%%%%%%%%%%
figure(5)
plot(lmda,abs(fftshift(moniw_02(1:length(t)))).^2,'k','linewidth',2);
plot(lmda,yw02,'r','linewidth',2);
set(gca,'FontSize',14,'FontName','Times New Roman','FontWeight','bold')
set(gca,'XLim',[-40,40]);xlabel('Spectrum(nm)'), ylabel('Intensity(W)','FontSize',14,...
    'FontName','Times New Roman','FontWeight','bold')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%经增益后的脉冲以及频率啁啾%%%%%%%%%%%%%%%%%%%
figure(6)
chirp = -diff(phase(monit_02))/(t(2)-t(1));
[ax,h1,h2]=plotyy(t,(abs(monit_02)).^2,t,[0 chirp]);
set(h1,'linestyle','-','color','b','linewidth',2);
set(h2,'linestyle','--','color','g','linewidth',2);
%set(gca,'FontSize',14,'FontWeight');
set(gca,'XLim',[-40,40]);
%set(ax(1),'FontSize',14,'FontWeight','Bold');
ylabel(ax(2),'Frequency Chirp(THz)'),
xlabel('Time(ps)'), ylabel('Intensity(W)')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%不同位置处的光谱和脉冲形状%%%%%%%%%%%%%%%%%%%
figure(7)
plot(lmda,yw01,'-',lmda,yw02,'--',lmda,yw03,':',lmda,yw04,'-.',lmda,yw05,lmda,yw06,'LineWidth',2);
set(gca,'XLim',[-40,40],'FontSize',14,'FontName','Times New Roman','FontWeight','bold')
xlabel('Wavelength(nm)'), ylabel('Intensity(W)')
h1=legend('YDF before','YDF after','SA before','SA after','Filter before','Filter after'); % ,'markersize',0
set(h1,'Box','off');
% xlim([990 1090]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(8) 
plot(t,yt01,t,yt02,'--',t,yt03,':',t,yt04,'-.',t,yt05,t,yt06,'LineWidth',2);
set(gca,'XLim',[-40,40],'FontSize',14,'FontName','Times New Roman','FontWeight','bold')
xlabel('time(ps)'), ylabel('Intensity(W)')
h1=legend('YDF before','YDF after','SA before','SA after','Filter before','Filter after');
set(h1,'Box','off');
% xlim([990 1090]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%