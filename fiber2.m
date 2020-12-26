%%%%% Optical fiber travel Propagation transmit %%%%%
function dawdz = fiber2(~,aw,~,w,t,Beta2,Gamma,Es_g,Dw_g) 
at = fft(aw);
g = G0./(1+trapz(t,abs(at).^2)/Es_g);   % constant
c=(0.5*1i)*Beta2.*(w.^2).*aw;
d=-(0.5*g./(Dw_g)^2).*(w.^2).*aw;
dawdz=c(end)+d(end)+g.*aw+ifft(+1i*Gamma*(abs(at)).^2.*at);
end