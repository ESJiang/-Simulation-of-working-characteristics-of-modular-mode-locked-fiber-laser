function YDF(block)
setup(block);

function setup(block)
block.NumDialogPrms = 4;
block.NumInputPorts=1;
block.NumOutputPorts=1;
block.SetPreCompInpPortInfoToDynamic;
block.SetPreCompOutPortInfoToDynamic;
block.InputPort(1).DirectFeedthrough=true;
block.SampleTimes=[-1 0];
block.SimStateCompliance='DefaultSimState';
block.SetAccelRunOnTLC(true);
block.RegBlockMethod('Outputs',@Output);

function Output(block) 
g_L_g = block.DialogPrm(1).Data;
g_B2_g = block.DialogPrm(2).Data;
g_Gm_g=block.DialogPrm(3).Data;
g_Dx_g=block.DialogPrm(4).Data;
T = 80;            % Span in time domain unit: ps   定义了自变量范围（时域谱）
N = 2^10;          % Number of sample points       omega采样点的数目
t_temp = linspace(-T/2,T/2,N+1)';     % Time vector   1025个点
t = t_temp(1:N);   % Time series      1024个点（步数）
omega = (2*pi/T.*(-N/2:1:(N/2-1)))'; 
w=fftshift(omega);
Lambda0 = 1030e-9;%  unit: m  中心波长
Dw_g = 2*pi*2.998e-4*g_Dx_g/Lambda0^2; 
[~,awz]=ode45('fiber12',[0 g_L_g],block.InputPort(1).Data,[],w,g_B2_g,g_Gm_g,Dw_g);
block.OutputPort(1).Data = awz(end);